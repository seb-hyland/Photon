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
(defvar addons-dir "~/.emacs.d/add-ons/")
(add-to-list 'load-path addons-dir)

(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure t)

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
(global-auto-revert-mode t)
(column-number-mode t)
(setq visible-bell t)
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)
(set-face-attribute 'default nil :family "Liga SFMono Nerd Font" :height 135)
(set-face-attribute 'line-number nil :inherit 'default :foreground "#3f4040" :slant 'normal :weight 'semi-bold :family "Liga SFMono Nerd Font")
(set-face-attribute 'line-number-current-line nil :inherit 'hl-line-default :foreground "#81a2be" :slant 'normal :weight 'extra-bold :family "Liga SFMono Nerd Font Nerd Font")
(setq frame-title-format nil)
(prefer-coding-system 'utf-8)
(global-visual-line-mode t)
(setq default-frame-alist
      '((width . 150) (height . 45)))
(setenv "TZ" "PST8PDT,M3.2.0,M11.1.0")
(setq display-line-numbers-type 'relative)
(menu-bar--display-line-numbers-mode-visual)
(add-hook 'prog-mode-hook (lambda () (electric-pair-local-mode t)))
(setq split-width-threshold 1)

(add-hook 'emacs-startup-hook (lambda ()
				(global-display-line-numbers-mode t)
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

(setq org-roam-directory "/Local/Documents/Photon/org-roam")
(setq org-roam-db-location "/Local/Documents/Photon/org-roam/database.db")

(use-package vertico
  :demand t
  :bind (
	 :map vertico-map
         ("<remap> <photon-C-j>" . vertico-next)
         ("<remap> <photon-C-k>" . vertico-previous)
         ("RET" . vertico-directory-enter)
         ("DEL" . vertico-directory-delete-char)
         ("M-DEL" . vertico-directory-delete-word))
  :config
  (vertico-mode t)
  (eldoc-mode t)
  :custom
  (vertico-cycle t)
  :hook
  (rfn-eshadow-update-overlay . vertico-directory-tidy))

(use-package marginalia
  :after vertico
  :config
  (marginalia-mode t))

(use-package consult
  :after vertico)

(use-package orderless
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles basic partial-completion))))
  (orderless-affix-dispatch-alist
   '((37 . char-fold-to-regexp) (33 . orderless-not)
     (35 . orderless-annotation) (44 . orderless-initialism)
     (61 . orderless-literal) (94 . orderless-literal-prefix)
     (126 . orderless-flex))))

(use-package ctrlf
  :defer t
  :bind (
	 :map ctrlf-minibuffer-mode-map
	 ("<escape>" . minibuffer-keyboard-quit)
	 ("<remap> <photon-C-j>" . ctrlf-forward-default)
	 ("<remap> <photon-C-k>" . ctrlf-backward-default))
  :config
  (ctrlf-mode t))

(use-package corfu
  :bind (
  	 :map corfu-map
  	 ("<remap> <photon-C-j>" . corfu-next)
  	 ("<remap> <photon-C-k>" . corfu-previous))
  :custom
  (corfu-auto t)
  (corfu-auto-delay 0.1)
  (corfu-auto-prefix 2))

(defun photon-completion--check ()
  "Check if photon completion should be active."
  (interactive)
  (when-let ((file-name (buffer-file-name)))
    (if (or (string-match-p (regexp-quote org-roam-directory) file-name)
            (org-roam-capture-p))
        (progn
          (corfu-mode t)
          (setq-local completion-at-point-functions '(photon-completion))))))

(add-hook 'org-mode-hook #'photon-completion--check)

;;  (use-package which-key
;;    :init (which-key-mode)
;;    :config
;;    (setq which-key-idle-delay 0.1)
;;    (setq which-key-popup-type 'side-window)
;;    (setq which-key-side-window-location 'bottom)
;;    (setq which-key-side-window-max-width 0.1)
;;    )

(use-package evil
  :demand t
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)
  (setq evil-want-C-i-jump nil)
  (setq evil-respect-visual-line-mode t)
  :bind (
	 :map evil-normal-state-map
	 ("e" .
	  (lambda ()
	    (interactive)
	    (evil-visual-char)
	    (er/expand-region 1)))
	 :map evil-insert-state-map
	 ("C-g" . evil-normal-state)
	 :map evil-visual-state-map
	 ("e" . er/expand-region)
	 :map evil-motion-state-map
	 ("j" . evil-next-visual-line)
	 ("k" . evil-previous-visual-line))
  :config
  (evil-mode t)
  (evil-set-initial-state 'messages-buffer-mode 'normal)
  (evil-set-initial-state 'dashboard-mode 'normal)
  (evil-set-undo-system 'undo-redo))

(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

(use-package helpful
  :defer t
  :custom
  (describe-function-function #'helpful-callable)
  (describe-variable-function #'helpful-variable))

(use-package magit
  :defer t
  :custom
  (magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1))

(use-package transient
  :demand t
  :bind (
    	 :map transient-base-map
    	 ("<escape>" . transient-quit-all)))

(defun ssh-available-p ()
  (if (file-directory-p "/Local/Documents/Photon/keychain/.ssh")
      t
    nil)) 
(defvar ssh-setup-status nil)

(defun ssh-setup ()
  (interactive)
  (if (ssh-available-p)
      (unless ssh-setup-status
        (let* ((display-buffer-alist '(((lambda (bufname _action)
					  ((string= bufname "ssh-setup")))
					display-buffer-no-window (allow-no-window . t)))))
	  (setq ssh-setup-status t)
	  (async-shell-command "chmod 600 /Local/Documents/Photon/keychain/.ssh/id_ed25519 && ssh-agent > /dev/null 2>&1 && eval $(ssh-agent) > /dev/null 2>&1 && ssh-add /Local/Documents/Photon/keychain/.ssh/id_ed25519" "ssh-setup")))))

(add-hook 'magit-mode-hook #'ssh-setup)

(unless (file-exists-p "/Local/Documents/Photon/keychain/.gitconfig")
  (write-region "" nil "/Local/Documents/Photon/keychain/.gitconfig"))
(f-symlink "/Local/Documents/Photon/keychain/.gitconfig" "~/.gitconfig")

(use-package tree-sitter
  :defer t)
(use-package tree-sitter-langs
  :defer t)
(add-hook 'rustic-mode-hook #'tree-sitter-hl-mode)

;; (use-package auctex
;;   :defer t
;;   :ensure t)
;; ;; (add-hook 'org-mode-hook (lambda () (require 'org-auctex)))
;; ;; (add-hook 'org-mode-hook (lambda () (org-auctex-mode 1)))
;; (setq preview-auto-cache-preamble t)

(use-package yasnippet
  :custom
  (yas-snippet-dirs '("/Local/Documents/Photon/snippets"))
  :config
  (yas-global-mode t)
  (append yas-snippet-dirs '("/root/.emacs.d/snippets-core/")))

(use-package vterm
  :defer t
  :load-path "~/.emacs.d/vterm")

(use-package vterm-toggle
  :custom
  (vterm-toggle-fullscreen-p nil)
  (vterm-shell "fish")
  :config
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
  (good-scroll-mode t))

(use-package autothemer)
(add-to-list 'custom-theme-load-path addons-dir)

(use-package nerd-icons
  :custom
  (nerd-icons-color-icons t)
  (nerd-icons-scale-factor 1)
  )

(use-package nerd-icons-dired
  :hook
  (dired-mode . nerd-icons-dired-mode))

(use-package nerd-icons-completion
  :config
  (nerd-icons-completion-mode)
  (nerd-icons-completion-marginalia-setup))

(eval-after-load 'dired
  '(progn
     (use-package joseph-single-dired
       :load-path addons-dir)))

(add-hook 'dired-mode-hook #'dired-hide-details-mode)

;;  (use-package doom-themes)
  ;; :defer t
  ;; :ensure t
  ;; :config
  ;; (setq doom-themes-enable-bold t 
  ;; doom-themes-enable-italic t)
  ;; (doom-themes-visual-bell-config))

(use-package doom-nano-modeline
  :load-path addons-dir
  :config
  (doom-nano-modeline-mode t))

(use-package hide-mode-line
  :init
  (global-hide-mode-line-mode t))

(use-package spacious-padding
  :init
  (spacious-padding-mode))

(use-package dashboard
  :custom
  (nerd-icons-font-family "Symbols Nerd Font Mono")
  :config
  (dashboard-setup-startup-hook))

(load-file "~/.emacs.d/add-ons/photon-dashboard.el")
(add-hook 'window-setup-hook (lambda () (dashboard-open)))
(add-hook 'window-setup-hook (lambda() (set-face-attribute 'dashboard-heading nil
							   :family "Liga SFMono Nerd Font")))

(use-package rainbow-delimiters
  :defer t
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
  (delete-selection-mode t)
  (setf (cdr (assoc 'file org-link-frame-setup)) 'find-file)
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((emacs-lisp . t)
     (octave . t)
     (latex . t)
     (python .t)
     (C . t))))

(use-package org-modern
  :load-path addons-dir
  :init
  (setq org-modern-hide-stars 't
	org-modern-block-fringe 2
	org-ellipsis "...")
  :custom
  (org-catch-invisible-edits 'show-and-error)
  (org-insert-heading-respect-content t)
  )

(use-package toc-org
  :defer t
  :hook
  (org-mode . toc-org-mode)
  (markdown-mode . toc-org-mode))

;;  (use-package org-appear
;;    :config
;;    (org-appear-mode t))

(use-package org-fragtog
  :load-path addons-dir
  :hook
  (org-mode . org-fragtog-mode))

(use-package flyspell-correct
  :after flyspell
  :init
  (evil-define-key 'normal flyspell-mode-map (kbd "<return>") #'flyspell-correct-wrapper)
  (evil-define-key 'visual flyspell-mode-map (kbd "<return>") #'flyspell-correct-wrapper)
  :bind ("C-;" . flyspell-correct-wrapper))

(setq org-latex-pdf-process
      '("tectonic %f"))
(use-package math-preview
  :config (math-preview-start-process))

(use-package org-roam
  :commands
  (org-roam-node-read--completions
   org-roam-tag-completions
   org-roam-node-open
   org-roam-node-tags
   org-roam-node-create)
  :custom
  (org-roam-capture-templates
   '(("d" "default" plain "%?"
      :target (file+head "%<%Y%m%d%H%M%S>-${slug}.org"
   			 "#+filetags: %(file-name-nondirectory (directory-file-name default-directory))\n#+title: ${title}\n")
      :unnarrowed t)))
  :config
  (org-roam-setup))

(defun photon-nf--create-tag-source (tag)
  `(
    :name ,tag
    :category tag
    :narrow ?m
    :items (lambda ()
             (org-roam-node-read--completions
              (lambda (node)
              	(member ,tag (org-roam-node-tags node)))))
    :action (lambda (node)
              (org-roam-node-open node))
    :new (lambda (node))))

(defun photon-nf--generate-tag-sources ()
  "Generate tag sources for narrowing, excluding 'quicknotes'."
  (let ((tag-sources '()))
    (with-current-buffer (get-buffer "*scratch*")
      (dolist (tag (org-roam-tag-completions))
        (unless (string= tag "quicknotes") 
          (push (photon-nf--create-tag-source tag) tag-sources))))
    tag-sources))

(defun photon-nf ()
  (interactive)
  (let ((selected (consult--multi (photon-nf--generate-tag-sources) 
                                  :prompt "Node: "
                                  :require-match nil)))
    (if (eq (plist-get (cdr selected) :match) 'new)
        (photon-nf--create (car selected)))))

(defun photon-nf--create (input-string)
  "Parses INPUT-STRING, extracts title and stack search terms, performs fuzzy matching with existing tags, and initiates capture."
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
    (let* ((new-node (org-roam-node-create :title title))) 
      (let* ((existing-tags (org-roam-tag-completions))
             (tag (if (= (length matching-tags) 1)
                      (car (last matching-tags))
                    (completing-read "Stack: " matching-tags))))
        (if (member tag existing-tags)
            (let* ((tag-dir (concat "/Local/Documents/Photon/org-roam/" tag "/"))
                   (org-roam-directory tag-dir))
              (org-roam-capture- :node new-node
                                 :props `((:finalize find-file) (:tags ,tag))))
          (if (string-match-p "^[[:alnum:]_-]+$" tag)
              (let* ((new-dir (concat "/Local/Documents/Photon/org-roam/" tag "/"))
                     (org-roam-directory new-dir))
                (unless (file-exists-p new-dir)
                  (make-directory new-dir))
                (org-roam-capture- :node new-node
                                   :props `((:finalize find-file) (:tags ,tag))))
            (message "Error: your tag name contains invalid characters or whitespace")))))))

(defun photon-qn--create-qn-source ()
  `(
    :name "Quicknotes"
    :category tag
    :narrow ?m
    :items (lambda ()
             (org-roam-node-read--completions
              (lambda (node)
                (member "quicknotes"
                        (org-roam-node-tags node)))))
    :action (lambda (node)
              (org-roam-node-open node))
    :new (lambda (node))))

(defun photon-qn--create (title)
  (let* ((new-node (org-roam-node-create :title title))
         (tag-dir
          "/Local/Documents/Photon/org-roam/quicknotes/")
	 (org-roam-directory tag-dir))
    (org-roam-capture- :node new-node
                       :props `((:finalize find-file)
				(:tags "quicknotes")))))

(defun photon-qn ()
  (interactive)
  (let ((selected (consult--multi (list
                                   (photon-qn--create-qn-source))
                                  :prompt "Quicknote: "
                                  :require-match nil)))
  (if (eq (plist-get (cdr selected) :match) 'new)
      (photon-qn--create (car selected)))))

(use-package org-roam-ui
  :defer t
  :custom
  (org-roam-ui-sync-theme t)
  (org-roam-ui-follow t)
  (org-roam-ui-update-on-save t)
  (org-roam-ui-open-on-start t)
  (org-roam-ui-browser-function #'xwidget-webkit-browse-url)
  :hook
  (xwidget-webkit-mode . (lambda () (display-line-numbers-mode -1))))

;;  (use-package org-transclusion
;;    :diminish
;;    )

(defun photon-completion--titles ()
  "Return a list of node titles that have the given TAG.
  Handles both regular buffers and org-roam capture buffers."
  (let ((current-tag (photon-completion--get-current-tag)))
    (when current-tag
      (let (titles)
        (dolist (node (org-roam-node-list))
          (when (member current-tag (org-roam-node-tags node))
            (push (org-roam-node-title node) titles)))
        titles))))

(defun photon-completion--nodeid (title)
  "Find the ID for the node with title TITLE and perform an insertion.
  Handles both regular buffers and org-roam capture buffers."
  (let ((current-tag (photon-completion--get-current-tag)))
    (when current-tag
      (let* ((node (cl-find-if
                    (lambda (node)
                      (let ((node-data (cdr node)))
                        (and (string= (org-roam-node-title node-data) title)
                             (member current-tag (org-roam-node-tags node-data)))))
                    (org-roam-node-read--completions nil nil)))
             (id (if node
                     (org-roam-node-id (cdr node))
                   nil)))
        (insert (format "[[id:%s][%s]]" id title))))))

(defun photon-completion--get-current-tag ()
  "Get the current tag based on context.
Handles both regular buffers and org-roam capture buffers."
  (if (org-roam-capture-p)
      (file-name-nondirectory (directory-file-name default-directory))
    (car (org-roam-node-tags (org-roam-node-at-point)))))

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
            :exclusive 'no))))

(unless (file-exists-p "/Local/Documents/Photon/keychain/gemini")
  (write-region "" nil "/Local/Documents/Photon/keychain/gemini"))

(defun get-gemini-key ()
  (with-temp-buffer
    (insert-file-contents "/Local/Documents/Photon/keychain/gemini")
    (string-trim (buffer-string))))

(use-package gptel
  :defer t
  :custom
  (gptel-model "gemini-1.5-pro-latest")
  (gptel-default-mode 'org-mode)
  (gptel--system-message "")
  (gptel-backend (gptel-make-gemini "Gemini"
		   :key (get-gemini-key)
		   :stream t)))

(add-to-list 'auto-mode-alist '("\\.m$" . octave-mode))
(setq org-confirm-babel-evaluate nil)

(use-package rustic
  :defer t)

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
    ("q" "Quicknote..." photon-qn)
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

(setq gc-cons-threshold (expt 2 23))
