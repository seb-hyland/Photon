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


(defun photon-C-c ()
  (interactive)
  (execute-kbd-macro (kbd "C-c C-c")))


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
    ("u" "Update current buffer" revert-buffer-quick)
    ]
   ["  Keybind sets"
    ("w" "   Window settings..." photon/window)
    ("c" "   Coding tools..." photon/coding)
    ("g" " 󰊢  Magit..." photon/magit)
    ]]
  )


(transient-define-prefix photon/coding ()
  [" "
   ["  Terminal tools"
    ("<return>" "Toggle popup terminal" vterm-toggle)
    ]
   ["󰖟  Language server tools"
    ("a" "Activate LSP" eglot)
    ("r" "Rename symbol" eglot-rename)
    ("f" "Find declaration" eglot-find-declaration)
    ("<tab>" "Reindent buffer" photon-reindent-buffer)
    ]])

(transient-define-prefix photon/window ()
  [" "
   ["󱂬  Manage windows"
    ("r" "Create on right" (lambda ()
      			     (interactive)
      			     (split-window-right) 
      			     (balance-windows)))
    ("b" "Create below" (lambda ()
      			  (interactive)
      			  (split-window-below)
      			  (balance-windows)))
    ("q" "Close current window" (lambda ()
      				  (interactive)
      				  (delete-window) 
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
