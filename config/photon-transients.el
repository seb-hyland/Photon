;; -*- lexical-binding: t; -*-

(defface photon-transient-dynamic-face
  '((t (:foreground "#7FB4CA" :weight bold)))
  "Face for dynamic transients")


(defun photon-C-j ()
  (interactive)
  (when (and (eq evil-state 'visual)
             (eq evil-visual-selection 'screen-line))
    (execute-kbd-macro "G"))
  (end-of-buffer))


(defun photon-C-k ()
  (interactive)
  (when (and (eq evil-state 'visual)
             (eq evil-visual-selection 'screen-line))
    (execute-kbd-macro "gg"))
  (beginning-of-buffer))


(defun photon-toggle ()
  (interactive)
  (if (equal (buffer-name) "*eat*")
      (funcall-interactively 'popper-close-latest)
    (eat)))


(defun photon-delete ()
  (interactive)
  (if (minibufferp)
      (call-interactively 'backward-kill-word)
    (kill-region (point) (line-beginning-position))))


(defun photon-dape ()
  (interactive)
  (let* ((project-name (file-name-nondirectory (directory-file-name (project-root (project-current)))))
	 (executable 
	  (cond ((eq major-mode 'zig-mode)
		 (concat "zig-out/bin/" project-name))
		((eq major-mode 'rust-ts-mode)
		 (concat "target/debug/" project-name))
		(t nil)))
	 (adapter
	  (cond ((eq major-mode 'zig-mode) "gdb")
		((eq major-mode 'rust-ts-mode) "gdb")
		((eq major-mode 'python-ts-mode) "debugpy")
		(t nil))))
    (progn
      (if (eq major-mode 'python-ts-mode)
	  (photon-venv t))
      (if (not adapter)
	  (call-interactively 'dape)
	(minibuffer-with-setup-hook
	    (lambda ()
	      (delete-minibuffer-contents)
	      (insert (if executable
			  (concat adapter " :program \"" executable "\"")
			adapter)))
	  (call-interactively #'dape))))))


(defun photon-eglot ()
  (interactive)
  (if (eq major-mode 'python-ts-mode)
      (photon-venv t))
  (call-interactively 'eglot))


(defun photon-venv (&optional silent)
  (interactive)
  (let ((venv-dir (concat default-directory ".venv")))
    (if (file-directory-p venv-dir)
	(progn
	  (pyvenv-activate venv-dir)
	  (message (concat "The virtual environment at " venv-dir " was activated")))
      (if silent
	  (message "WARNING: No virtual environment was automatically detected.")
	(call-interactively 'pyvenv-activate)))))
  

(transient-define-suffix global-scale-inc ()
  :transient t
  :key "]"
  :description "Increase globally"
  (interactive)
  (global-text-scale-adjust 2) (kbd "<escape>"))

(transient-define-suffix global-scale-dec ()
  :transient t
  :key "["
  :description "Decrease globally"
  (interactive)
  (global-text-scale-adjust -2) (kbd "<escape>"))


(defvar photon-focus-init-buf)
(defvar photon-focus-init-persp)
(defvar photon-focus-state nil)


(defun photon-focus-main ()
  (interactive)
  (photon-focus-buffer)
  (photon/main))

(defun photon-focus-buffer ()
  (interactive)
  (if (equal photon-focus-state nil)
      (progn
        (setq photon-focus-init-buf (current-buffer))
        (setq photon-focus-init-persp (persp-current-name))
        (persp-switch "*FOCUS*")
        (persp-add-buffer photon-focus-init-buf)
        (persp-switch-to-buffer* photon-focus-init-buf)
        (setq photon-focus-state t)
        (define-key photon-keymap (kbd "C-SPC") 'photon-focus-main)
        (define-key evil-normal-state-map (kbd "SPC") 'photon-focus-main)
        (define-key evil-visual-state-map (kbd "SPC") 'photon-focus-main)
     	(with-eval-after-load 'dired
          (define-key dired-mode-map (kbd "<normal-state> SPC") 'photon-focus-main)
          (define-key dired-mode-map (kbd "<visual-state> SPC") 'photon-focus-main))
        )
    (progn
      (persp-switch photon-focus-init-persp)
      (persp-kill "*FOCUS*")
      (setq photon-focus-state nil)
      (define-key photon-keymap (kbd "C-SPC") 'photon/main)
      (define-key evil-normal-state-map (kbd "SPC") 'photon/main)
      (define-key evil-visual-state-map (kbd "SPC") 'photon/main)
      (with-eval-after-load 'dired
     	(define-key dired-mode-map (kbd "<normal-state> SPC") 'photon/main)
     	(define-key dired-mode-map (kbd "<visual-state> SPC") 'photon/main)))))


(defun photon-reindent-buffer ()
  "Indent the entire buffer using tree-sitter's builtin indentation."
  (interactive)
  (save-excursion
    (mark-whole-buffer)
    (indent-for-tab-command)))


(transient-define-prefix photon/main ()
  [:description
   " "
   ["  Open and save files"
    :pad-keys nil
    ("s" "Save current buffer" save-buffer)
    ("S" "󰁣 Save as..." write-file)
    ("o" "Open file..." find-file)
    ("O" "Open project file..." project-find-file)
    ""
    "  Quick commands"
    ("f" "Search in buffer..." ctrlf-forward-default)
    ("F" "󰁣 Search in directory..." consult-ripgrep)
    ("x" "Execute command..." execute-extended-command)
    ("p" "Switch perspective..." persp-switch)
    ]
   ["  Buffer actions"
    ("b" "Switch buffer...     " persp-switch-to-buffer*)
    ("B" "Switch buffer in project...     " project-switch-to-buffer)
    ("k" "Kill current buffer" kill-current-buffer)
    ("l" "Next buffer" next-buffer :transient t)
    ("h" "Previous buffer" previous-buffer :transient t)
    ""
    ("z" "Focus current buffer" photon-focus-buffer)
    ("q" "Close current window" (lambda () (interactive) (delete-window) (balance-windows)))
    ("u" "Update current buffer" revert-buffer-quick)
    ]
   ["  Keybind sets"
    ("w" "   Window settings..." photon/window)
    ("RET" "   Coding tools..." photon/coding)
    ("g" " 󰊢  Magit..." photon/magit)
    ]])


(transient-define-prefix photon/coding ()
  [" "
   ["󰖟  LSP tools"
    ("e" "Activate LSP" photon-eglot)
    ("r" "Rename symbol" eglot-rename)
    ("f" "Find declaration" eglot-find-declaration)
    ("<tab>" "Reindent buffer" photon-reindent-buffer)
    ]
   [
    "  Debugger tools"
    ("i" "Initialize all" (lambda () (interactive) (call-interactively 'eglot) (photon-dape) (revert-buffer-quick))) 
    ("d" "Begin debugging" photon-dape)
    ("b" "Insert breakpoint at point" dape-breakpoint-toggle)
    ("c" "Insert conditional break at point" dape-breakpoint-expression)
    ]
   [
    "󰣪  Build tools"
    ("RET" "Compile" compile)
    ("S-<return>" "Recompile" recompile)
    ("v" "Activate virtual environment..." photon-venv)
    ]])


(transient-define-prefix photon/window ()
  [" "
   ["󱂬  Manage windows"
    ("r" "Create on right" (lambda () (interactive) (split-window-right) (balance-windows)))
    ("b" "Create below" (lambda ()
      			  (interactive)
      			  (split-window-below)
      			  (balance-windows)))
    ("=" "Rebalance window sizes" balance-windows)
    ]
   ["  Text scaling"
    ("+" "Increase in current buffer" text-scale-increase :transient t)
    ("_" "Decrease in current buffer" text-scale-decrease :transient t)
    (global-scale-inc)
    (global-scale-dec)]
   ])


(transient-define-prefix photon/magit ()
  [""
   ["󰓾 Core functions"
    ("s" "Status" magit-status)
    ("f" "Fetch upstream" magit-fetch-from-upstream)
    ("u" "Push upstream" magit-push-current-to-upstream)
    ("p" "Pull from upstream" magit-pull-from-upstream)
    ]
   [
    " Other functions"
    ("b" "Branches..." magit-branch)
    ("c" "Commit" magit-commit-create)
    ("d" "Diff" magit-diff-dwim)
    ]
   [
    ""
    ("F" "Fetch..." magit-fetch)
    ("U" "Push..." magit-push)
    ("P" "Pull..." magit-pull)
    ]])
