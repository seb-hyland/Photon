;; -*- lexical-binding: t; -*-

(defvar photon-keymap (make-keymap)
  "Keymap for Photon general bindings")


;; Clean up the window, set basic properties
(setq inhibit-startup-message t
      visible-bell t
      frame-title-format nil
      default-frame-alist '((width . 200)
			    (height . 35)
			    (undecorated . t)
			    (alpha-background . 98)
			    (drag-internal-border . t)
			    (internal-border-width . 4)
			    (drag-with-mode-line . t))
      display-line-numbers-type 'relative
      split-width-threshold 1
      delete-by-moving-to-trash t
      create-lockfiles nil)
(setq-default display-line-numbers-width 3
	      display-fill-column-indicator-column 90)

(scroll-bar-mode -1)   		        
(tool-bar-mode -1)     		        
(tooltip-mode -1)                            	        
(menu-bar-mode -1)
(global-auto-revert-mode t)
(column-number-mode t)

(global-set-key (kbd "<escape>") 'keyboard-escape-quit)
(set-face-attribute 'default nil :family "JetBrainsMono Nerd Font" :height 125)
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
		     ((< current-hour 16) "As the shadows lengthen, pay heed to the falling leaves.")
		     ((< current-hour 20) "Look up, and marvel at the infinite and forever light.")
		     (t night-message)))
	 (message-contents (concat "Welcome, 11000011010. " component "\n"
				   (format-time-string "%H:%M:%S %m/%d"))))
    (message message-contents)))

(add-hook 'window-setup-hook (lambda ()
                                (global-display-line-numbers-mode t)
                                (display-line-numbers-mode -1)
				(load-theme 'photon-dark t)
                                (make-frame-visible)
				(revert-buffer-quick)
				(init-message)))

(add-hook 'prog-mode-hook (lambda ()
			    (electric-pair-mode t)
			    (display-fill-column-indicator-mode)
			    (visual-line-mode -1)
			    (setq truncate-lines t)
			    (setq flymake-show-diagnostics-at-end-of-line t)))

