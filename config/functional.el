;; -*- lexical-binding: t; -*-

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
  :after vertico
  :custom
  (consult-imenu-config
   '((rust-mode
      :toplevel "Fn"
      :types
      ((?f "Fn")
       (?s "Struct")
       (?e "Enum")
       (?t "Type")
       (?i "Impl"))))))


(use-package orderless
  :after vertico
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles basic partial-completion)))))


(use-package evil
  :demand t
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-respect-visual-line-mode t)
  :bind (
         :map evil-motion-state-map
         ("j" . evil-next-visual-line)
         ("k" . evil-previous-visual-line)
         :map occur-mode-map
	 ("<remap> <occur-mode-goto-occurrence>" . photon-occur-goto-item))
  :config
  (evil-mode t)
  (evil-set-undo-system 'undo-redo))


(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))


(use-package helpful
  :defer t)


(use-package magit
  :defer t
  :custom
  (magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1)
  (magit-format-file-function #'magit-format-file-nerd-icons))


(use-package transient
  :demand t
  :bind (
      	 :map transient-base-map
      	 ("<escape>" . transient-quit-all)))


(use-package treesit-auto
  :demand t
  :custom
  (c-basic-offset 4)
  :config
  (treesit-auto-add-to-auto-mode-alist 'all)
  (global-treesit-auto-mode)
  (add-to-list 'auto-mode-alist '("\\.ino$" . c++-mode)))


(use-package treesit-fold
  :demand t
  :vc (:url "https://github.com/emacs-tree-sitter/treesit-fold.git")
  :config
  (defun treesit-fold-better-toggle ()
    (interactive)
    (if (treesit-fold-open)
	(treesit-fold-open-recursively)
      (treesit-fold-close)))
  :bind (
	 :map treesit-fold-mode-map
	 ("<remap> <evil-jump-forward>" . treesit-fold-better-toggle)
	 ("<backtab>" . treesit-fold-open-all)
	 ("C-<tab>" . treesit-fold-close-all))
  :custom
  (global-treesit-fold-mode t)
  (treesit-fold-line-count-show t)
  (treesit-fold-line-count-format " %d "))


(use-package eat
  :demand t
  :vc (:url "https://codeberg.org/akib/emacs-eat.git")
  :hook (eat-exec . (lambda (&rest _) (eat-semi-char-mode)))
  :config
  (add-to-list 'display-buffer-alist
	       '("^\\*eat\\*"
		 (display-buffer-pop-up-window))))


(use-package compile
  :demand t)


(use-package ansi-color
  :hook (compilation-filter . ansi-color-compilation-filter))


(use-package perspective
  :demand t
  :init
  (setq persp-suppress-no-prefix-key-warning t)
  :config
  (persp-mode t))


(use-package avy
  :defer t)


(use-package chatgpt-shell
  :ensure t
  :custom
  (chatgpt-shell-google-key (getenv "GEMINI_API"))
  (chatgpt-shell-model-version "gemini-2.0-flash-thinking-exp-01-21")
  (chatgpt-shell-display-function #'display-buffer))


(use-package autothemer
  :config
  (add-to-list 'custom-theme-load-path addons-dir))


(use-package nerd-icons
  :demand t
  :custom
  (nerd-icons-color-icons t)
  (nerd-icons-scale-factor 1))

(use-package nerd-icons-dired
  :after nerd-icons
  :hook
  (dired-mode . nerd-icons-dired-mode)
  (dired-mode . dired-hide-details-mode))

(use-package nerd-icons-completion
  :after nerd-icons
  :config
  (nerd-icons-completion-mode t)
  (nerd-icons-completion-marginalia-setup)
  (eval-after-load 'dired
    (setq dired-kill-when-opening-new-dired-buffer t)))

(use-package nerd-icons-corfu
  :after corfu
  :config
  (add-to-list 'corfu-margin-formatters #'nerd-icons-corfu-formatter))


(use-package spacious-padding
  :demand t
  :init
  (spacious-padding-mode))

(use-package ligature
  :config
  (ligature-set-ligatures 'prog-mode '("--" "---" "==" "===" "!=" "!==" "=!="
                              "=:=" "=/=" "<=" ">=" "&&" "&&&" "&=" "++" "+++" "***" ";;" "!!"
                              "??" "???" "?:" "?." "?=" "<:" ":<" ":>" ">:" "<:<" "<>" "<<<" ">>>"
                              "<<" ">>" "||" "-|" "_|_" "|-" "||-" "|=" "||=" "##" "###" "####"
                              "#{" "#[" "]#" "#(" "#?" "#_" "#_(" "#:" "#!" "#=" "^=" "<$>" "<$"
                              "$>" "<+>" "<+" "+>" "<*>" "<*" "*>" "</" "</>" "/>" "<!--" "<#--"
                              "-->" "->" "->>" "<<-" "<-" "<=<" "=<<" "<<=" "<==" "<=>" "<==>"
                              "==>" "=>" "=>>" ">=>" ">>=" ">>-" ">-" "-<" "-<<" ">->" "<-<" "<-|"
                              "<=|" "|=>" "|->" "<->" "<~~" "<~" "<~>" "~~" "~~>" "~>" "~-" "-~"
                              "~@" "[||]" "|]" "[|" "|}" "{|" "[<" ">]" "|>" "<|" "||>" "<||"
                              "|||>" "<|||" "<|>" "..." ".." ".=" "..<" ".?" "::" ":::" ":=" "::="
                              ":?" ":?>" "//" "///" "/*" "*/" "/=" "//=" "/==" "@_" "__" "???"
                              "<:<" ";;;"))
  (global-ligature-mode t))


(use-package vi-tilde-fringe
  :config
  (global-vi-tilde-fringe-mode t))


(use-package dashboard
  :custom
  (nerd-icons-font-family "Symbols Nerd Font Mono")
  :hook
  (dashboard-mode . (lambda () (vi-tilde-fringe-mode -1)))
  :config
  (dashboard-setup-startup-hook))

(load-file (concat addons-dir "photon-dashboard.el"))


(use-package rainbow-delimiters
  :defer t
  :hook (prog-mode . rainbow-delimiters-mode))


(use-package org
  :config
  (delete-selection-mode t)
  (setf (cdr (assoc 'file org-link-frame-setup)) 'find-file))
