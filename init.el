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

(defvar photon-dir "/Local/Documents/Photon/")

(defun photon-check-dir (name)
  "Check if directory exists; if not, create it."
  (unless (file-directory-p name)
    (make-directory name)))

(dolist (dir '("sys/"
               "sys/auto-saves/"
               "sys/var/"
	       "sys/persp/"
	       "sys/trash/"
               "org-roam/"
  	       "org-roam/quicknotes/"
               "snippets/"
               "org-agenda/"
               "keychain/"
	       "sys/trash/"))
  (photon-check-dir (concat photon-dir dir)))

(setq inhibit-startup-message t
      visible-bell t
      frame-title-format nil
      default-frame-alist
      '((width . 150) (height . 45))
      display-line-numbers-type 'relative
      split-width-threshold 1
      delete-by-moving-to-trash t
      trash-directory (concat photon-dir "sys/trash"))

(scroll-bar-mode -1)   		        
(tool-bar-mode -1)     		        
(tooltip-mode -1)                            	        
(menu-bar-mode -1)
(global-auto-revert-mode t)
(column-number-mode t)
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)
(set-face-attribute 'default nil :family "Liga SFMono Nerd Font" :height 135)
(set-face-attribute 'line-number nil :inherit 'default :foreground "#3f4040" :slant 'normal :weight 'semi-bold :family "Liga SFMono Nerd Font")
(set-face-attribute 'line-number-current-line nil :inherit 'hl-line-default :foreground "#81a2be" :slant 'normal :weight 'extra-bold :family "Liga SFMono Nerd Font Nerd Font")
(prefer-coding-system 'utf-8)
(global-visual-line-mode t)
(setenv "TZ" "PST8PDT,M3.2.0,M11.1.0")
(menu-bar--display-line-numbers-mode-visual)
(add-hook 'prog-mode-hook (lambda () (electric-pair-local-mode t)))

(add-hook 'emacs-startup-hook (lambda ()
				(global-display-line-numbers-mode t)
				(display-line-numbers-mode -1)
				(load-theme 'photon-dark t)
				))

(defvar photon-var-dir (concat photon-dir "sys/var/"))

(defmacro photon-defvar (name value)
  "Define a persistent variable named NAME with initial VALUE."
  `(progn 
     (let ((var-file (concat photon-var-dir ,(symbol-name name))))
       (with-temp-buffer
         (insert (prin1-to-string ,value))
         (write-file var-file)
 	 (setq ,name ,value)
 	 ))))

(defun photon-loadvar (name)
  "Load the value of the persistent variable NAME 
 and set the variable in the current environment."
  (let ((var-file (concat photon-var-dir (symbol-name name))))
    (if (file-exists-p var-file)
	(with-temp-buffer
          (insert-file-contents var-file)
          (let ((loaded-value (read (current-buffer))))
            (setq name loaded-value))))))

(recentf-mode t)
(setq recentf-save-file (concat photon-dir "sys/recentf"))
(run-at-time nil (* 5 60) 'recentf-save-list)

(setq backup-directory-alist
      (list (cons "." (concat photon-dir "sys/auto-saves/"))))

(setq auto-save-list-file-prefix (concat photon-dir "sys/auto-saves/")
      auto-save-file-name-transforms 
      (list (list ".*" (concat photon-dir "sys/auto-saves/") t)))

(setq org-roam-directory (concat photon-dir "org-roam/"))
(setq org-roam-db-location (concat photon-dir "org-roam/database.db"))

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
          (setq-local completion-at-point-functions '(photon-completion))
	  (photon-orui-current-tag)))))

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
  (if (file-directory-p (concat photon-dir "keychain/.ssh"))
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
	  (async-shell-command (concat "chmod 600 " photon-dir "keychain/.ssh/id_ed25519 && ssh-agent > /dev/null 2>&1 && eval $(ssh-agent) > /dev/null 2>&1 && ssh-add " photon-dir "keychain/.ssh/id_ed25519") "ssh-setup")))))

(add-hook 'magit-mode-hook 'ssh-setup)

(unless (file-exists-p (concat photon-dir "keychain/.gitconfig"))
    (write-region "" nil (concat photon-dir "keychain/.gitconfig")))

;;  (use-package f
;;    :hook
;;    (magit-mode . (lambda ()
;;  		  (unless (file-exists-p "~/.gitconfig")
;;  		    (f-symlink (concat photon-dir "keychain/.gitconfig") "~/.gitconfig")))))

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
  (yas-snippet-dirs (list (concat photon-dir "snippets")))
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
  :demand t
  :init
  (setq persp-suppress-no-prefix-key-warning t)
  :config
  (persp-mode t))

(defun photon-persp-save (filename)
  (interactive "sSave-file name: ")
  (let* ((persp-file (concat photon-dir "sys/persp/" filename)))
    (if (file-exists-p persp-file)
        (delete-file persp-file t))
    (persp-state-save persp-file)))

(add-hook 'kill-emacs-hook (lambda ()
           		     (photon-persp-save (concat "autosave-" (format-time-string "%I:%M:%S%p-%d-%m-%Y")))))

(defun photon-persp-load (filename)
  (if (file-exists-p filename)
      (persp-state-load filename)
    (message "No saved perspective found!")))

(defun photon-persp-autoload ()
  (interactive)
  (let* ((latest-save 
	  (car
	   (seq-find
	    '(lambda (x) (not (nth 1 x)))
	    (sort
	     (directory-files-and-attributes (concat photon-dir "sys/persp/") 'full "autosave" t)
	     '(lambda (x y) (time-less-p (nth 5 y) (nth 5 x)))))))
	 (save-name (string-trim latest-save (concat photon-dir "sys/persp/autosave-")))
	 (new-name (concat photon-dir "sys/persp/loadedsave-" save-name)))
    (photon-persp-load latest-save)
    (copy-file latest-save new-name)))

(defun photon-persp-load--interactive ()
  (interactive)
  (let* ((files 
	  (seq-filter
           (lambda (file)
             (and (stringp file) 
		  (not (string-match-p "^\\.\\.?$" file))))
           (directory-files (concat photon-dir "sys/persp/") nil)))
	 (selected
	  (consult--read
	   (mapcar (lambda (file)
		     (concat "󱑜  " file))
		   files)
	   :prompt "Load saved perspective: "
	   :require-match t
	   ))
	 (selected-file
	  (concat photon-dir "sys/persp/" (string-trim selected "󱑜  "))))
    (photon-persp-load selected-file)))

(defun photon-persp-cleanup ()
  (interactive)
  (dolist (file (directory-files (concat photon-dir "sys/persp") t "autosave"))
    (let* ((mod-time (file-attribute-modification-time (file-attributes file)))
    	   (cutoff-time (time-subtract (current-time) (days-to-time 3))))
      (if mod-time
    	  (if (time-less-p mod-time cutoff-time)
    	      (delete-file file nil))))))

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
  :demand t
  :load-path addons-dir
  :config
  (doom-nano-modeline-mode t))

(use-package hide-mode-line
  :demand t
  :init
  (global-hide-mode-line-mode t))

(use-package spacious-padding
  :demand t
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
  (setq org-modern-hide-stars t
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

(use-package org-appear
  :load-path addons-dir
  :hook
  (org-mode . org-appear-mode))

(use-package org-fragtog
  :load-path addons-dir
  :hook
  (org-mode . org-fragtog-mode))

(use-package jinx
  :init
  (jinx-languages "en_CA" t)
  :bind (
  	 :map photon-keymap
  	 ("M-<return>" . jinx-correct))
  :hook (org-mode . jinx-mode)
  :config
  (unless (file-exists-p (concat photon-dir "sys/dictionary.dic"))
    (write-region "" nil (concat photon-dir "sys/dictionary.dic"))))

(setq org-latex-pdf-process
      '("tectonic %f"))
(use-package math-preview
  :config (math-preview-start-process))

(defun typst-to-latex ()
  (interactive)
  (search-backward "#(" nil t)
  (let ((region-start (point)))
    (forward-char 2)
    (search-forward ")#")
    (let* ((region-end (point))
           (region (buffer-substring-no-properties (+ region-start 2) (- region-end 2)))
           (region-typst (concat "\\$" region "\\$"))
	   (cache-value (search-typst-cache region)))
      (if cache-value
	  (let* ((region-latex cache-value)
		 (region-length (length region-latex)))
	    (delete-region region-start region-end)
	    (insert region-latex)
	    (goto-char (+ region-start region-length))
	    region-length)
	(let* ((command (format "echo \"%s\" | pandoc -f typst -t latex" region-typst))
	       (region-latex (shell-command-to-string command))
  	       (region-length (length (string-trim region-latex))))
	  (add-to-typst-cache region (string-trim region-latex))
	  (delete-region region-start region-end)
	  (insert (string-trim region-latex))
	  (goto-char (+ region-start region-length))
	  region-length)))))

(defun latex-to-typst ()
  (interactive)
  (let ((context (org-element-context)))
    (when (and (eq (org-element-type context) 'latex-fragment)
  	       (not (overlays-at (point))))
      (let* ((latex-code (org-element-property :value context))
             (beg (org-element-property :begin context))
             (end (org-element-property :end context))
             (trimmed-beg (save-excursion (goto-char beg) (skip-chars-forward " \t") (point)))
             (trimmed-end (save-excursion (goto-char end) (skip-chars-backward " \t") (point)))
  	     (cache-value (search-typst-cache latex-code t)))
  	(if cache-value
  	    (let ((typst (concat "#(" cache-value ")#")))
  	      (delete-region trimmed-beg trimmed-end)
  	      (insert typst)
  	      (goto-char (+ trimmed-beg 2)))
  	  (let* ((command (format "echo \"%s\" | pandoc -f latex -t typst" latex-code))
  		 (output (shell-command-to-string command))
  		 (typst (concat "#(" (substring output 1 (- (length output) 2)) ")#")))
	    (add-to-typst-cache output latex-code)
            (delete-region trimmed-beg trimmed-end)
  	    (insert typst)
  	    (goto-char (+ trimmed-beg 2))
  	    ))))))

(defun typst-to-latex-all ()
  "Convert all Typst blocks in the current buffer to LaTeX."
  (interactive)
  (message "Converting all Typst code to LaTeX...")
  (save-excursion
    (goto-char (point-min))
    (while (search-forward "#(" nil t)
      (let ((region-start (point)))
        (forward-char 2)
        (when (search-forward ")#" nil t)
          (typst-to-latex)
          (goto-char region-start))))))

(defun photon-org-typst-mode-hook ()
  "Hook function for my-typst-mode."
  (add-hook 'post-command-hook #'photon-org-typst-convert nil t)
  (add-hook 'post-command-hook #'latex-to-typst nil t)
  )

(defun photon-org-typst-convert ()
  "Run typst-to-latex when leaving a #(...Typst code here...)# region."
  (let ((end-found (search-backward ")#" nil t)))
    (when end-found
      (let ((start-found (search-backward "#(" nil t)))
        (when start-found
          (goto-char end-found)
          (goto-char (- (point) 2))
          (let ((length (typst-to-latex)))
            (goto-char (- (point) 1))
            (math-preview-at-point)
            (goto-char (+ (point) 1))
  	    (when (overlays-at (point))
  	      (progn
  		(goto-char (+ (point) 1))
  		))))))))

(define-minor-mode photon-org-typst-mode
  "Minor mode to run typst-to-latex when leaving a #(...Typst code here...)# region."
  :lighter " Typst"
  (if photon-org-typst-mode
      (photon-org-typst-mode-hook)
    (remove-hook 'post-command-hook #'photon-org-typst-convert t)
    (remove-hook 'post-command-hook #'latex-to-typst t)
    ))

(defvar photon-typst-cache nil
  "Cache for storing string pairs associated with filenames.")

(defun add-to-typst-cache (string1 string2)
  "Add a string pair to the `photon-typst-cache` for the current buffer's filename."
  (let ((filename (buffer-file-name)))
    (when filename
      (let* ((existing-entry (assoc filename photon-typst-cache))
             (new-pair (cons string1 string2)))
        (if existing-entry
            (setcdr existing-entry (append (cdr existing-entry) (list new-pair)))
          (push (cons filename (list new-pair)) photon-typst-cache))))))

(defun search-typst-cache (search-term &optional search-cdr)
  "Search the `photon-typst-cache` for the current buffer's filename and search term.
  Returns the complementary string of the matching pair.
  If `search-cdr` is non-nil, search the cdr of the pairs and return the car.
  Otherwise, search the car of the pairs and return the cdr."
  (let ((filename (buffer-file-name)))
    (when filename
      (let ((entry (assoc filename photon-typst-cache)))
        (when entry
          (let ((pairs (cdr entry)))
            (if search-cdr
                (car (cl-find-if (lambda (pair) (string-match search-term (cdr pair))) pairs))
              (cdr (cl-find-if (lambda (pair) (string-match search-term (car pair))) pairs)))))))))

(use-package org-roam
  :commands
  (org-roam-node-read--completions
   org-roam-tag-completions
   org-roam-node-open
   org-roam-node-tags
   org-roam-node-create
   org-roam-capture-p)
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
  (org-roam-db-sync)
  (if (org-roam-tag-completions)
      (let ((selected (consult--multi (photon-nf--generate-tag-sources) 
                                      :prompt "Node: "
                                      :require-match nil)))
	(if (eq (plist-get (cdr selected) :match) 'new)
            (photon-nf--create (car selected))))
    (photon-nf--init))
  (photon-completion--check))

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
	     (tag (cond
		   ((= (length matching-tags) 1) 
		    (car (last matching-tags)))
		   ((= (length matching-tags) 0)
		    (completing-read "Stack: " (org-roam-tag-completions) nil nil (string-join stack-search " ")))
		   (t 
		    (completing-read "Stack: " matching-tags)))))
	(if (member tag existing-tags)
	    (let* ((tag-dir (concat photon-dir "org-roam/" tag "/"))
		   (org-roam-directory tag-dir))
	      (org-roam-capture- :node new-node
				 :props `((:finalize find-file) (:tags ,tag))))
	  (if (string-match-p "^[[:alnum:]_-]+$" tag)
	      (let* ((new-dir (concat photon-dir "org-roam/" tag "/"))
		     (org-roam-directory new-dir))
		(make-directory new-dir)
		(org-roam-capture- :node new-node
				   :props `((:finalize find-file) (:tags ,tag))))
	    (message "Error: your tag name contains invalid characters or whitespace")))))))

(defun photon-nf--init ()
  (let* ((input-string (read-string "Node: "))
	 (parts (split-string input-string " "))
         (title (string-join (cl-remove-if (lambda (s) (string-prefix-p "#" s)) parts) " "))
         (stack-search (mapcar (lambda (s) (substring s 1))
                               (cl-remove-if-not (lambda (s) (string-prefix-p "#" s)) parts)))
	 (new-node (org-roam-node-create :title title))
	 (tag (read-string "Stack: " stack-search))
	 (tag-dir (concat photon-dir "org-roam/" tag "/"))
	 (org-roam-directory tag-dir))
    (make-directory tag-dir)
    (org-roam-capture-
     :node new-node
     :props `((:finalize find-file) (:tags ,tag)))))

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

(cl-defun photon-nl (&optional filter-fn &key templates info)
  (interactive)
  (unwind-protect
      (atomic-change-group
        (let* (region-text
               beg end
               (_ (when (region-active-p)
                    (setq beg (set-marker (make-marker) (region-beginning)))
                    (setq end (set-marker (make-marker) (region-end)))
                    (setq region-text (org-link-display-format (buffer-substring-no-properties beg end)))))
	       (tag (photon-completion--get-current-tag))
	       (node (org-roam-node-read region-text
					 (lambda (node)
					   (member tag (org-roam-node-tags node)))))
	       (org-roam-directory (concat photon-dir "org-roam/" tag "/"))
               (description (or region-text
                                (org-roam-node-formatted node))))
          (if (org-roam-node-id node)
              (progn
                (when region-text
                  (delete-region beg end)
                  (set-marker beg nil)
                  (set-marker end nil))
                (let ((id (org-roam-node-id node)))
                  (insert (org-link-make-string
                           (concat "id:" id)
                           description))
                  (run-hook-with-args 'org-roam-post-node-insert-hook
                                      id
                                      description)))
            (org-roam-capture-
             :node node
             :info info
             :templates templates
             :props (append
                     (when (and beg end)
                       (list :region (cons beg end)))
                     (list :link-description description
                           :finalize 'insert-link))))))
    (deactivate-mark)))

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
          (concat photon-dir "org-roam/quicknotes/"))
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

(with-eval-after-load 'org-roam-ui
  (defvar photon-orui-tag nil)

  (defun photon-orui--get-nodes ()
    "."
    (let ((nodes (org-roam-db-query [:select [id
      					    file
      					    title
      					    level
      					    pos
      					    olp
      					    properties
      					    (funcall group-concat tag
      						     (emacsql-escape-raw \, ))]
      					   :as tags
      					   :from nodes
      					   :left-join tags
      					   :on (= id node_id)
      					   :group :by id])))
      (if photon-orui-tag
    	(cl-remove-if-not
    	 (lambda (node)
             (member photon-orui-tag (split-string (nth 7 node) ",")))
    	 nodes)
        nodes)))

  (advice-add 'org-roam-ui--get-nodes :override #'photon-orui--get-nodes)

  (defun photon-orui-current-tag ()
    (interactive)
    (let ((current-tag (photon-completion--get-current-tag)))
      (setq photon-orui-tag current-tag)
      (if (websocket-openp org-roam-ui-ws-socket)
      	(org-roam-ui--send-graphdata))))

  (defun photon-orui-selected-tag ()
    (interactive)
    (let* ((tags (org-roam-tag-completions))
           (completion-tag (consult--read
                            (append
                             '("  Clear tags")
                             (mapcar (lambda (tag)
                                       (concat "  " tag))
                                     tags))
  			  :sort nil
                            :prompt "Select a tag: "
                            :require-match t)))
      (if (equal completion-tag "  Clear tags")
  	(setq photon-orui-tag nil)
        (progn
          (setq photon-orui-tag (string-trim completion-tag "  ")))))
    (if (websocket-openp org-roam-ui-ws-socket)
        (org-roam-ui--send-graphdata))))

;;  (use-package org-transclusion
;;    :diminish
;;    )

(unless (file-exists-p (concat photon-dir "keychain/gemini"))
  (write-region "" nil (concat photon-dir "keychain/gemini")))

(defun get-gemini-key ()
  (with-temp-buffer
    (insert-file-contents (concat photon-dir "keychain/gemini"))
    (string-trim (buffer-string))))

(use-package gptel
  :defer t
  :commands
  (gptel
   gptel-menu) 
  :custom
  (gptel-model "gemini-1.5-pro-latest")
  (gptel-default-mode 'org-mode)
  (gptel--system-message "")
  :config
  (setq gptel-backend (gptel-make-gemini "Gemini"
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
 	(define-key dired-mode-map (kbd "<visual-state> SPC") 'photon/main)))))


(defun photon-C-c ()
  (interactive)
  (execute-kbd-macro (kbd "C-c C-c")))


(defun photon-kill-buffer-and-window ()
  (interactive)
  (kill-current-buffer)
  (unless (equal 1 (length (mapcar #'window-buffer (window-list))))
    (delete-window)))

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
    ("k" "Kill current buffer" photon-kill-buffer-and-window)
    ("K" "󰁣 Kill buffer..." persp-kill-buffer*)
    ("l" "Next buffer" next-buffer :transient t)
    ("h" "Previous buffer" previous-buffer :transient t)
    ""
    ("z" "Focus current buffer" photon-focus-buffer)
    ("u" "Update current buffer" revert-buffer-quick)
    ("T" "Load autosaved perspective" photon-persp-autoload)
    ("P" "Load perspective..." photon-persp-load--interactive)
    ;;      ("m" "Toggle active buffer zoom" zoom-mode)
    ]
   ["  Keybind sets"
    ("w" "   Window settings..." photon/window)
    ("e" "   Editing tools..." photon/editing)
    ("d" " 󰈙  Org document tools..." photon/org)
    ("n" "   Org Roam..." photon/node)
    ("c" "   Coding tools..." photon/coding)
    ]]
  )

(transient-define-prefix photon/editing ()
  [" "
   ["  Spellcheck"
    ("c" "Correct word at cursor..." jinx-correct)
    ("a" "Correct all words interactively..." jinx-correct-all)
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
   ])

(transient-define-prefix photon/node ()
  [""
   [" Node tools"
    ("f" "Find node..." photon-nf)
    ("i" "Insert node..." photon-nl)
    ("m" "Make node from header" org-id-get-create)
    ("q" "Quicknote..." photon-qn)
    ]
   [
    "󱁊 UI tools"
    ("u" "Open graph UI" (lambda ()
			    (interactive)
			    (org-roam-ui-open)
			    (photon/node)
			    (run-with-timer 1 nil (lambda () (execute-kbd-macro "<escape>")))))
    ("d" "Select graph tag" photon-orui-selected-tag)
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
