;; -*- lexical-binding: t; -*-

;; Pin bindings
(defun set-pin (varname)
  (interactive "S")
  (set varname (cons (current-buffer) (persp-current-name))))

(defun goto-pin (varname)
  (interactive "S")
  (let ((val (symbol-value varname)))
    (persp-switch (cdr val))
    (switch-to-buffer (car val))))

(defvar pin-u nil)
(defvar pin-i nil)
(defvar pin-o nil)
(defvar pin-p nil)

(defun goto-pin-u () (interactive) (goto-pin 'pin-u))
(defun goto-pin-i () (interactive) (goto-pin 'pin-i))
(defun goto-pin-o () (interactive) (goto-pin 'pin-o))
(defun goto-pin-p () (interactive) (goto-pin 'pin-p))

(defun set-pin-u () (interactive) (set-pin 'pin-u))
(defun set-pin-i () (interactive) (set-pin 'pin-i))
(defun set-pin-o () (interactive) (set-pin 'pin-o))
(defun set-pin-p () (interactive) (set-pin 'pin-p))


(defun photon-C-j ()
  (interactive)
  (if (eq evil-state 'visual)
    (execute-kbd-macro "G")
    (end-of-buffer)))


(defun photon-C-k ()
  (interactive)
  (if (eq evil-state 'visual)
    (execute-kbd-macro "gg")
    (beginning-of-buffer)))


(defun photon-toggle ()
  (interactive)
  (let ((win (get-buffer-window "*eat*" t)))
    (if win
	(progn
	  (delete-window win)
	  (balance-windows))
      (eat))))


(defun photon-delete-word ()
  (interactive)
  (call-interactively 'backward-kill-word))

(defun photon-delete ()
  (interactive)
  (delete-region (point) (line-beginning-position)))


(defun photon-dape ()
  (interactive)
  (let* ((project-name (file-name-nondirectory (directory-file-name (project-root (project-current)))))
	 (executable 
	  (cond ((eq major-mode 'zig-mode)
		 (concat "zig-out/bin/" project-name))
		(t nil)))
	 (adapter
	  (cond ((eq major-mode 'zig-mode) "gdb")
		((eq major-mode 'rustic-mode) "codelldb-rust")
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
  (eglot-tempel-mode t)
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


(defun photon-compile ()
  (interactive)
  (let* ((command (cl-case major-mode
			((rust-mode rust-ts-mode rustic-mode) "cargo run")
			((python-mode python-ts-mode) "python ")
			(t "")))
	 (root (cl-case major-mode
		 ((rust-mode rust-ts-mode rustic-mode) (project-root (project-current)))
		 (t nil)))
	 (default-directory (if root root default-directory))
	 (setup (minibuffer-with-setup-hook
		    (lambda ()
		      (delete-minibuffer-contents)
		      (insert command))
		  (call-interactively 'compile))))))


(defun photon-cargo ()
  (interactive)
  (let ((command "cargo "))
    (compile
     (read-from-minibuffer "Cargo command: " command))))


(defun photon-open-docs ()
  (interactive)
  (if (equal (buffer-name) "*eldoc*")
      (call-interactively 'eglot-open-link)
    (call-interactively 'eldoc-doc-buffer)))


(defun photon-occur ()
  (interactive)
  (call-interactively 'occur)
  (let ((win (get-buffer-window "*Occur*")))
    (select-window win)))


(defun photon-occur-goto-item ()
  (interactive)
  (call-interactively 'occur-mode-goto-occurrence)
  (let ((win (get-buffer-window "*Occur*")))
    (quit-window t win)))


(defun photon-J ()
  (interactive)
  (cond ((eq major-mode 'occur-mode)
	 (progn
	   (occur-next)
	   (occur-mode-display-occurrence)))
	((derived-mode-p 'compilation-mode)
	 (call-interactively 'compilation-next-error))
	((eq evil-state 'visual)
	 (execute-kbd-macro "}"))
	(t (evil-forward-paragraph))))

(defun photon-K ()
  (interactive)
  (cond ((eq major-mode 'occur-mode)
	 (progn
	   (occur-prev)
	   (occur-mode-display-occurrence)))
	((derived-mode-p 'compilation-mode)
	 (call-interactively 'compilation-previous-error))
	((eq evil-state 'visual)
	 (execute-kbd-macro "{"))
	(t (evil-backward-paragraph))))


(defvar photon-focus-init-buf)
(defvar photon-focus-init-persp)
(defvar photon-focus-state nil)

(defun photon-focus-toggle ()
  (interactive)
  (if (equal photon-focus-state nil)
      (progn
        (setq photon-focus-init-buf (current-buffer))
        (setq photon-focus-init-persp (persp-current-name))
        (persp-switch "*FOCUS*")
        (persp-add-buffer photon-focus-init-buf)
        (persp-switch-to-buffer* photon-focus-init-buf)
        (setq photon-focus-state t)
        (define-key evil-normal-state-map (kbd "SPC") 'photon-focus-toggle)
        (define-key evil-visual-state-map (kbd "SPC") 'photon-focus-toggle)
     	(with-eval-after-load 'dired
          (define-key dired-mode-map (kbd "<normal-state> SPC") 'photon-focus-toggle)
          (define-key dired-mode-map (kbd "<visual-state> SPC") 'photon-focus-toggle)))
    (progn
      (persp-switch photon-focus-init-persp)
      (persp-kill "*FOCUS*")
      (setq photon-focus-state nil)
      (evil-set-leader '(normal visual motion) (kbd "SPC"))
      (evil-set-leader '(normal visual motion) (kbd "C-SPC"))
      (with-eval-after-load 'dired
     	(define-key dired-mode-map (kbd "<normal-state> SPC") (lookup-key evil-motion-state-map (kbd "SPC")))
     	(define-key dired-mode-map (kbd "<visual-state> SPC") (lookup-key evil-motion-state-map (kbd "SPC")))))))


(defun photon-reindent-buffer ()
  "Indent the entire buffer using tree-sitter's builtin indentation."
  (interactive)
  (save-excursion
    (mark-whole-buffer)
    (indent-for-tab-command)))
