;;  (use-package typst-ts-mode
;;    :load-path "/Local/Downloads/typst-ts-mode")
;;
;;  (add-to-list 'treesit-language-source-alist
;;               '(typst "https://github.com/uben0/tree-sitter-typst"))
;;  (treesit-install-language-grammar 'typst)
;;
;;  (setq typst-preview-browser "xwidget")

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
;;  (use-package compat)

;;  (use-package gcmh
;;    :config
;;    (gcmh-mode 1))
(setq gc-cons-threshold most-positive-fixnum
      gc-cons-percentage 0.6)

(if (boundp 'comp-deferred-compilation)
    (setq comp-deferred-compilation nil)
  (setq native-comp-deferred-compilation nil))
(setq load-prefer-newer noninteractive)
(setq comp-async-report-warnings-errors nil)
(setq package-native-compile t)

(setq inhibit-startup-message t)
(scroll-bar-mode -1)   		        
(tool-bar-mode -1)     		        
(tooltip-mode -1)                            	        
(menu-bar-mode -1)
(global-auto-revert-mode 1)
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
(add-hook 'prog-mode-hook (lambda () (electric-pair-local-mode t)))
(setq split-width-threshold 1)

(add-hook 'emacs-startup-hook (lambda ()
				(global-display-line-numbers-mode 1)
				(display-line-numbers-mode -1)
				(load-theme 'photon-dark t)
				))

(defvar photon-var-dir "/Local/Documents/Photon/sys/var/")

(defmacro photon-defvar (name value)
  "Define a persistent variable named NAME with initial VALUE."
  `(progn 
     (let ((var-file (concat photon-var-dir ,(symbol-name name))))
       (with-temp-buffer
         (insert (prin1-to-string ,value))
         (write-file var-file)
 	 (setq ,name ,value)
 	 ))))

(defun photon-load-var (name)
  "Load the value of the persistent variable NAME 
 and set the variable in the current environment."
  (let ((var-file (concat photon-var-dir (symbol-name name))))
    (if (file-exists-p var-file)
	(with-temp-buffer
          (insert-file-contents var-file)
          (let ((loaded-value (read (current-buffer))))
            (setq name loaded-value)))
      nil)))

(defun photon-check-dir (name)
  "Check if directory exists; if not, create it."
  (unless (file-directory-p name)
    (make-directory name)))

(dolist (dir '("sys/"
               "sys/auto-saves/"
               "sys/var/"
               "org-roam/"
               "snippets/"
               "org-agenda/"
               "keychain/"))
  (photon-check-dir dir))

(recentf-mode t)
(setq recentf-save-file "/Local/Documents/Photon/sys/recentf")
(run-at-time nil (* 5 60) 'recentf-save-list)

(setq backup-directory-alist
      '((".*" . "/Local/Documents/Photon/sys/auto-saves/")))

(setq auto-save-list-file-prefix '("/Local/Documents/Photon/sys/auto-saves/")
      auto-save-file-name-transforms '((".*" "/Local/Documents/Photon/sys/auto-saves/" t)))

(setq org-roam-directory "/Local/Documents/Photon/org-roam/main")
(setq org-roam-db-location "/Local/Documents/Photon/org-roam/database.db")

;; (global-unset-key (kbd "C-SPC"))
;;  (use-package general
;;   :config
;;   (general-create-definer eng/leader-keys
;;     :states '(normal insert visual emacs motion)
;;     :keymaps 'override
;;     :prefix "SPC"
;;     :global-prefix "C-a"
;;     :non-normal-prefix "C-a"))

;;  (use-package ivy
;;    :bind (("C-s" . swiper)
;;	   :map ivy-minibuffer-map
;;	   ("TAB" . ivy-alt-done)	
;;	   ("C-l" . ivy-alt-done)
;;	   ("C-j" . ivy-next-line)
;;	   ("C-k" . ivy-previous-line)
;;	   :map ivy-switch-buffer-map
;;	   ("C-k" . ivy-previous-line)
;;	   ("C-l" . ivy-done)
;;	   ("C-d" . ivy-switch-buffer-kill)
;;	   :map ivy-reverse-i-search-map
;;	   ("C-k" . ivy-previous-line)
;;	   ("C-d" . ivy-reverse-i-search-kill))
;;    :config
;;    (ivy-mode 1))
;;  (setq swiper-use-visual-line-p #'ignore)
;;
;;  (use-package ivy-rich
;;    :after (counsel)
;;    :diminish
;;    (eldoc-mode)
;;    :init
;;    (ivy-rich-mode 1))
;;
;;  (use-package orderless
;;    :after (ivy counsel ivy-rich)
;;    :config
;;    (setq ivy-re-builders-alist '((t . orderless-ivy-re-builder)))
;;    (add-to-list 'ivy-highlight-functions-alist '(orderless-ivy-re-builder . orderless-ivy-highlight)))

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

;;  (use-package counsel
;;    :diminish
;;    :bind (("M-x" . counsel-M-x)
;;	   ("C-x b" . counsel-ibuffer)
;;	   ("C-x C-f" . counsel-find-file))
;;    :config
;;    (setq ivy-initial-inputs-alist nil))

(use-package vertico
  :bind (:map vertico-map
              ("<remap> <photon-C-j>" . vertico-next)
              ("<remap> <photon-C-k>" . vertico-previous)
              ("RET" . vertico-directory-enter)
              ("DEL" . vertico-directory-delete-char)
              ("M-DEL" . vertico-directory-delete-word)
	      )
  :custom
  (vertico-mode t)
  (vertico-cycle t)
  (eldoc-mode t)
  :hook (rfn-eshadow-update-overlay . vertico-directory-tidy))

(use-package marginalia
  :after vertico
  :custom
  (marginalia-mode t))

(use-package consult
  :after vertico)

(use-package orderless
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles basic partial-completion))))
  (setq orderless-affix-dispatch-alist
	'((37 . char-fold-to-regexp) (33 . orderless-not)
	  (35 . orderless-annotation) (44 . orderless-initialism)
	  (61 . orderless-literal) (94 . orderless-literal-prefix)
	  (126 . orderless-flex))))

(use-package ctrlf
  :defer t
  :custom
  (ctrlf-mode t)
  :bind (:map ctrlf-minibuffer-mode-map
	      ("<escape>" . minibuffer-keyboard-quit)
	      ("<remap> <photon-C-j>" . ctrlf-forward-default)
	      ("<remap> <photon-C-k>" . ctrlf-backward-default)))

(use-package corfu
    :config
    (setq corfu-auto t
  	corfu-auto-delay 0.1
  	corfu-auto-prefix 2)
    ;;  :hook
    ;;  (org-mode . (lambda () (photon-completion--check)))
    :bind
    (:map corfu-map
  	("<remap> <photon-C-j>" . corfu-next)
  	("<remap> <photon-C-k>" . corfu-previous)))

  (defun photon-completion--check ()
    (interactive)
    (if (string-match-p (regexp-quote org-roam-directory)
                        (buffer-file-name))
        (progn
  	(corfu-mode t)
  	(setq-local completion-at-point-functions '(photon-completion)))))

;;  (add-hook 'org-mode-hook 'photon-completion--check)

;;  (use-package which-key
;;    :init (which-key-mode)
;;    :diminish
;;    :config
;;    (setq which-key-idle-delay 0.1)
;;    (setq which-key-popup-type 'side-window)
;;    (setq which-key-side-window-location 'bottom)
;;    (setq which-key-side-window-max-width 0.1)
;;    )

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

(use-package helpful
  :defer t
  :custom
  (describe-function-function #'helpful-callable)
  (describe-variable-function #'helpful-variable)
  :bind
  ([remap describe-command] . helpful-command)
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
  :init
  (use-package transient)
  :diminish (magit-auto-revert-mode auto-revert-mode)
  :custom
  (magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1))

(defvar ssh-available nil)
(if (and (file-directory-p "/Local/Documents/Photon/keychain/.ssh")
	 (not (file-directory-p "/root/.ssh")))
    (copy-directory "/Local/Documents/Photon/keychain/.ssh" "/root/.ssh")
  (setq ssh-available t)) 
(defvar ssh-setup-buffer)
(defvar ssh-setup-status nil)
(defun ssh-setup ()
  (interactive)
  (if ssh-available
      (unless ssh-setup-status
        (let ((ssh-setup-buffer (current-buffer)))
          (shell)
          (process-send-string "*shell*"
                               "chmod 600 /root/.ssh/id_ed25519 && ssh-agent > /dev/null 2>&1 && eval $(ssh-agent) > /dev/null 2>&1 && ssh-add ~/.ssh/id_ed25519 \n")
          (switch-to-buffer ssh-setup-buffer)
          (setq ssh-setup-status t)))))
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
(use-package tree-sitter
  :defer t)
(use-package tree-sitter-langs
  :defer t)
;; (require 'tree-sitter-hl)
;; (require 'tree-sitter-debug)
;; (require 'tree-sitter-query)
(add-hook 'rustic-mode-hook #'tree-sitter-hl-mode)

;;  (use-package company
;;    :defer t
;;    :hook
;;    (lsp-mode . company-mode)
;;    (org-mode . company-mode)
;;    :bind (:map company-active-map
;;		("<tab>" . company-complete-selection)
;;		("<return>" . nil))
;;    :init
;;    (company-mode 1)
;;    (company-mode -1)
;;    (setq company-minimum-prefix-length 2)
;;    (setq company-idle-delay 0.0))
;;
;;  (use-package company-box
;;    :defer t
;;    :diminish
;;    :hook (company-mode . company-box-mode))

;; (use-package auctex
;;   :defer t
;;   :ensure t)
;; ;; (add-hook 'org-mode-hook (lambda () (require 'org-auctex)))
;; ;; (add-hook 'org-mode-hook (lambda () (org-auctex-mode 1)))
;; (setq preview-auto-cache-preamble t)

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
  (setq yas-snippet-dirs '("/Local/Documents/Photon/snippets"))
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
  :defer t
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

(use-package avy
  :defer t)

;;  (use-package zoom
;;    :init
;;    (zoom-mode t)
;;    )

(use-package expand-region)

;; (use-package visual-regexp-steroids)

(use-package good-scroll
  :config
  (setq good-scroll-mode t))

(use-package autothemer)
(add-to-list 'custom-theme-load-path "~/.emacs.d/add-ons")

;; (use-package diminish)
;; (diminish 'visual-line-mode)

(use-package nerd-icons
  :custom
  (nerd-icons-color-icons t)
  (nerd-icons-scale-factor 1)
  )

;;  (use-package all-the-icons
;;    :custom
;;    (all-the-icons-scale-factor 1)
;;    (all-the-icons-install-fonts)
;;    )

(eval-after-load 'dired '(progn (require 'joseph-single-dired)))
(add-hook 'dired-mode-hook #'dired-hide-details-mode)

;;  (use-package neotree
;;    :config
;;    (setq neo-theme 'icons))

(use-package nerd-icons-dired
  :hook
  (dired-mode . nerd-icons-dired-mode))

;;  (use-package nerd-icons-ivy-rich
;;    :init
;;    (nerd-icons-ivy-rich-mode 1))
(use-package nerd-icons-completion
  :config
  (nerd-icons-completion-mode)
  (nerd-icons-completion-marginalia-setup))

;;  (use-package shrink-path
;;    :ensure t
;;    :demand t
;;    :diminish)

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

;;  (use-package doom-themes)
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
  (set-face-attribute 'org-table nil :family "Liga SFMono Nerd Font")
  (set-face-attribute 'org-code nil :family "Liga SFMono Nerd Font"))

(add-hook 'org-mode-hook
	    (lambda ()
	      (variable-pitch-mode t)))
(add-hook 'org-mode-hook 'org-font-setup)
(set-face-attribute 'variable-pitch nil :family "Lora")

(use-package org
  :config
  ;; (setq org-ellipsis " ▾")
  (delete-selection-mode t)
  (with-eval-after-load 'org
    (setf (cdr (assoc 'file org-link-frame-setup)) 'find-file)
    (org-babel-do-load-languages
     'org-babel-load-languages
     '((emacs-lisp . t)
	 (octave . t)
	 (latex . t)
	 (python .t)
	 (C . t)))
    ))

(use-package org-modern
  :load-path "~/.emacs.d/add-ons"
  :custom
  (setq org-modern-hide-stars 't)
  (setq org-modern-block-fringe 2)
  (org-ellipsis "..."))
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
  :defer t
  :config
  (add-hook 'org-mode-hook 'toc-org-mode)
  (add-hook 'markdown-mode-hook 'toc-org-mode)
  )

;;  (use-package org-appear
;;    :config
;;    (org-appear-mode t))

(use-package org-fragtog
  :load-path "~/.emacs.d/add-ons"
  :hook (org-mode . org-fragtog-mode))

(use-package flyspell-correct
  :after flyspell
  :bind ("C-;" . flyspell-correct-wrapper)
  :init
  (evil-define-key 'normal flyspell-mode-map (kbd "<return>") #'flyspell-correct-wrapper)
  (evil-define-key 'visual flyspell-mode-map (kbd "<return>") #'flyspell-correct-wrapper))

;;  (unless (file-directory-p "~/.emacs.d/previewcache")
;;    (make-directory "~/.emacs.d/previewcache")) 
;;  (setq temporary-file-directory "~/.emacs.d/previewcache")
;;  (setq org-latex-pdf-process '("latex -shell-escape -interaction nonstopmode %f"))
;;  (setq org-latex-create-formula-image-program 'dvipng)
;;  (setq org-preview-latex-default-process 'dvipng)
;;  (setq org-latex-pdf-process '("pdflatex -interaction nonstopmode -output-directory %o %f"))
  (use-package math-preview
    :config (math-preview-start-process))

(use-package org-roam
  :config
  (setq org-roam-capture-templates
  	'(("d" "default" plain "%?"
  	   :target (file+head "%<%Y%m%d%H%M%S>-${slug}.org"
  			      "#+filetags: %(file-name-nondirectory (directory-file-name default-directory))\n#+title: ${title}\n")
  	   :unnarrowed t)))
  :bind (("C-c n l" . org-roam-buffer-toggle)
  	 ("C-c n f" . org-roam-node-find)
  	 ("C-c n i" . org-roam-node-insert))
  :config
  (org-roam-setup))

;;  (defun photon-node-find (&optional other-window initial-input &key templates)
;;    "Find or create an Org-roam node, prompting for a tag if new.
;;  If the node doesn't exist, prompt the user to select a tag,
;;  creating a new tag directory if the input doesn't match existing ones."
;;    (interactive current-prefix-arg)
;;    (let* ((node (org-roam-node-read initial-input))
;;           (node-file (org-roam-node-file node)))
;;      (if node-file
;;          (org-roam-node-visit node other-window)
;;        (let* ((existing-tags (org-roam-tag-completions))
;;               (tag (completing-read "Tag: " existing-tags)))
;;          (if (member tag existing-tags)
;;              (let* ((tag-dir (concat "/Local/Documents/Photon/org-roam/" tag "/"))
;;  		   (org-roam-directory tag-dir))
;;  	      (org-roam-capture-
;;  	       :node node
;;  	       :templates templates
;;  	       :props `((:finalize find-file) (:tags ,tag))))
;;	    (if (string-match-p "^[[:alnum:]_-]+$" tag)
;;		(let* ((new-dir (concat "/Local/Documents/Photon/org-roam/" tag "/"))
;;  		     (org-roam-directory new-dir))
;;  		  (unless (file-exists-p new-dir)
;;  	          (make-directory new-dir))
;;  		  (org-roam-capture-
;;  		   :node node
;;  		   :templates templates
;;  		   :props `((:finalize find-file) (:tags ,tag))))
;;	      (message "Error: your tag name contains invalid characters or whitespace")))))))

(defun photon-nf--create-tag-source (tag)
  `(:name     ,tag
	      :category tag
	      :narrow   ?m
	      :items    (lambda ()
			  (org-roam-node-read--completions
			   (lambda (node)
			     (member ,tag (org-roam-node-tags node)))))
	      :action  (lambda (node)
			 (org-roam-node-open node))
	      :new (lambda (newnode))
	      (message "Hello!")))

(defun photon-nf--generate-tag-sources ()
  (let ((tag-sources '()))
    (with-current-buffer (get-buffer "*scratch*")
      (dolist (tag (org-roam-tag-completions))
        (push (photon-nf--create-tag-source tag) tag-sources)))
    tag-sources))


(defun photon-nf ()
  (interactive)
  (let ((selected (consult--multi (photon-nf--generate-tag-sources) 
                                  :prompt "Node: "
                                  :require-match nil)))
    (if (eq (plist-get (cdr selected) :match) 'new)
        (photon-nf--create (car selected)))))

(defun photon-nf--create (input-string)
  "Parses INPUT-STRING, extracts title and stack search terms,
performs fuzzy matching with existing tags, and initiates capture."
  (let* ((parts (split-string input-string " "))
         (title (string-join (cl-remove-if (lambda (s) (string-prefix-p "#" s)) parts) " "))
         (stack-search (mapcar (lambda (s) (substring s 1))
                               (cl-remove-if-not (lambda (s) (string-prefix-p "#" s)) parts)))
         (matching-tags (org-roam-tag-completions)))
    (when stack-search
      (dolist (search-term stack-search)
        (setq matching-tags (cl-remove-if-not 
                             (lambda (tag) (string-match-p (regexp-quote search-term) tag))
                             matching-tags))))

    ;; Create the new Org-roam node first
    (let* ((new-node (org-roam-node-create :title title))) 
      (let* ((existing-tags (org-roam-tag-completions))
             (tag (if (= (length matching-tags) 1)
                      (car (last matching-tags))
                    (completing-read "Stack: " matching-tags))))
        (if (member tag existing-tags)
            (let* ((tag-dir (concat "/Local/Documents/Photon/org-roam/" tag "/"))
                   (org-roam-directory tag-dir))
              (org-roam-capture- :node new-node ; Use new-node here
                                 :props `((:finalize find-file) (:tags ,tag))))
          (if (string-match-p "^[[:alnum:]_-]+$" tag)
              (let* ((new-dir (concat "/Local/Documents/Photon/org-roam/" tag "/"))
                     (org-roam-directory new-dir))
                (unless (file-exists-p new-dir)
                  (make-directory new-dir))
                (org-roam-capture- :node new-node ; Use new-node here
                                   :props `((:finalize find-file) (:tags ,tag))))
            (message "Error: your tag name contains invalid characters or whitespace")))))))

(use-package org-roam-ui
  :defer t
  :config
  (setq org-roam-ui-sync-theme t
	  org-roam-ui-follow t
	  org-roam-ui-update-on-save t
	  org-roam-ui-open-on-start t
	  org-roam-ui-browser-function #'xwidget-webkit-browse-url)
  :hook
  (xwidget-webkit-mode . (lambda () (display-line-numbers-mode -1))))

;;  (use-package org-transclusion
;;    :diminish
;;    )

;;  (defun org-roam-node-candidates ()
;;    ;; (org-roam-db-sync) ; Synchronize the Org-roam database to ensure it's up-to-date
;;    (mapcar (lambda (node)
;;	      (cons (org-roam-node-title node)
;;		    (format "[[id:%s][%s]]" (org-roam-node-id node) (org-roam-node-title node))))
;;	    (org-roam-node-list)))
;;
;;  (defvar company-node-candidates (org-roam-node-candidates))
;;
;;  (defun company-node-backend (command &optional arg &rest ignored)
;;    (interactive (list 'interactive))
;;    (cl-case command
;;      (interactive (company-begin-backend 'company-node-backend))
;;      (prefix (and (eq major-mode 'org-mode) (company-grab-symbol)))
;;      (candidates
;;       (let ((prefix (downcase arg)))
;;	 (seq-filter
;;	  (lambda (candidate)
;;	    (string-prefix-p prefix (downcase candidate)))
;;	  (mapcar #'car company-node-candidates))))
;;      (annotation
;;       "[Node]")
;;      (ignore-case t)
;;      (post-completion
;;       (let ((selected-candidate (assoc arg company-node-candidates)))
;;	 (when selected-candidate
;;	   (delete-region (- (point) (length arg)) (point))
;;	   (insert (cdr selected-candidate)))))))
;;
;;  ;; Add the backend to the list of backends
;;  (add-to-list 'company-backends 'company-node-backend)
;;  (add-hook 'org-mode-hook (lambda () (setq-local company-backends '(company-node-backend))))
;;
;;  (defun org-roam-node-update ()
;;    (let ((candidates (org-roam-node-candidates)))
;;      (setq company-node-candidates candidates)
;;      (add-to-list 'company-backends 'company-node-backend)))
;;
;;  (org-roam-node-update) ; Call it once to set up initially
;;
;;  (run-with-timer 0 5 #'org-roam-node-update)

(defun photon-completion--titles ()
  "Return a list of node titles that have the given TAG."
  (let* ((current-tag (car (org-roam-node-tags (org-roam-node-at-point)))))
    (let (titles)
      (dolist (node (org-roam-node-list))
	(when (member current-tag (org-roam-node-tags node))
          (push (org-roam-node-title node) titles)))
      titles)))

(defun photon-completion--nodeid (title)
  "Find the ID for the node with title TITLE and perform an insertion"
  (let* ((current-tag (car (org-roam-node-tags (org-roam-node-at-point))))
         (node (cl-find-if
                (lambda (node)
                  (let ((node-data (cdr node))) ; Extract org-roam-node here
                    (and (string= (org-roam-node-title node-data) title)
                         (member current-tag (org-roam-node-tags node-data)))))
                (org-roam-node-read--completions nil nil)))
         (id (if node  ; Check if node is not nil
                 (org-roam-node-id (cdr node)) ; Extract org-roam-node for ID
               nil)))
    (insert (format "[[id:%s][%s]]" id title))))


(defun photon-completion ()
  (when (and (thing-at-point 'word)
             (not (org-in-src-block-p))
             (not (save-match-data (org-in-regexp org-link-any-re))))
    (let ((bounds (bounds-of-thing-at-point 'word)))
      (list (car bounds) (cdr bounds)
            (photon-completion--titles)
            :exit-function
            (lambda (str _status)
              (delete-char (- (length str)))
	      (photon-completion--nodeid str))
            ;; Proceed with the next completion function if the returned titles
            ;; do not match. This allows the default Org capfs or custom capfs
            ;; of lower priority to run.
            :exclusive 'no))))

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

(defface photon-transient-dynamic-face
  '((t (:foreground "#7FB4CA" :weight bold)))
  "Face for dynamic transients")


(defun photon-find-file ()
  "Open find-file with specific behavior based on context."
  (interactive)
  (cond ((eq major-mode 'dired-mode)
         (call-interactively 'find-file))
        ((and (buffer-file-name) 
              (string-match "/Local/" (buffer-file-name)))
         (call-interactively 'find-file)) 
        (t 
         (let ((default-directory "/Local/"))
           (call-interactively 'find-file))))) 


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
	(define-key dired-mode-map (kbd "<visual-state> SPC") 'photon/main))
      )
    )
  )


(defun photon-C-c ()
  (interactive)
  (execute-kbd-macro (kbd "C-c C-c")))

;;    (defun photon-select-roam-dir ()
;;      "Presents a list of directories in /Local/Documents/Photon/org-roam
;;        and sets org-roam-directory to the selected one."
;;      (interactive)
;;      (let* ((root-dir "/Local/Documents/Photon/org-roam/")
;;             (dir-list (cl-loop for file in (directory-files root-dir t)
;;                                when (and (file-directory-p file)
;;                                          (not (string= "." (file-name-nondirectory file)))
;;                                          (not (string= ".." (file-name-nondirectory file)))
;;        				      (not (string= "quicknotes" (file-name-nondirectory file)))				)
;;                                collect (file-name-nondirectory
;;                                         (substring file (length root-dir) nil)))))
;;        (when dir-list
;;          (let ((selected-dir (completing-read "Select org-roam directory: " dir-list)))
;;        	(unless (member selected-dir dir-list)
;;        	  (make-directory (concat root-dir selected-dir)))
;;            (setq org-roam-directory (concat root-dir selected-dir))
;;        	(setq org-roam-db-location (concat root-dir selected-dir "/org-roam.db"))
;;            (org-roam-db-sync)))))

(defun photon-quicknote ()
  "A wrapper around org-roam-node-find for a quicknote directory. Temporarily sets the Roam database to this directory to allow searching and note creation."
  (interactive)
  (let ((quicknote-dir "/Local/Documents/Photon/org-roam/quicknotes"))
    (photon-check-dir quicknote-dir)
    (let ((org-roam-directory quicknote-dir)
          (org-roam-db-location (concat quicknote-dir "/org-roam.db")))
      (org-roam-db-sync)
      (org-roam-node-find)
      (company-mode -1))
    (org-roam-db-sync)))
;;  (add-hook 'org-capture-after-finalize-hook 'org-roam-db-sync)

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
    "  Quick commands"
    ("f" "Search in buffer..." ctrlf-forward-default)
    ("F" "󰁣 Search in directory..." consult-ripgrep)
    ("x" "Execute command..." execute-extended-command)
    ("p" "Switch perspective..." persp-switch)
    ]
   ["  Buffer actions"
    ("b" "Switch buffer...     " persp-switch-to-buffer*)
    ("k" "Kill current buffer" kill-current-buffer)
    ("K" "󰁣 Kill buffer..." persp-kill-buffer*)
    ("l" "Next buffer" next-buffer :transient t)
    ("h" "Previous buffer" previous-buffer :transient t)
    ""
    ("z" "Focus current buffer" photon-focus-buffer)
    ("u" "Update current buffer" revert-buffer-quick)
    ("m" "Toggle active buffer zoom" zoom-mode)
    ]
   ["  Keybind sets"
    ("w" "   Window settings..." photon/window)
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
    ]
   ["  Text scaling"
    ("=" "Increase in current buffer" text-scale-increase :transient t)
    ("-" "Decrease in current buffer" text-scale-decrease :transient t)
    (global-scale-inc)
    (global-scale-dec)]
   ])

(transient-define-prefix photon/org ()
  [" "
   ["󱓦 Editing commands"
    ("t" "Tangle code blocks" org-babel-tangle)
    ("v" org-entities-toggle
     :description
     (lambda ()
       (format "Toggle entities [%s]" (propertize org-entities-state 'face 'photon-transient-dynamic-face))))
    ("f" "Change document font..." photon-face-selection)
    ]
   ["󱇣 Preview commands"
    ("p" org-fragtog-mode
     :description
     (lambda ()
       (format "Toggle LaTeX auto-preview [%s]" (if org-fragtog-mode
						    (propertize "ACTIVE" 'face 'photon-transient-dynamic-face)
						  (propertize "INACTIVE" 'face 'photon-transient-dynamic-face))))
     )
    ("a" "Preview all LaTeX fragments" math-preview-all)
    ("x" "Clear all LaTeX fragments" math-preview-clear-all)
    ("i" "Preview images" org-redisplay-inline-images)
    ]
   [" Org Roam"
    ("g" "Goto node..." photon-nf)
    ("l" "Link to node..." org-roam-node-insert)
    ("m" "Make node from header" org-id-get-create)
    ("u" "Open graph UI" org-roam-ui-open)
    ("q" "Quicknote..." photon-quicknote)
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
   		   ("M-h" . windmove-left)
   		   ("M-j" . windmove-down)
   		   ("M-k" . windmove-up)
   		   ("M-l" . windmove-right)
   		   ("C-j" . photon-C-j)
   		   ("C-k" . photon-C-k)
   		   ("C-? k" . helpful-key)
   		   ("C-? f" . helpful-function)
   		   ("C-? v" . helpful-variable)
   		   ("C-<return>" . photon-C-c)
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

(with-eval-after-load 'dired
  (define-key dired-mode-map (kbd "<normal-state> SPC") 'photon/main)
  (define-key dired-mode-map (kbd "<visual-state> SPC") 'photon/window))

(define-key evil-visual-state-map (kbd "e") 'er/expand-region)
(define-key evil-normal-state-map (kbd "e")
	    (lambda ()
	      (interactive)
	      (evil-visual-char)
	      (er/expand-region 1)))
(define-key transient-base-map (kbd "<escape>") 'transient-quit-all)

(setq gc-cons-threshold (expt 2 23))
