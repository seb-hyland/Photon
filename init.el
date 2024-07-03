;; (current-time-string)
;; (setq doom-modeline-time-icon t)
;; (load "/Local/Documents/EngMACS/add-ons/EngMACS-light-theme.el")
;; (load "/Local/Downloads/org-starless.el")
;; 
;; 
;; 
;; (setq svg-tag-tags
;; '(("\\(|[A-Z]+|\\)" . ((lambda (tag)
;; (svg-tag-make :beg 1 :end -1))))))
;; (setq svg-tag-tags
;; '((":HELLO:" . ((lambda (tag) (svg-tag-make "HELLO"))))))
;; 
;; :WHY???:
;; (svg-tag-mode t)
;; (require 'svg-tag-mode)
;; 
;; |HELLO|
;; 
;; (load "/Local/Downloads/doom-nano-modeline-main/doom-nano-modeline-modes.el")
;; (nano-modeline-text-mode t)
;; 
;; 
;; (remove-hook 'prog-mode-hook            #'nano-modeline-prog-mode)
;; (remove-hook 'text-mode-hook            #'nano-modeline-text-mode)
;; (remove-hook 'org-mode-hook             #'nano-modeline-org-mode)
;; (remove-hook 'pdf-view-mode-hook        #'nano-modeline-pdf-mode)
;; (remove-hook 'mu4e-headers-mode-hook    #'nano-modeline-mu4e-headers-mode)
;; (remove-hook 'mu4e-view-mode-hook       #'nano-modeline-mu4e-message-mode)
;; (remove-hook 'mu4e-compose-mode-hook    #'nano-modeline-mu4e-compose-mode)
;; (remove-hook 'elfeed-show-mode-hook     #'nano-modeline-elfeed-entry-mode)
;; (remove-hook 'elfeed-search-mode-hook   #'nano-modeline-elfeed-search-mode)
;; (remove-hook 'elpher-mode-hook          #'nano-modeline-elpher-mode)
;; (remove-hook 'term-mode-hook            #'nano-modeline-term-mode)
;; (remove-hook 'eat-mode-hook             #'nano-modeline-eat-mode)
;; (remove-hook 'xwidget-webkit-mode-hook  #'nano-modeline-xwidget-mode)
;; (remove-hook 'messages-buffer-mode-hook #'nano-modeline-message-mode)
;; (remove-hook 'org-capture-mode-hook     #'nano-modeline-org-capture-mode)
;; (remove-hook 'org-agenda-mode-hook      #'nano-modeline-org-agenda-mode)

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
(use-package consult)

(use-package gcmh
  :config
  (gcmh-mode 1))
(setq gc-cons-threshold most-positive-fixnum
      gc-cons-percentage 0.6)

(if (boundp 'comp-deferred-compilation)
    (setq comp-deferred-compilation nil)
  (setq native-comp-deferred-compilation nil))
(setq load-prefer-newer noninteractive)
(setq comp-async-report-warnings-errors nil)

(setq inhibit-startup-message t)
(scroll-bar-mode -1)   		        
(tool-bar-mode -1)     		        
(tooltip-mode -1)                            	        
(menu-bar-mode -1)
(auto-revert-mode 1)
(column-number-mode t)
(setq visible-bell t)
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)
(set-face-attribute 'default nil :family "Liga SFMono Nerd Font" :height 135)
(set-face-attribute 'line-number nil :inherit 'default :foreground "#3f4040" :slant 'normal :weight 'semi-bold :family "Liga SFMono Nerd Font")
(set-face-attribute 'line-number-current-line nil :inherit 'hl-line-default :foreground "#81a2be" :slant 'normal :weight 'extra-bold :family "Liga SFMono Nerd Font Nerd Font")
(setq frame-title-format nil)
(prefer-coding-system 'utf-8)
(global-visual-line-mode 1)
(setq default-frame-alist
      '((width . 150) (height . 45)))
(setenv "TZ" "PST8PDT,M3.2.0,M11.1.0")
(setq display-line-numbers-type 'relative)
(menu-bar--display-line-numbers-mode-visual)
(electric-pair-mode t)
;; Not sure about this:
(setq global-map (make-sparse-keymap))

(add-hook 'emacs-startup-hook (lambda ()
				(global-display-line-numbers-mode 1)
				(display-line-numbers-mode -1)
				(load-theme 'photon-dark t)
				))

(unless (file-directory-p "/Local/Documents/Photon/")
  (make-directory "/Local/Documents/Photon/")) 
(unless (file-directory-p "/Local/Documents/Photon/auto-saves/")
  (make-directory "/Local/Documents/Photon/auto-saves/")) 
(unless (file-directory-p "/Local/Documents/Photon/org-roam/")
  (make-directory "/Local/Documents/Photon/org-roam/")) 
(unless (file-directory-p "/Local/Documents/Photon/snippets-custom/")
  (make-directory "/Local/Documents/Photon/snippets-custom/"))
(unless (file-directory-p "/Local/Documents/Photon/org-agenda/")
  (make-directory "/Local/Documents/Photon/org-agenda/")) 

(setq backup-directory-alist
      '(("." . "/Local/Documents/Photon/auto-saves/")))

(setq auto-save-list-file-prefix '("/Local/Documents/Photon/auto-saves/")
      auto-save-file-name-transforms '((".*" "/Local/Documents/Photon/auto-saves/" t)))

(setq org-roam-directory "/Local/Documents/Photon/org-roam")

(global-unset-key (kbd "C-SPC"))
;;  (use-package general
;;   :config
;;   (general-create-definer eng/leader-keys
;;     :states '(normal insert visual emacs motion)
;;     :keymaps 'override
;;     :prefix "SPC"
;;     :global-prefix "C-a"
;;     :non-normal-prefix "C-a"))

(use-package ivy
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
(setq swiper-use-visual-line-p #'ignore)

(use-package ivy-rich
  :after (counsel)
  :diminish
  (eldoc-mode)
  :init
  (ivy-rich-mode 1))

(use-package orderless
  :after (ivy counsel ivy-rich)
  :config
  (setq ivy-re-builders-alist '((t . orderless-ivy-re-builder)))
  (add-to-list 'ivy-highlight-functions-alist '(orderless-ivy-re-builder . orderless-ivy-highlight)))

;;  (defun ivy--fussy-sort (name cands)
;;    "Sort according to closeness to string NAME the string list CANDS."
;;    (condition-case nil
;;	(let* ((bolp (= (string-to-char name) ?^))
;;	       ;; An optimized regex for fuzzy matching
;;	       ;; "abc" → "^[^a]*a[^b]*b[^c]*c"
;;	       (fuzzy-regex (concat "\\`"
;;				    (and bolp (regexp-quote (substring name 1 2)))
;;				    (mapconcat
;;				     (lambda (x)
;;				       (setq x (char-to-string x))
;;				       (concat "[^" x "]*" (regexp-quote x)))
;;				     (if bolp (substring name 2) name)
;;				     "")))
;;	       ;; Strip off the leading "^" for flx matching
;;	       (flx-name (if bolp (substring name 1) name))
;;	       cands-left
;;	       cands-to-sort)
;;
;;	  ;; Filter out non-matching candidates
;;	  (dolist (cand cands)
;;	    (when (string-match-p fuzzy-regex cand)
;;	      (push cand cands-left)))
;;
;;	  ;; pre-sort the candidates by length before partitioning
;;	  (setq cands-left (cl-sort cands-left #'< :key #'length))
;;
;;	  ;; partition the candidates into sorted and unsorted groups
;;	  (dotimes (_ (min (length cands-left) ivy-flx-limit))
;;	    (push (pop cands-left) cands-to-sort))
;;
;;	  (nconc
;;	   ;; Compute all of the flx scores in one pass and sort
;;	   (mapcar #'car
;;		   (sort (mapcar
;;			  (lambda (cand)
;;			    (cons cand
;;				  (car
;;				   (funcall
;;				    fussy-score-fn
;;				    cand flx-name
;;				    ivy--flx-cache))))
;;			  cands-to-sort)
;;			 (lambda (c1 c2)
;;			   ;; Break ties by length
;;			   (if (/= (cdr c1) (cdr c2))
;;			       (> (cdr c1)
;;				  (cdr c2))
;;			     (< (length (car c1))
;;				(length (car c2)))))))
;;	   ;; Add the unsorted candidates
;;	   cands-left))
;;      (error cands)))
;;
;;  (advice-add 'ivy--flx-sort :override 'ivy--fussy-sort)

(use-package counsel
  :diminish
  :bind (("M-x" . counsel-M-x)
	 ("C-x b" . counsel-ibuffer)
	 ("C-x C-f" . counsel-find-file))
  :config
  (setq ivy-initial-inputs-alist nil))

(use-package rg)

(use-package which-key
  :init (which-key-mode)
  :diminish
  :config
  (setq which-key-idle-delay 0.1)
  (setq which-key-popup-type 'side-window)
  (setq which-key-side-window-location 'bottom)
  (setq which-key-side-window-max-width 0.1)
  )

(use-package evil
  :diminish
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)
  (setq evil-want-C-i-jump nil)
  (setq evil-respect-visual-line-mode t)
  :config
  (evil-mode t)
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

(if (file-directory-p "/Local/Documents/Photon/.ssh")
    (copy-directory "/Local/Documents/Photon/.ssh" "/root/.ssh")) 
(defvar ssh-setup-buffer)
(defvar ssh-setup-status nil)
(defun ssh-setup ()
  (interactive)
  (if (equal ssh-setup-status nil)
      (setq ssh-setup-buffer (current-buffer))
    (shell)
    (process-send-string "*shell*" "chmod 600 /root/.ssh/id_ed25519 && ssh-agent > /dev/null 2>&1 && eval $(ssh-agent) > /dev/null 2>&1 && ssh-add ~/.ssh/id_ed25519 \n")
    (switch-to-buffer ssh-setup-buffer)
    (setq ssh-setup-status t)))
(add-hook 'magit-mode-hook #'ssh-setup)

;;  (defun lsp-mode-setup ()
;;    (setq lsp-headerline-breadcrumb-segments '(path-up-to-project file symbols))
;;    (lsp-headerline-breadcrumb-mode))

;; (use-package lsp-mode
;;   :commands (lsp lsp-deferred)
;;   ;; :hook (lsp-mode . lsp-mode-setup)
;;   :init
;;   (setq lsp-keymap-prefix "C-c l")  ;; Or 'C-l', 's-l'
;;   :config
;;   (lsp-enable-which-key-integration t))

;; (use-package lsp-ui
;;   :hook (lsp-mode . lsp-ui-mode)
;;   :custom
;;   (lsp-ui-doc-position 'bottom))

;; (setq tsc-dyn-get-from '(:compilation))
;; (setq tsc-dyn-dir '"/root/.emacs.d/add-ons/elisp-tree-sitter")
(use-package tree-sitter)
(use-package tree-sitter-langs)
;; (require 'tree-sitter-hl)
;; (require 'tree-sitter-debug)
;; (require 'tree-sitter-query)
(add-hook 'prog-mode-hook #'tree-sitter-hl-mode)

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
;; (add-hook 'org-mode-hook (lambda () (require 'org-auctex)))
;; (add-hook 'org-mode-hook (lambda () (org-auctex-mode 1)))
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
  :config
  (setq yas-snippet-dirs '("/Local/Documents/Photon/snippets-custom"))
  (setq yas-snippet-dirs (append yas-snippet-dirs '("/root/.emacs.d/snippets-core/")))
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

(use-package vterm
  :load-path "~/.emacs.d/vterm")
(use-package vterm-toggle
  :config
  (setq vterm-toggle-fullscreen-p nil)
  (setq vterm-shell "fish")
  (add-to-list 'display-buffer-alist
	       '((lambda (buffer-or-name _)
		   (let ((buffer (get-buffer buffer-or-name)))
		     (with-current-buffer buffer
		       (or (equal major-mode 'vterm-mode)
			   (string-prefix-p vterm-buffer-name (buffer-name buffer))))))
		 (display-buffer-reuse-window display-buffer-at-bottom)
		 (reusable-frames . visible)
		 (window-height . 0.35))))

(use-package perspective
  :init
  (setq persp-suppress-no-prefix-key-warning t)
  :config
  (persp-mode t))

;;    (eng/leader-keys
;;      "b" '(persp-counsel-switch-buffer :which-keys "Switch buffer...")
;;      "p" '(persp-switch :which-keys "Switch perspective..."))

(use-package avy)

(use-package zoom
  :init
  (zoom-mode t)
  )

(use-package expand-region)

(use-package visual-regexp-steroids)

(use-package autothemer
  :ensure t)
(add-to-list 'custom-theme-load-path "~/.emacs.d/add-ons")

;; (use-package diminish)
;; (diminish 'visual-line-mode)

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

(eval-after-load 'dired '(progn (require 'joseph-single-dired)))
(add-hook 'dired-mode-hook #'dired-hide-details-mode)

(use-package neotree
  :config
  (setq neo-theme 'icons))

(use-package nerd-icons-dired
  :hook
  (dired-mode . nerd-icons-dired-mode))

(use-package nerd-icons-ivy-rich
  :init
  (nerd-icons-ivy-rich-mode 1))

;;  (eng/leader-keys
;;    "d e" '(wdired-change-to-wdired-mode :which-key "Enter Wdired mode")
;;    "<return>" (kbd "C-c C-c")
;;    )
;;    "SPC n" "Org Roam Commands"
;;    "SPC p" "LaTeX Preview Commands"
;;    "SPC v" "Transclusion Commands"
;;
;;  (which-key-add-key-based-replacements
;;    "SPC <return>" "Complete/Execute"
;;    )

(use-package shrink-path
  :ensure t
  :demand t
  :diminish)

;; (require 'doom-modeline)
;; (require 'doom-modeline-autoloads)
;; (require 'doom-modeline-core)
;; (require 'doom-modeline-env)
;; ;; (require 'doom-modeline-pkg)
;; (require 'doom-modeline-segments)
;; 
;; (add-hook 'emacs-startup-hook (lambda () (doom-modeline-mode 1)))
;; 
;; (custom-set-variables
;; '(doom-modeline-major-mode-icon t)
;; '(doom-modeline-major-mode-color-icon t)
;; '(doom-modeline-buffer-state-icon t)
;; '(doom-modeline-buffer-modification-icon nil)
;; '(doom-modeline-buffer-encoding nil)
;; '(doom-modeline-icon t)
;; '(doom-modeline-time-icon nil)
;; '(doom-modeline-time-live-icon nil)
;; '(doom-modeline-time-clock-size 0.3)
;; '(doom-modeline-buffer-name t)
;; '(doom-modeline-height 40)
;; '(doom-modeline-support-imenu t)
;; '(doom-modeline-bar-width 6)
;; '(doom-modeline-position-column-line-format '("%l:%c"))
;; '(doom-modeline-minor-modes t)
;; '(doom-modeline-enable-word-count t)
;; '(doom-modeline-unicode-fallback t))
;; 
;; (custom-set-faces
;; '(doom-modeline ((t (:family "SF Mono"))))
;; '(doom-modeline-bar ((t (:background "#9099AB" :family "SF Mono"))))
;; '(doom-modeline-icon ((t (:family "Symbols Nerd Font Mono" :height 100))))
;; '(doom-modeline-icon-inactive ((t (:family "Symbols Nerd Font Mono" :height 100))))
;; '(mode-line ((t (:family "SF Mono"))))
;; '(mode-line-active ((t (:family "SF Mono"))))
;; '(mode-line-inactive ((t (:family "SF Mono")))))

(use-package doom-themes)
;; :defer t
;; :ensure t
;; :config
;; (setq doom-themes-enable-bold t 
;; doom-themes-enable-italic t)
;; (doom-themes-visual-bell-config))

;; (require 'doom-nano-modeline)
;; (require 'doom-nano-modeline-core)
;; (require 'doom-nano-modeline-misc)
;; (require 'doom-nano-modeline-modes)
;; (doom-nano-modeline-mode 1)


;; (defun get-current-perspective ()
;; "Return the current perspective name, if any."
;; (let ((perspective (persp-curr)))
;; (if perspective
;; `((,(perspective-name perspective) . font-lock-comment-face)
;; (" " . nil))
;; nil)))
;; 
;; (setq doom-nano-modeline-append-information #'get-current-perspective)

(require 'doom-nano-modeline)
(require 'doom-nano-modeline-core)
(require 'doom-nano-modeline-misc)
(require 'doom-nano-modeline-modes)
(doom-nano-modeline-mode t)

;; (use-package nano-modeline
;; :config
;; (nano-modeline-text-mode t)
;; :hook
;; (prog-mode-hook            . nano-modeline-prog-mode)
;; (text-mode-hook            . nano-modeline-text-mode)
;; (org-mode-hook             . nano-modeline-org-mode)
;; (pdf-view-mode-hook        . nano-modeline-pdf-mode)
;; (mu4e-headers-mode-hook    . nano-modeline-mu4e-headers-mode)
;; (mu4e-view-mode-hook       . nano-modeline-mu4e-message-mode)
;; (mu4e-compose-mode-hook    . nano-modeline-mu4e-compose-mode)
;; (elfeed-show-mode-hook     . nano-modeline-elfeed-entry-mode)
;; (elfeed-search-mode-hook   . nano-modeline-elfeed-search-mode)
;; (elpher-mode-hook          . nano-modeline-elpher-mode)
;; (term-mode-hook            . nano-modeline-term-mode)
;; (vterm-mode-hook           . nano-modeline-term-mode)
;; (eshell-mode-hook          . nano-modeline-term-mode)
;; (eat-mode-hook             . nano-modeline-eat-mode)
;; (xwidget-webkit-mode-hook  . nano-modeline-xwidget-mode)
;; (messages-buffer-mode-hook . nano-modeline-message-mode)
;; (org-capture-mode-hook     . nano-modeline-org-capture-mode)
;; (org-agenda-mode-hook      . nano-modeline-org-agenda-mode)
;; )

(use-package hide-mode-line
  :init
  (global-hide-mode-line-mode t))

(use-package spacious-padding
  :init
  (spacious-padding-mode))

;; (set-face-attribute 'nano-modeline-status nil :foreground "black" :weight 'bold)

;; (defun nano-modeline-set-evil-color ()
;; (cond
;; ((eq evil-state 'normal)
;; (set-face-attribute 'nano-modeline-status nil
;; :background "#7FB4CA"))
;; ((eq evil-state 'insert)
;; (set-face-attribute 'nano-modeline-status nil
;; :background "#98BB6C"))
;; ((eq evil-state 'visual)
;; (set-face-attribute 'nano-modeline-status nil
;; :background "#FF5D62"))
;; ((eq evil-state 'emacs)
;; (set-face-attribute 'nano-modeline-status nil
;; :background "#957FB8"))))
;; 
;; (add-hook 'evil-normal-state-entry-hook #'nano-modeline-set-evil-color)
;; (add-hook 'evil-insert-state-entry-hook #'nano-modeline-set-evil-color)
;; (add-hook 'evil-visual-state-entry-hook #'nano-modeline-set-evil-color)
;; (add-hook 'evil-emacs-state-entry-hook #'nano-modeline-set-evil-color)

;; (defun nano-modeline-save-indicator ()
;; (if (buffer-modified-p)
;; (set-face-attribute 'nano-modeline--empty-face nil
;; :foreground "#FF5D62"
;; :background "#2A2A37")
;; (set-face-attribute 'nano-modeline--empty-face nil
;; :foreground "#E6E3D3")))
;; 
;; (add-hook 'post-command-hook #'nano-modeline-save-indicator)
;; (add-hook 'after-save-hook #'nano-modeline-save-indicator)

(use-package dashboard
  :ensure t
  :init
  :config
  (dashboard-setup-startup-hook)
  )
(load-file "~/.emacs.d/add-ons/photon-dashboard.el")
(add-hook 'window-setup-hook (lambda () (dashboard-open)))
(add-hook 'window-setup-hook (lambda() (set-face-attribute 'dashboard-heading nil
							   :family "Liga SFMono Nerd Font")))
(setq nerd-icons-font-family "Symbols Nerd Font Mono")

(use-package rainbow-delimiters
  :defer t
  :diminish
  :hook (prog-mode . rainbow-delimiters-mode))

(defun org-font-setup ()
  (interactive)
  "Customizes Org mode fonts for headings and list hyphens."
  ;; Replace list hyphen with dot
  (font-lock-add-keywords 'org-mode
			  '(("^ *\\([-]\\) "
			     (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•"))))))
  (dolist (face '((org-level-1 . 1.9)
		  (org-level-2 . 1.6)
		  (org-level-3 . 1.35)
		  (org-level-4 . 1.15)
		  (org-level-5 . 1.1)
		  (org-level-6 . 1.1)
		  (org-level-7 . 1.1)
		  (org-level-8 . 1.1)
		  (org-document-title . 2.3)
		  (org-document-info . 1.5)
		  (org-meta-line . 1.15)))
    (set-face-attribute (car face) nil :height (cdr face)))

  (dolist (face '((org-level-1)
		  (org-level-2)
		  (org-document-title)
		  ))
    (set-face-attribute (car face) nil :weight 'extrabold))

  (dolist (face '((org-level-3)
		  (org-level-4)
		  (org-document-info)
		  ))
    (set-face-attribute (car face) nil :weight 'bold))

  (dolist (face '((org-level-5)
		  (org-level-6)
		  (org-level-7)
		  (org-level-8)
		  (org-meta-line)
		  ))
    (set-face-attribute (car face) nil :weight 'medium))

  (set-face-attribute 'org-block nil :family "Liga SFMono Nerd Font")
  (set-face-attribute 'org-table nil :family "Liga SFMono Nerd Font"))

(add-hook 'org-mode-hook
	  (lambda ()
	    (variable-pitch-mode t)))
(add-hook 'org-mode-hook 'org-font-setup)
(set-face-attribute 'variable-pitch nil :family "SF Pro Text")

(use-package org
  :config
  (setq org-ellipsis " ▾")
  (delete-selection-mode t)
  (with-eval-after-load 'org
    (org-babel-do-load-languages
     'org-babel-load-languages
     '((emacs-lisp . t)
       (octave . t)
       (latex . t)
       (python .t)))
    ))

;; (use-package modus-themes)
;; (use-package org-modern
;; :diminish
;; :custom
;; ;; Edit settings
;; (org-auto-align-tags nil)
;; (org-tags-column 0)
;; (org-catch-invisible-edits 'show-and-error)
;; (org-special-ctrl-a/e t)
;; (org-insert-heading-respect-content t)
;; ;; Org styling, hide markup etc.
;; (org-hide-emphasis-markers t)
;; (org-ellipsis "…"))

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
(setq org-latex-create-formula-image-program 'dvipng)
(setq org-preview-latex-default-process 'dvipng)
(setq org-latex-pdf-process '("pdflatex -interaction nonstopmode -output-directory %o %f"))
(use-package math-preview
  :config (math-preview-start-process))

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

(unless (file-directory-p "/Local/Documents/Photon/keychain/")
  (make-directory "/Local/Documents/Photon/keychain/"))
(unless (file-exists-p "/Local/Documents/Photon/keychain/gemini")
  (write-region "" nil "/Local/Documents/Photon/keychain/gemini"))

(defun get-gemini-key ()
  (with-temp-buffer
    (insert-file-contents "/Local/Documents/Photon/keychain/gemini")
    (string-trim (buffer-string))))

(use-package gptel)
(unless (string-empty-p (get-gemini-key))
  (setq
   gptel-model "gemini-1.5-pro-latest"
   gptel-default-mode 'org-mode
   gptel--system-message ""
   gptel-backend (gptel-make-gemini "Gemini"
		   :key (get-gemini-key)
		   :stream t)))
;; (require 'gptel-extensions)

(add-to-list 'auto-mode-alist '("\\.m$" . octave-mode))
(setq org-confirm-babel-evaluate nil)

(use-package rustic)

;; (custom-set-variables
;; '(custom-safe-themes '("796c44be3d1352f823614b1c75023018053fcdc56d88801874d6c939354f7d99" "a9eeab09d61fef94084a95f82557e147d9630fbbb82a837f971f83e66e21e5ad" "b29ba9bfdb34d71ecf3322951425a73d825fb2c002434282d2e0e8c44fce8185" "9f297216c88ca3f47e5f10f8bd884ab24ac5bc9d884f0f23589b0a46a608fe14" "6a5584ee8de384f2d8b1a1c30ed5b8af1d00adcbdcd70ba1967898c265878acf" "9013233028d9798f901e5e8efb31841c24c12444d3b6e92580080505d56fd392" "a9abd706a4183711ffcca0d6da3808ec0f59be0e8336868669dc3b10381afb6f" "8d8207a39e18e2cc95ebddf62f841442d36fcba01a2a9451773d4ed30b632443" "f5f80dd6588e59cfc3ce2f11568ff8296717a938edd448a947f9823a4e282b66" "4990532659bb6a285fee01ede3dfa1b1bdf302c5c3c8de9fad9b6bc63a9252f7" "8c7e832be864674c220f9a9361c851917a93f921fedb7717b1b5ece47690c098" "e70e87ad139f94d3ec5fdf782c978450fc2cb714d696e520b176ff797b97b8d2" "77fff78cc13a2ff41ad0a8ba2f09e8efd3c7e16be20725606c095f9a19c24d3d" "34cf3305b35e3a8132a0b1bdf2c67623bc2cb05b125f8d7d26bd51fd16d547ec" "571661a9d205cb32dfed5566019ad54f5bb3415d2d88f7ea1d00c7c794e70a36" "e1f4f0158cd5a01a9d96f1f7cdcca8d6724d7d33267623cc433fe1c196848554" "7e377879cbd60c66b88e51fad480b3ab18d60847f31c435f15f5df18bdb18184" "1f292969fc19ba45fbc6542ed54e58ab5ad3dbe41b70d8cb2d1f85c22d07e518" "88f7ee5594021c60a4a6a1c275614103de8c1435d6d08cc58882f920e0cec65e" default))
;; '(package-selected-packages
;; '(org-modern modus-themes diminish evil-collection evil magit general helpful rainbow-delimiters which-key counsel-projectile projectile company-auctex company auctex org-bullets ivy-rich dashboard vterm kanagawa-theme flycheck cargo rust-mode zuul treemacs-nerd-icons nerdtab mood-line doom-themes doom-modeline-now-playing counsel)))

;; (set-face-attribute 'line-number nil :inherit 'default :foreground "#3f4040" :slant normal :weight semi-bold :family "JetBrainsMono Nerd Font")
;; (set-face-attribute 'line-number-current-line nil :inherit (hl-line default) :foreground "#81a2be" :slant normal :weight extra-bold :family "JetBrainsMono Nerd Font")

;; (define-minor-mode writing-mode
;; "Toggle between a writing and programming environment."
;; :global t
;; :init-value nil
;; (if writing-mode
;; (progn
;; ;; Set fonts and themes  [TODO: FIX TABLES]
;; (set-face-attribute 'default nil :family "Iosevka")
;; (set-face-attribute 'variable-pitch nil :family "Iosevka Aile")
;; (set-face-attribute 'org-modern-symbol nil :family "Iosevka")
;; (global-display-line-numbers-mode -1)
;; (display-line-numbers-mode -1)
;; ;; (modus-themes-with-colors
;; ;;   (set-face-attribute 'mode-line nil
;; ;; 		      :background "white smoke"
;; ;; 		      :foreground "black"
;; ;; 		      :box nil)
;; ;;   (set-face-attribute 'mode-line-inactive nil
;; ;; 		      :background bg-dim
;; ;; 		      :foreground fg-dim))
;; (set-face-background 'org-block-begin-line "ffffff")
;; (set-face-background 'org-block "dbe4f1")
;; (global-org-modern-mode 1)
;; (setq global-hl-line-mode nil)
;; 
;; ;; Change modeline
;; (setq header-line-format mode-line-format)
;; (setq-default header-line-format mode-line-format)
;; (setq mode-line-format nil)
;; (setq-default mode-line-format nil)
;; ;; (add-hook 'after-change-major-mode-hook (lambda () (setq mode-line-format nil)))
;; ;; (add-hook 'after-change-major-mode-hook (lambda () (setq header-line-format mode-line-format)))
;; ;; (add-hook 'after-change-major-mode-hook (lambda () (setq-default header-line-format mode-line-format))
;; 
;; ;; Modify frame
;; (with-selected-frame (selected-frame)
;; (modify-frame-parameters
;; nil
;; '((right-divider-width . 25)
;; (internal-border-width . 25))))
;; (dolist (face '(window-divider
;; window-divider-first-pixel
;; window-divider-last-pixel))
;; (face-spec-reset-face face)
;; (set-face-foreground face (face-attribute 'default :background)))
;; (set-face-background 'fringe (face-attribute 'default :background))
;; (fringe-mode 10)
;; 
;; ;; Set writing mode flag
;; (setq writing-mode-active t)
;; (message "Writing mode active"))
;; 
;; (progn
;; ;; Set fonts and themes
;; (set-face-attribute 'default nil :family "JetBrainsMonoNL NF" :height 110)
;; (global-display-line-numbers-mode 1)
;; (display-line-numbers-mode 1)
;; (global-org-modern-mode -1)
;; (setq global-hl-line-mode t)
;; (set-face-background 'org-block-begin-line "1a1c23")
;; (set-face-background 'org-block "1a1c23")
;; 
;; ;; Change modeline
;; (setq header-line-format nil)
;; (setq-default header-line-format nil)
;; ;; (remove-hook 'after-change-major-mode-hook (lambda () (setq mode-line-format nil)))
;; ;; (remove-hook 'after-change-major-mode-hook (lambda () (setq header-line-format mode-line-format)))
;; ;; (remove-hook 'after-change-major-mode-hook (lambda () (setq-default header-line-format mode-line-format)))
;; ;; (add-hook 'after-change-major-mode-hook (lambda () (setq header-line-format nil)))
;; ;; (remove-hook 'after-change-major-mode-hook (lambda () (setq-default header-line-format nil)))
;; (doom-modeline-mode)
;; ;; (add-hook 'after-change-major-mode-hook (lambda () (doom-modeline-mode)))
;; 
;; ;; Modify frame
;; (with-selected-frame (selected-frame)
;; (modify-frame-parameters
;; nil
;; '((right-divider-width . 0)
;; (internal-border-width . 0))))
;; (face-spec-reset-face 'fringe)
;; (fringe-mode 20)
;; 
;; ;; Set programming mode flag
;; (setq writing-mode-active nil)
;; (message "Programming mode active")))
;; ))

;; (defvar my-light-theme 'modus-operandi)
;; (defvar my-dark-theme 'EngMACS-dark)
;; (defvar my-current-theme my-dark-theme)
;; 
;; (defun toggle-writing-mode ()
;; "Toggle between light and dark themes."
;; (interactive)
;; (if (eq my-current-theme my-light-theme)
;; (progn
;; (disable-theme my-light-theme)
;; (load-theme my-dark-theme t)
;; (setq my-current-theme my-dark-theme)
;; (writing-mode -1))
;; (progn
;; (disable-theme my-dark-theme)
;; (load-theme my-light-theme t)
;; (setq my-current-theme my-light-theme)
;; (writing-mode 1))))

(defface photon-transient-dynamic-face
      '((t (:foreground "#7FB4CA" :weight bold)))
      "Face for dynamic transients")

    (defun photon-find-file ()
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

    (defun photon-C-j ()
      (interactive)
      (if (minibuffer-window-active-p (selected-window))
	  (ivy-next-line)
	(execute-kbd-macro (kbd "G")))) 

    (defun photon-C-k ()
      (interactive)
      (if (minibuffer-window-active-p (selected-window))
	  (ivy-previous-line)
	(execute-kbd-macro (kbd "gg"))))

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

    (transient-define-suffix toggle-theme ()
      :transient nil
      :key "<return>"
      :description "Toggle light/dark theme"
      (interactive)
      (if (eq 'EngMACS-dark (car custom-enabled-themes))
	  (load-theme 'EngMACS-light t)
	(load-theme 'EngMACS-dark t)))

    (use-package org-modern
      :init
      (setq org-modern-hide-stars 't)
      (setq org-modern-block-fringe 2))

    (defun org-entities-show ()
      (interactive)
      (setq org-hide-emphasis-markers nil)
      (global-org-modern-mode -1)
      (dolist (buf (match-buffers '(major-mode . org-mode)))
	(with-current-buffer buf
	  (display-line-numbers-mode t)))
      (remove-hook 'org-mode-hook (lambda () (display-line-numbers-mode -1))))

    (defun org-entities-hide ()
      (interactive)
      (setq org-hide-emphasis-markers t)
      (global-org-modern-mode t)
      (dolist (buf (match-buffers '(major-mode . org-mode)))
	(with-current-buffer buf
	  (display-line-numbers-mode -1)))
      (add-hook 'org-mode-hook (lambda () (display-line-numbers-mode -1))))

    (defvar org-entities-state "HIDDEN")

    (defun org-entities-toggle ()
      (interactive)
      (if (equal org-entities-state "HIDDEN")
	  (progn
	    (org-entities-show)
	    (setq org-entities-state "VISIBLE"))
	(progn
	  (org-entities-hide)
	  (setq org-entities-state "HIDDEN"))))

    (org-entities-hide)


    (defun photon-face-selection ()
      "Presents the user with options to set the variable-pitch font face."
      (interactive)
      (let* ((font-choices '("Sans-serif" "Serif" "Monospace"))
	     (choice (completing-read "Choose typeface class: " font-choices nil t))
	     (font-mapping '(("Sans-serif" . "SF Pro Text")
			     ("Serif" . "Lora")
			     ("Monospace" . "Liga SFMono Nerd Font")))
	     (selected-font (cdr (assoc choice font-mapping))))
	(set-face-attribute 'variable-pitch nil :family selected-font)))

(defvar photon-opp-theme "light")

(defun photon-theme-toggle ()
  (interactive)
  (if (equal (car custom-enabled-themes) 'photon-dark)
      (progn (load-theme 'photon-light t) (setq photon-opp-theme "dark"))
    (progn (load-theme 'photon-dark t) (setq photon-opp-theme "light")))
	(org-font-setup))

    (use-package org-fragtog
      :load-path "~/.emacs.d/add-ons"
      :hook (org-mode . org-fragtog-mode))

(transient-define-prefix photon/main ()
		[:description
		 " "
		 ["  Open and save files"
		  :pad-keys nil
		  ("s" "Save current buffer" save-buffer)
		  ("S" "󰁣 Save as..." write-file)
		  ("o" "Open file..." photon-find-file)
		  ("r" "Open recent..." recentf-open)
		  ""
		  ""
		  "  Quick commands"
		  ("f" "Search in buffer..." swiper)
		  ("F" "󰁣 Search in directory..." counsel-rg)
		  ("x" "Execute command..." counsel-M-x)
		  ("p" "Switch perspective..." persp-switch)
		  ]
		 ["  Buffer actions"
		  ("b" "Switch buffer...     " persp-counsel-switch-buffer)
		  ("l" "Next buffer" next-buffer :transient t)
		  ("h" "Previous buffer" previous-buffer :transient t)
		  ("k" "Kill current buffer" kill-current-buffer)
		  ("K" "󰁣 Kill buffer..." persp-kill-buffer*)
		  ""
		  "  Text scaling"
		  ("=" "Increase in current buffer" text-scale-increase :transient t)
		  ("-" "Decrease in current buffer" text-scale-decrease :transient t)
		  (global-scale-inc)
		  (global-scale-dec)
		  ]
		 ["  Keybind sets"
		  ("w" "   Window settings..." photon/window)
		  ("m" "   Math preview..." counsel-M-x)
		  ("e" "   Editing tools..." photon/editing)
		  ("d" " 󰈙  Org document tools..." photon/org)
		  ("c" "   Coding tools..." photon/coding)
		  ]]
		)

	      (transient-define-prefix photon/editing ()
		[" "
		 ["  Spellcheck"
		  ("c" "Correct word at cursor..." flyspell-correct-wrapper)
		  ]])

	      (transient-define-prefix photon/coding ()
		[" "
		 ["  Terminal tools"
		  ("<return>" "Toggle popup terminal" vterm-toggle)
		  ]])

	      (transient-define-prefix photon/window ()
		[" "
		 ["󱂬  Manage windows"
		  ("r" "Create on right" split-window-right)
		  ("b" "Create below" split-window-below)
		  ("q" "Close current window" delete-window)
		  ]
	    [
	"󰏘 Visual settings"
	("t" photon-theme-toggle
  :description
  (lambda ()
(format "Activate %s theme" photon-opp-theme)))
	  ]])

	      (transient-define-prefix photon/org ()
		[" "
		 ["󱓦 Editing commands"
		  ("e" "Expand selection" er/expand-region)
		  ("c" "Contract selection" er/contract-region)
		  ("t" "Tangle code blocks" org-babel-tangle)
		  ]
		 [" Visual commands"
		  ("v" org-entities-toggle
		   :description
		   (lambda ()
		     (format "Toggle entities [%s]" (propertize org-entities-state 'face 'photon-transient-dynamic-face))))
		  ("f" "Change document font..." photon-face-selection)
		  ]
		 ["󱃖 LaTeX commands"
		  ("p" org-fragtog-mode
		   :description
		   (lambda ()
		     (format "Toggle LaTeX auto-preview [%s]" (if org-fragtog-mode
								  (propertize "ACTIVE" 'face 'photon-transient-dynamic-face)
								(propertize "INACTIVE" 'face 'photon-transient-dynamic-face))))
		   )
		  ("a" "Preview all LaTeX fragments" math-preview-all)
		  ("d" "Clear all LaTeX fragments" math-preview-clear-all)
		  ]
		 ])

(defvar photon-keymap (make-keymap)
  "Keymap for Photon general bindings")

(define-minor-mode photon-mode
  "Minor mode for my personal keybindings."
  :init-value t
  :global t
  :keymap photon-keymap)

(add-to-list 'emulation-mode-map-alists
	     `((photon-mode . ,photon-keymap)))

(photon-mode t)
(dolist (binding '(("C-SPC" . photon/main)
		   ("<normal-state> SPC" . photon/main)
		   ("<visual-state> SPC" . photon/main)
		   ("M-h" . windmove-left)
		   ("M-j" . windmove-down)
		   ("M-k" . windmove-up)
		   ("M-l" . windmove-right)
		   ("C-j" . photon-C-j)
		   ("C-k" . photon-C-k)
		   ("C-? k" . describe-key)
		   ("C-? f" . counsel-describe-function)
		   ("C-? v" . counsel-describe-variable)
		   ))
  (define-key photon-keymap (kbd (car binding)) (cdr binding)))

(dolist (state '("normal" "visual"))
  (let ((map (symbol-value (intern (concat "evil-" state "-state-map")))))
    (define-key map (kbd "SPC") 'photon/main)
    (define-key map (kbd "<backspace>") "\"_x")
    (define-key map (kbd "H") 'evil-backward-word-begin)
    (define-key map (kbd "J") 'evil-forward-paragraph)
    (define-key map (kbd "K") 'evil-backward-paragraph)
    (define-key map (kbd "L") 'evil-forward-word-end)
    (define-key map (kbd "C-h") 'evil-beginning-of-visual-line)      
    (define-key map (kbd "C-j") 'evil-goto-line)      
    (define-key map (kbd "C-k") 'evil-goto-first-line)      
    (define-key map (kbd "C-l") 'evil-end-of-visual-line)
    (define-key map (kbd "f") 'evil-avy-goto-char)
    (define-key map (kbd "F") 'evil-avy-goto-word-1)
    (define-key map (kbd "r") 'evil-redo)))

 (define-key dired-mode-map (kbd "<normal-state> SPC") 'photon/main)
 (define-key dired-mode-map (kbd "<visual-state> SPC") 'photon/window)
;; (define-key org-mode-map (kbd "<normal-state> C-k") 'evil-goto-first-line)
;; (define-key org-mode-map (kbd "<normal-state> C-j") 'evil-goto-line)
;; (define-key org-mode-map (kbd "<visual-state> C-k") 'evil-goto-first-line)
;; (define-key org-mode-map (kbd "<visual-state> C-j") 'evil-goto-line)
;; (evil-global-set-key 'normal (kbd "SPC") 'photon/main)
;; (evil-global-set-key 'visual (kbd "SPC") 'photon/main)
;; (evil-global-set-key 'emacs (kbd "SPC") 'photon/main)
;; (evil-global-set-key 'motion (kbd "SPC") 'photon/main)
;; (evil-global-set-key 'operator (kbd "SPC") 'photon/main)
(define-key transient-base-map (kbd "<escape>") 'transient-quit-all)

;;  (which-key-add-key-based-replacements
;;    "SPC n" "Org Roam Commands"
;;    "SPC p" "LaTeX Preview Commands"
;;    "SPC v" "Transclusion Commands"
;;    )

(setq gc-cons-threshold (expt 2 23))
