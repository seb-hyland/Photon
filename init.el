;; (use-package benchmark-init
  ;; :ensure t
  ;; :config
  ;; ;; To disable collection of benchmark data after init is done.
  ;; (add-hook 'after-init-hook 'benchmark-init/deactivate))
(setq gc-cons-threshold most-positive-fixnum)

(setq inhibit-startup-message t)
(scroll-bar-mode -1)   		        
(tool-bar-mode -1)     		        
(tooltip-mode -1)                            	        
(menu-bar-mode -1)	 	     
(column-number-mode t)
(setq visible-bell t)
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)
(set-face-attribute 'default nil :family "JetBrains Mono" :height 110)
(setq frame-title-format nil)
(prefer-coding-system 'utf-8)
(global-visual-line-mode 1)
(setq default-frame-alist
    '((width . 150) (height . 45)))

(add-hook 'emacs-startup-hook (lambda ()
				(global-display-line-numbers-mode 1)
				(display-line-numbers-mode -1)
				(load-theme 'EngMACS-dark t)
				(setq display-line-numbers-type 'relative)
				(menu-bar--display-line-numbers-mode-visual 1)
				))

(unless (file-directory-p "/Local/emacs-auto-saves/")
  (make-directory "/Local/emacs-auto-saves/")) 
(unless (file-directory-p "/Local/Documents/org-roam/")
  (make-directory "/Local/Documents/org-roam/")) 

(setq backup-directory-alist
      '(("." . "/Local/emacs-auto-saves/")))

(setq auto-save-list-file-prefix '("/Local/emacs-auto-saves/")
      auto-save-file-name-transforms '((".*" "/Local/emacs-auto-saves/" t)))

(setq org-roam-directory "/Local/Documents/org-roam")

(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
			 ("org" . "https://orgmode.org/elpa/")
			 ("elpa" . "https://elpa.gnu.org/packages/")))
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents)) 
(add-to-list 'load-path "~/.emacs.d/add-ons/")

(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure t)
(use-package compat)

(use-package autothemer
  :ensure t)
(add-to-list 'custom-theme-load-path "~/.emacs.d/add-ons")

(use-package diminish)
(diminish 'visual-line-mode)

(eval-after-load 'dired '(progn (require 'joseph-single-dired)))
(use-package neotree
  :config
  (setq neo-theme 'icons))

(use-package nerd-icons
  :custom
  (nerd-icons-color-icons t)
  (nerd-icons-scale-factor 1)
  )

(use-package all-the-icons
  :custom
  (all-the-icons-scale-factor 1)
  (all-the-icons-install-fonts)
  )

(use-package shrink-path
  :ensure t
  :demand t
  :diminish)
(require 'doom-modeline)
(require 'doom-modeline-autoloads)
(require 'doom-modeline-core)
(require 'doom-modeline-env)
;; (require 'doom-modeline-pkg)
(require 'doom-modeline-segments)

(add-hook 'emacs-startup-hook (lambda () (doom-modeline-mode 1)))

(custom-set-variables
 '(doom-modeline-major-mode-icon t)
 '(doom-modeline-major-mode-color-icon t)
 '(doom-modeline-buffer-state-icon t)
 '(doom-modeline-buffer-modification-icon t)
 '(doom-modeline-icon t)
 '(doom-modeline-time-icon t)
 '(doom-modeline-time-live-icon t)
 '(doom-modeline-buffer-name t)
 '(doom-modeline-height 40)
 '(doom-modeline-support-imenu t)
 '(doom-modeline-bar-width 6)
 '(doom-modeline-position-column-line-format '("%l:%c"))
 '(doom-modeline-minor-modes t)
 '(doom-modeline-enable-word-count t))

(custom-set-faces
 '(doom-modeline ((t (:family "SF Mono"))))
 '(doom-modeline-bar ((t (:background "#9099AB" :family "SF Mono"))))
 '(doom-modeline-icon ((t (:family "Symbols Nerd Font Mono" :height 100))))
 '(doom-modeline-icon-inactive ((t (:family "Symbols Nerd Font Mono" :height 100))))
 '(mode-line ((t (:family "SF Mono"))))
 '(mode-line-active ((t (:family "SF Mono"))))
 '(mode-line-inactive ((t (:family "SF Mono")))))

(use-package doom-themes
  :defer t
  :ensure t
  :config
  (setq doom-themes-enable-bold t 
	doom-themes-enable-italic t)
  (doom-themes-visual-bell-config))

;; (require 'doom-nano-modeline)
;; (require 'doom-nano-modeline-core)
;; (require 'doom-nano-modeline-misc)
;; (require 'doom-nano-modeline-modes)
;; (setq doom-nano-modeline-mode -1)

;; (custom-set-faces
;; 		 '(doom-nano-modeline-evil-emacs-state-face
;; 		   ((t (:inherit (success bold) :background "dim grey" :foreground "white"))))
;; 		 '(doom-nano-modeline-evil-insert-state-face
;; 		   ((t (:inherit (success bold) :background "dim grey" :foreground "white"))))
;; 		 '(doom-nano-modeline-evil-motion-state-face
;; 		   ((t (:inherit (success bold) :background "dim grey" :foreground "white"))))
;; 		 '(doom-nano-modeline-evil-normal-state-face
;; 		   ((t (:inherit (success bold) :background "dim grey" :foreground "white"))))
;; 		 '(doom-nano-modeline-evil-operator-state-face
;; 		   ((t (:inherit (success bold) :background "dim grey" :foreground "white")))) 
;; 		 '(doom-nano-modeline-evil-replace-state-face
;; 		   ((t (:inherit (success bold) :background "dim grey" :foreground "white"))))
;; 		 '(doom-nano-modeline-evil-visual-state-face
;; 		   ((t (:inherit (success bold) :background "dim grey" :foreground "white"))))
;; 		 '(doom-nano-modeline-major-mode-face
;; 		   ((t (:inherit mode-line-emphasis :background "white smoke"))))
;; 		 '(doom-nano-modeline-vc-branch-name-face
;; 		   ((t (:background "white smoke"))))
;; 		 )

(use-package dashboard
  :ensure t
  :init
  :config
  (dashboard-setup-startup-hook)
  )
(load-file "~/.emacs.d/add-ons/engmacs-dashboard.el")
(add-hook 'window-setup-hook (lambda () (dashboard-open)))
(add-hook 'window-setup-hook (lambda() (set-face-attribute 'dashboard-heading nil
		    :family "JetBrains Mono")))
(setq nerd-icons-font-family "Symbols Nerd Font Mono")

(use-package rainbow-delimiters
  :defer t
  :diminish
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package ivy
    :diminish
    :bind (("C-s" . swiper)
	   :map ivy-minibuffer-map
	   ("TAB" . ivy-alt-done)	
	   ("C-l" . ivy-alt-done)
	   ("C-j" . ivy-next-line)
	   ("C-k" . ivy-previous-line)
	   :map ivy-switch-buffer-map
	   ("C-k" . ivy-previous-line)
	   ("C-l" . ivy-done)
	   ("C-d" . ivy-switch-buffer-kill)
	   :map ivy-reverse-i-search-map
	   ("C-k" . ivy-previous-line)
	   ("C-d" . ivy-reverse-i-search-kill))
    :config
    (ivy-mode 1))

(use-package ivy-rich
    :diminish
    (eldoc-mode)
    :init
    (ivy-rich-mode 1))

(use-package counsel
  :diminish
  :bind (("M-x" . counsel-M-x)
	 ("C-x b" . counsel-ibuffer)
	 ("C-x C-f" . counsel-find-file))
  :config
  (setq ivy-initial-inputs-alist nil))

(use-package which-key
  :init (which-key-mode)
  :diminish
  :config
  (setq which-key-idle-delay 0.25)
  (setq which-key-popup-type 'side-window)
  (setq which-key-side-window-location 'left)
  (setq which-key-side-window-max-width 0.1)
  )

(use-package evil
  :diminish
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)
  (setq evil-want-C-i-jump nil)
  :config
  (evil-mode 1)
  (define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state)
  (define-key evil-insert-state-map (kbd "C-h") 'evil-delete-backward-char-and-join)
  ;; Use visual line motions even outside of visual-line-mode buffers
  (evil-global-set-key 'motion "j" 'evil-next-visual-line)
  (evil-global-set-key 'motion "k" 'evil-previous-visual-line)
  (evil-set-initial-state 'messages-buffer-mode 'normal)
  (evil-set-initial-state 'dashboard-mode 'normal)
  (evil-set-undo-system 'undo-redo)
  (define-key evil-insert-state-map (kbd "C-p") (kbd "C-o P"))
  (define-key evil-insert-state-map (kbd "C-y") (kbd "C-o y"))
  (define-key evil-insert-state-map (kbd "C-x") (kbd "C-o x"))
  )

(use-package evil-collection
  :diminish evil-collection-unimpaired-mode
  :after evil
  :config
  (evil-collection-init))

;; (use-package hydra)

(use-package helpful
  :defer t
  :custom
  (counsel-describe-function-function #'helpful-callable)
  (counsel-describe-variable-function #'helpful-variable)
  :bind
  ([remap describe-function] . counsel-describe-function)
  ([remap describe-command] . helpful-command)
  ([remap describe-variable] . counsel-describe-variable)
  ([remap describe-key] . helpful-key))

(global-unset-key (kbd "C-SPC"))
(use-package general
  :config
  (general-create-definer eng/leader-keys
    :keymaps '(normal insert visual emacs)
    :prefix "SPC"
    :global-prefix "C-SPC"
    :non-normal-prefix "C-SPC")
  "" nil)

;;   (use-package projectile
;;   :diminish
;;   :config (projectile-mode)
;;   :custom ((projectile-completion-system 'ivy))
;;   :bind-keymap
;;   ("C-c p" . projectile-command-map)
;;   ;; :init
;;   ;; NOTE: Set this to the folder where you keep your Git repos!
;;   ;; (when (file-directory-p "C:/Users/Sebastian/Documents/GitHub")
;;   ;;  (setq projectile-project-search-path '("C:/Users/Sebastian/Documents/GitHub")))
;;   ;; (setq projectile-switch-project-action #'projectile-dired)) 

;; (use-package counsel-projectile
;;   :diminish
;;   :config (counsel-projectile-mode))

(use-package magit
  :defer t
  :diminish (magit-auto-revert-mode auto-revert-mode)
  :custom
  (magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1))

(defun lsp-mode-setup ()
  (setq lsp-headerline-breadcrumb-segments '(path-up-to-project file symbols))
  (lsp-headerline-breadcrumb-mode))

(use-package lsp-mode
  :commands (lsp lsp-deferred)
  :hook (lsp-mode . lsp-mode-setup)
  :init
  (setq lsp-keymap-prefix "C-c l")  ;; Or 'C-l', 's-l'
  :config
  (lsp-enable-which-key-integration t))

(use-package lsp-ui
  :hook (lsp-mode . lsp-ui-mode)
  :custom
  (lsp-ui-doc-position 'bottom))

(use-package tree-sitter-langs)

(use-package company
  :defer t
  :hook
  (lsp-mode . company-mode)
  (org-mode . company-mode)
  :bind (:map company-active-map
	      ("<tab>" . company-complete-selection)
	      ("<return>" . nil))
  :init
  (company-mode 1)
  (company-mode -1)
  (setq company-minimum-prefix-length 2)
  (setq company-idle-delay 0.0))

(use-package company-box
  :defer t
  :diminish
  :hook (company-mode . company-box-mode))

(use-package auctex
  :defer t
  :ensure t)
(add-hook 'org-mode-hook (lambda () (require 'org-auctex)))
(add-hook 'org-mode-hook (lambda () (org-auctex-mode 1)))
(setq preview-auto-cache-preamble t)

;; (use-package company-auctex
;;   :diminish
;;   :config
;;   (company-auctex-init))

;; (use-package consult
;;   :init)
;; (require 'lsp-latex)
;; (setq lsp-latex-texlab-executable "~/.emacs.d/add-ons/texlab/texlab.exe")

(use-package yasnippet
  :diminish yas-minor-mode
  :config
  (setq yas-snippet-dirs '("~/.emacs.d/snippets"))
  (yas-global-mode 1))

;; (add-to-list 'load-path "~/.emacs.d/add-ons/EAF")
;; (add-to-list 'load-path "~/.emacs.d/add-ons/EAF/app/browser")
;; (add-to-list 'load-path "~/.emacs.d/add-ons/EAF/app/pdf-viewer")
;; (require 'eaf)
;; (require 'eaf-browser)
;; (require 'eaf-pdf-viewer)
;; (use-package epc :defer t :ensure t)
;; (use-package ctable :defer t :ensure t)
;; (use-package deferred :defer t :ensure t)
;; (use-package s :defer t :ensure t)

(defun org-font-setup ()
  ;; Replace list hyphen with dot
  (font-lock-add-keywords 'org-mode
			  '(("^ *\\([-]\\) "
			     (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•"))))))
  (dolist (face '((org-level-1 . 1.2)
		  (org-level-2 . 1.1)
		  (org-level-3 . 1.05)
		  (org-level-4 . 1.0)
		  (org-level-5 . 1.1)
		  (org-level-6 . 1.1)
		  (org-level-7 . 1.1)
		  (org-level-8 . 1.1)))
    ))

(use-package org
  :config
  (setq org-ellipsis " ▾")
  (org-font-setup)
  (with-eval-after-load 'org
    (org-babel-do-load-languages
     'org-babel-load-languages
     '((emacs-lisp . t)
       (octave . t)
       (latex . t)))))

(use-package modus-themes)
(use-package org-modern
  :diminish
  :custom
  ;; Edit settings
  (org-auto-align-tags nil)
  (org-tags-column 0)
  (org-catch-invisible-edits 'show-and-error)
  (org-special-ctrl-a/e t)
  (org-insert-heading-respect-content t)
  ;; Org styling, hide markup etc.
  (org-hide-emphasis-markers t)
  (org-ellipsis "…"))

(use-package toc-org
  :ensure t
  :config
  (add-hook 'org-mode-hook 'toc-org-mode)
  (add-hook 'markdown-mode-hook 'toc-org-mode)
  )

(use-package flyspell-correct-ivy
  :bind ("C-M-;" . flyspell-correct-wrapper)
  :init
  (setq flyspell-correct-interface #'flyspell-correct-ivy)
  (evil-define-key 'normal flyspell-mode-map (kbd "<return>") #'flyspell-correct-wrapper)
  (evil-define-key 'visual flyspell-mode-map (kbd "<return>") #'flyspell-correct-wrapper))

(unless (file-directory-p "~/.emacs.d/previewcache")
  (make-directory "~/.emacs.d/previewcache")) 
(setq temporary-file-directory "~/.emacs.d/previewcache")
  (setq org-latex-pdf-process '("latex -shell-escape -interaction nonstopmode %f"))
  (eval-after-load 'org
    '(progn
       (setq org-latex-create-formula-image-program 'dvipng)
       (setq org-preview-latex-default-process 'dvipng)
       )
    )
(setq org-latex-pdf-process '("pdflatex -interaction nonstopmode -output-directory %o %f"))

(defun create-latex-preview ()
  (interactive)
  (org-latex-preview))

(use-package org-roam
  :ensure t
  :bind (("C-c n l" . org-roam-buffer-toggle)
	 ("C-c n f" . org-roam-node-find)
	 ("C-c n i" . org-roam-node-insert))
  :config
  (org-roam-setup))

(use-package org-roam-ui
  :ensure t
  :diminish
  :config
  (setq org-roam-ui-sync-theme t
	org-roam-ui-follow t
	org-roam-ui-update-on-save t
	org-roam-ui-open-on-start t))

(use-package org-transclusion
  :ensure t
  :diminish
  )

(defun org-roam-node-candidates ()
  ;; (org-roam-db-sync) ; Synchronize the Org-roam database to ensure it's up-to-date
  (mapcar (lambda (node)
	    (cons (org-roam-node-title node)
		  (format "[[id:%s][%s]]" (org-roam-node-id node) (org-roam-node-title node))))
	  (org-roam-node-list)))

(defvar company-node-candidates (org-roam-node-candidates))

(defun company-node-backend (command &optional arg &rest ignored)
  (interactive (list 'interactive))
  (cl-case command
    (interactive (company-begin-backend 'company-node-backend))
    (prefix (and (eq major-mode 'org-mode) (company-grab-symbol)))
    (candidates
     (let ((prefix (downcase arg)))
       (seq-filter
	(lambda (candidate)
	  (string-prefix-p prefix (downcase candidate)))
	(mapcar #'car company-node-candidates))))
    (annotation
     "[Node]")
    (ignore-case t)
    (post-completion
     (let ((selected-candidate (assoc arg company-node-candidates)))
       (when selected-candidate
	 (delete-region (- (point) (length arg)) (point))
	 (insert (cdr selected-candidate)))))))

;; Add the backend to the list of backends
(add-to-list 'company-backends 'company-node-backend)
(add-hook 'org-mode-hook (lambda () (setq-local company-backends '(company-node-backend))))

(defun org-roam-node-update ()
  (let ((candidates (org-roam-node-candidates)))
    (setq company-node-candidates candidates)
    (add-to-list 'company-backends 'company-node-backend)))

(org-roam-node-update) ; Call it once to set up initially

(run-with-timer 0 5 #'org-roam-node-update)

(use-package gptel)
(setq
 gptel-model "gemini-1.5-pro-latest"
 gptel-default-mode 'org-mode
 gptel-backend (gptel-make-gemini "Gemini"
		 :key "AIzaSyBi6y77nZZlrTZUcrZt5qXPavXLbpfXySg"
		 :stream t))
(require 'gptel-extensions)

(add-to-list 'auto-mode-alist '("\\.m$" . octave-mode))
(setq org-confirm-babel-evaluate nil)

(use-package rustic)

(custom-set-variables
 '(custom-safe-themes '("796c44be3d1352f823614b1c75023018053fcdc56d88801874d6c939354f7d99" "a9eeab09d61fef94084a95f82557e147d9630fbbb82a837f971f83e66e21e5ad" "b29ba9bfdb34d71ecf3322951425a73d825fb2c002434282d2e0e8c44fce8185" "9f297216c88ca3f47e5f10f8bd884ab24ac5bc9d884f0f23589b0a46a608fe14" "6a5584ee8de384f2d8b1a1c30ed5b8af1d00adcbdcd70ba1967898c265878acf" "9013233028d9798f901e5e8efb31841c24c12444d3b6e92580080505d56fd392" "a9abd706a4183711ffcca0d6da3808ec0f59be0e8336868669dc3b10381afb6f" "8d8207a39e18e2cc95ebddf62f841442d36fcba01a2a9451773d4ed30b632443" "f5f80dd6588e59cfc3ce2f11568ff8296717a938edd448a947f9823a4e282b66" "4990532659bb6a285fee01ede3dfa1b1bdf302c5c3c8de9fad9b6bc63a9252f7" "8c7e832be864674c220f9a9361c851917a93f921fedb7717b1b5ece47690c098" "e70e87ad139f94d3ec5fdf782c978450fc2cb714d696e520b176ff797b97b8d2" "77fff78cc13a2ff41ad0a8ba2f09e8efd3c7e16be20725606c095f9a19c24d3d" "34cf3305b35e3a8132a0b1bdf2c67623bc2cb05b125f8d7d26bd51fd16d547ec" "571661a9d205cb32dfed5566019ad54f5bb3415d2d88f7ea1d00c7c794e70a36" "e1f4f0158cd5a01a9d96f1f7cdcca8d6724d7d33267623cc433fe1c196848554" "7e377879cbd60c66b88e51fad480b3ab18d60847f31c435f15f5df18bdb18184" "1f292969fc19ba45fbc6542ed54e58ab5ad3dbe41b70d8cb2d1f85c22d07e518" "88f7ee5594021c60a4a6a1c275614103de8c1435d6d08cc58882f920e0cec65e" default))
 '(package-selected-packages
   '(org-modern modus-themes diminish evil-collection evil magit general helpful rainbow-delimiters which-key counsel-projectile projectile company-auctex company auctex org-bullets ivy-rich dashboard vterm kanagawa-theme flycheck cargo rust-mode zuul treemacs-nerd-icons nerdtab mood-line doom-themes doom-modeline-now-playing counsel)))

(custom-set-faces
 '(line-number ((t (:inherit default :foreground "#3f4040" :slant normal :weight semi-bold :family "Jet Brains Mono"))))
 '(line-number-current-line ((t (:inherit (hl-line default) :foreground "#81a2be" :slant normal :weight extra-bold :family "Jet Brains Mono")))))

(define-minor-mode writing-mode
  "Toggle between a writing and programming environment."
  :global t
  :init-value nil
  (if writing-mode
      (progn
	;; Set fonts and themes  [TODO: FIX TABLES]
	(set-face-attribute 'default nil :family "Iosevka")
	(set-face-attribute 'variable-pitch nil :family "SF Pro Display")
	(set-face-attribute 'org-modern-symbol nil :family "Iosevka")
	(global-display-line-numbers-mode -1)
	(display-line-numbers-mode -1)
	;; (modus-themes-with-colors
	;;   (set-face-attribute 'mode-line nil
	;; 		      :background "white smoke"
	;; 		      :foreground "black"
	;; 		      :box nil)
	;;   (set-face-attribute 'mode-line-inactive nil
	;; 		      :background bg-dim
	;; 		      :foreground fg-dim))
	(set-face-background 'org-block-begin-line "ffffff")
	(set-face-background 'org-block "dbe4f1")
	(global-org-modern-mode 1)
	(setq global-hl-line-mode nil)

	;; Change modeline
	(setq header-line-format mode-line-format)
	(setq-default header-line-format mode-line-format)
	(setq mode-line-format nil)
	(setq-default mode-line-format nil)
	;; (add-hook 'after-change-major-mode-hook (lambda () (setq mode-line-format nil)))
	;; (add-hook 'after-change-major-mode-hook (lambda () (setq header-line-format mode-line-format)))
	;; (add-hook 'after-change-major-mode-hook (lambda () (setq-default header-line-format mode-line-format))

		  ;; Modify frame
		  (with-selected-frame (selected-frame)
		    (modify-frame-parameters
		     nil
		     '((right-divider-width . 25)
		       (internal-border-width . 25))))
		  (dolist (face '(window-divider
				  window-divider-first-pixel
				  window-divider-last-pixel))
		    (face-spec-reset-face face)
		    (set-face-foreground face (face-attribute 'default :background)))
		  (set-face-background 'fringe (face-attribute 'default :background))
		  (fringe-mode 10)

		  ;; Set writing mode flag
		  (setq writing-mode-active t)
		  (message "Writing mode active"))

	(progn
	  ;; Set fonts and themes
	  (set-face-attribute 'default nil :family "JetBrainsMonoNL NF" :height 110)
	  (global-display-line-numbers-mode 1)
	  (display-line-numbers-mode 1)
	  (global-org-modern-mode -1)
	  (setq global-hl-line-mode t)
	  (set-face-background 'org-block-begin-line "1a1c23")
	  (set-face-background 'org-block "1a1c23")

	  ;; Change modeline
	  (setq header-line-format nil)
	  (setq-default header-line-format nil)
	  ;; (remove-hook 'after-change-major-mode-hook (lambda () (setq mode-line-format nil)))
	  ;; (remove-hook 'after-change-major-mode-hook (lambda () (setq header-line-format mode-line-format)))
	  ;; (remove-hook 'after-change-major-mode-hook (lambda () (setq-default header-line-format mode-line-format)))
	  ;; (add-hook 'after-change-major-mode-hook (lambda () (setq header-line-format nil)))
	  ;; (remove-hook 'after-change-major-mode-hook (lambda () (setq-default header-line-format nil)))
	  (doom-modeline-mode)
	  ;; (add-hook 'after-change-major-mode-hook (lambda () (doom-modeline-mode)))

	  ;; Modify frame
	  (with-selected-frame (selected-frame)
	    (modify-frame-parameters
	     nil
	     '((right-divider-width . 0)
	       (internal-border-width . 0))))
	  (face-spec-reset-face 'fringe)
	  (fringe-mode 20)

	  ;; Set programming mode flag
	  (setq writing-mode-active nil)
	  (message "Programming mode active")))
    )

(defvar my-light-theme 'modus-operandi)
(defvar my-dark-theme 'EngMACS-dark)
(defvar my-current-theme my-dark-theme)

(defun toggle-writing-mode ()
  "Toggle between light and dark themes."
  (interactive)
  (if (eq my-current-theme my-light-theme)
      (progn
	(disable-theme my-light-theme)
	(load-theme my-dark-theme t)
	(setq my-current-theme my-dark-theme)
	(writing-mode -1))
    (progn
      (disable-theme my-dark-theme)
      (load-theme my-light-theme t)
      (setq my-current-theme my-light-theme)
      (writing-mode 1))))

;; (defvar engmacs-keyinfo-name "*EngMACS Commands*")

;; (defun engmacs-show-keyinfo ()
;;   (message "Keyinfo triggered")
;;   (let ((buffer (get-buffer-create engmacs-keyinfo-name)))
;;     (with-current-buffer buffer
;;       (erase-buffer)
;;       (insert "Hello world") ; Replace with your desired key information
;;       (display-buffer-in-side-window buffer '((side . left))))
;;     (run-with-idle-timer 1 nil (lambda () (kill-buffer buffer)))
    ;; ))

(defun engmacs-find-file ()
  (interactive)
  (if (stringp buffer-file-name)
      (cond
       ((eq major-mode 'dired-mode)
	(counsel-find-file))
       ((string-match "/Local/" (buffer-file-name))
	(counsel-find-file))
       (t
	(counsel-find-file nil "/Local/")))
    (counsel-find-file nil "/Local/")))

(define-key evil-visual-state-map (kbd "<backspace>") "\"_x")
(define-key evil-normal-state-map (kbd "<backspace>") "\"_x")

(eng/leader-keys
  "<return>" '(toggle-writing-mode :which-key "Toggle writing mode")
  "r" '(recentf-open :which-key "Open recent file...")
  "b" '(counsel-ibuffer :which-key "See open buffers...")
  "t" '(org-babel-tangle :which-key "Tangle src blocks to file")
  "o" '(engmacs-find-file :which-key "Open file...")
  "#" '(count-words :which-key "Word count")
  "s" '(save-buffer :which-key "Save file")
  "q" '(delete-window :which-key "Close window")
  "<tab>" '(org-indent-region :which-key "Format source block [Org]")
  "f" '(swiper :which-key "Find...")
  "g" '(magit-status :which-key "Git status")
  "c" '(comment-or-uncomment-region :which-key "Comment/uncomment region")
  "k" '(kill-buffer :which-key "Quit buffer...")
  "h" '(previous-buffer :which-key "Previous buffer")
  "l" '(next-buffer :which-key "Next buffer")
  "<left>" '(previous-buffer :which-key "Previous buffer")
  "<right>" '(next-buffer :which-key "Next buffer")
  "n f" '(org-roam-node-find :which-key "Find node...")
  "n i" '(org-roam-node-insert :which-key "Insert node...")
  "n l" '(org-roam-buffer-toggle :which-key "Toggle org-roam buffer")
  "n u" '(org-roam-ui-open :which-key "Open org-roam graph")
  "p b" '(org-auctex-preview-buffer :which-key "Create LaTeX previews for entire buffer")
  "p n" '(org-auctex-preview-dwim :which-key "Create LaTeX preview at point (async)")
  "p p" '(create-latex-preview :which-key "Create LaTeX preview at point")
  "v a" '(org-transclusion-make-from-link :which-key "Add transclusion from link")
  "v m" '(org-transclusion-mode :which-key "Toggle transclusions"))

(which-key-add-key-based-replacements
  "SPC n" "Org Roam Commands"
  "SPC p" "LaTeX Preview Commands"
  "SPC v" "Transclusion Commands"
  )

(setq gc-cons-threshold (expt 2 23))
