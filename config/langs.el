;; -*- lexical-binding: t; -*-

(use-package eglot
  :defer t
  :commands (eglot eglot-rename eglot-code-actions)
  :bind (:map eglot-mode-map
	      ("<normal-state> K" . nil))
  :custom
  (project-vc-extra-root-markers '("Cargo.toml" "build.zig"))
  :config
  (setf (plist-get eglot-events-buffer-config :size) 0)
  (fset #'jsonrpc--log-event #'ignore)
  (add-to-list 'eglot-server-programs
	       '((rust-mode rust-ts-mode) . ("rust-analyzer" :initializationOptions (:check (:command "clippy")))))

  (advice-add 'eglot-imenu :override (lambda (&rest _) (treesit-simple-imenu)))
  (setq-default eglot-workspace-configuration
		'(:basedpyright (:typeCheckingMode "standard"))))

(use-package eglot-booster
  :vc (:url "https://github.com/jdtsmith/eglot-booster.git")
  :after eglot
  :config (eglot-booster-mode t))

(use-package dape
  :after eglot
  :commands (dape dape-breakpoint-toggle dape-breakpoint-expression)
  :init
  (setq dape-buffer-window-arrangement 'right)
  :bind (
	 :map dape-info-stack-line-map
	 ("TAB" . dape--info-buffer-tab)
	 :map dape-info-module-line-map
	 ("TAB" . dape--info-buffer-tab)
	 :map dape-info-sources-mode-map
	 ("TAB" . dape--info-buffer-tab)
	 :map dape-info-breakpoints-line-map
	 ("TAB" . dape--info-buffer-tab)
	 :map dape-info-threads-line-map
	 ("TAB" . dape--info-buffer-tab)))

(use-package corfu
  :demand t
  :bind (
    	 :map corfu-map
    	 ("<remap> <photon-C-j>" . corfu-next)
    	 ("<remap> <photon-C-k>" . corfu-previous)
         ("RET" . nil))
  :hook
  (prog-mode . corfu-mode)
  :custom
  (corfu-auto t)
  (corfu-auto-delay 0.1)
  (corfu-auto-prefix 2)
  (completion-ignore-case t)
  (corfu-popupinfo-delay '(0.1 . 0.1))
  (corfu-popupinfo-mode t))

(use-package tempel
  :after eglot
  :bind (:map tempel-map
	      ("<remap> <photon-C-j>" . tempel-next)
	      ("<remap> <photon-C-k>" . tempel-previous)))

(use-package eglot-tempel
  :after tempel
  :init
  (eglot-tempel-mode t))

(use-package markdown-mode
  :after eglot
  :config
  (set-face-attribute 'markdown-code-face nil :family "JetBrainsMono Nerd Font"))


;; Rust
(add-to-list 'compilation-error-regexp-alist 'rust)
(setenv "CARGO_TERM_COLOR" "always")
(add-to-list 'compilation-error-regexp-alist-alist
	     '(rust "^[[:space:]]*-->[[:space:]]*\\([^:\n]+\\):\\([0-9]+\\):\\([0-9]+\\)" 1 2 3))


;; Zig
(use-package zig-mode
  :defer t
  :config
  (add-to-list 'auto-mode-alist '("\\.zig$" . zig-mode)))


;; Typst
(use-package typst-ts-mode
  :defer t
  :vc (:url "https://codeberg.org/meow_king/typst-ts-mode.git"))

(use-package websocket)
(use-package typst-preview
  :after typst-ts-mode
  :vc (:url "https://github.com/havarddj/typst-preview.el.git"
	    :rev :newest))

;; Python
(use-package pyvenv
  :after python-ts-mode)
