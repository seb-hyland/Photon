;; -*- lexical-binding: t; -*-

(defvar photon-keymap (make-keymap)
    "Keymap for Photon general bindings")


;; Clean up the window, set basic properties
(setq inhibit-startup-message t
    visible-bell nil
    ring-bell-function 'ignore
    frame-title-format nil
    default-frame-alist '((width . 200)
			     (height . 35)
			     (undecorated-round . t)
			     (drag-internal-border . t)
			     (internal-border-width . 4)
			     (drag-with-mode-line . t))
    display-line-numbers-type 'relative
    split-width-threshold 1
    delete-by-moving-to-trash t
    create-lockfiles nil
    lisp-indent-offset 4
    scroll-step 1
    auth-sources '("~/.authinfo")
    custom-file (file-name-concat user-emacs-directory "custom.el"))
(setq-default display-line-numbers-width 4
    display-fill-column-indicator-column 120)

(scroll-bar-mode -1)   		        
(tool-bar-mode -1)     		        
(tooltip-mode -1)                            	        
(menu-bar-mode -1)
(global-auto-revert-mode t)
(column-number-mode t)

(global-set-key (kbd "<escape>") 'keyboard-escape-quit)
(set-face-attribute 'default nil :family "JetBrainsMono Nerd Font" :height 150)
(set-face-attribute 'fixed-pitch nil :family "JetBrainsMono Nerd Font" :height 150)
(set-face-attribute 'variable-pitch nil :family "JetBrainsMono Nerd Font" :height 150)
(set-face-attribute 'variable-pitch-text nil :height 150)
(prefer-coding-system 'utf-8)
(global-visual-line-mode t)
(menu-bar--display-line-numbers-mode-visual)
(setq make-backup-files nil
    create-lockfiles nil)

(defun init-message ()
    (interactive)
    (let* ((current-hour (decoded-time-hour (decode-time)))
	      (night-message "May the midnight oil burn bright.")
	      (component (cond
			     ((< current-hour 5) night-message)
			     ((< current-hour 10) "Rise to the light of a new day.")
			     ((< current-hour 13) "As the zenith rises and falls, falter not.")
			     ((< current-hour 17) "As the shadows lengthen, pay heed to the falling leaves.")
			     ((< current-hour 22) "Look up, and marvel at the infinite and forever light.")
			     (t night-message)))
	      (message-contents (concat "Welcome, 11000011010. " component "\n"
				    (format-time-string "%H:%M:%S %m/%d"))))
	(message message-contents)))

(defun cleanup-buffers ()
    (interactive)
    (if (eq (length command-line-args) 1)
	(dolist (buf (buffer-list))
	    (let ((name (buffer-name buf)))
		(unless (member name '("*Warnings*" "*dashboard*"))
		    (kill-buffer buf))))))

(add-hook 'window-setup-hook (lambda ()
				 (global-display-line-numbers-mode t)
				 (display-line-numbers-mode -1)
				 (load-theme 'photon-dark t)
				 (revert-buffer-quick)
				 (cleanup-buffers)
				 (init-message)))

(add-hook 'prog-mode-hook (lambda ()
			      (electric-pair-mode t)
			      (display-fill-column-indicator-mode)
			      (visual-line-mode -1)
			      (setq truncate-lines t)))

