(defvar photon-keymap (make-keymap)
  "Keymap for Photon general bindings")


;; Clean up the window, set basic properties
(setq inhibit-startup-message t
      visible-bell t
      frame-title-format nil
      default-frame-alist '((width . 200)
			    (height . 35)
			    (undecorated . t)
			    (alpha-background . 95)
			    (drag-internal-border . t)
			    (internal-border-width . 4)
			    (drag-with-mode-line . t))
      display-line-numbers-type 'relative
      split-width-threshold 1
      delete-by-moving-to-trash t
      create-lockfiles nil)

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
(electric-pair-local-mode t)
(setq make-backup-files nil
      create-lockfiles nil)

(add-hook 'emacs-startup-hook (lambda ()
                                (global-display-line-numbers-mode t)
                                (display-line-numbers-mode -1)
                                (load-theme 'photon-dark t)))
