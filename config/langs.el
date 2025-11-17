;; -*- lexical-binding: t; -*-

(use-package eglot
    :defer t
    :commands (eglot eglot-rename eglot-code-actions)
    :init
    (use-package eglot-booster
	:demand t
	:vc (:url "https://github.com/jdtsmith/eglot-booster.git")
	:config (eglot-booster-mode t))
    (use-package tempel
	:demand t
	:bind (:map tempel-map
		  ("<remap> <electric-newline-and-maybe-indent>" . tempel-next)
		  ("<remap> <evil-insert-digraph>" . tempel-previous)))
    (use-package eglot-tempel
	:demand t
	:init
	(eglot-tempel-mode t))
    :bind (:map eglot-mode-map
	      ("<normal-state> K" . nil)
	      ("M-<return>" . eglot-find-declaration))
    :custom
    (project-vc-extra-root-markers '("Cargo.toml" "build.zig"))
    (eldoc-echo-area-use-multiline-p t)
    (eglot-ignored-server-capabilities '(:inlayHintProvider))
    :config
    (setf (plist-get eglot-events-buffer-config :size) 0)
    (fset #'jsonrpc--log-event #'ignore)
    (advice-add 'eglot-imenu :override (lambda (&rest _) (treesit-simple-imenu)))
    (setq-default eglot-workspace-configuration
	'(:basedpyright (:typeCheckingMode "standard"))))


(use-package dape
    :defer t
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
	      ("<remap> <vertico-next>" . corfu-next)
	      ("<remap> <vertico-previous>" . corfu-previous)
	      ("RET" . nil))
    :hook
    (prog-mode . corfu-mode)
    (typst-ts-mode . corfu-mode)
    :custom
    (corfu-auto t)
    (corfu-auto-delay 0.1)
    (corfu-auto-prefix 1)
    (completion-ignore-case t)
    (corfu-popupinfo-delay '(0.1 . 0.1))
    (corfu-popupinfo-mode t)
    (corfu-max-width 50)
    (corfu-popupinfo-max-width 30)
    (corfu-bar-width 0)
    (corfu-left-margin-width 1)
    (corfu-right-margin-width 0)
    :config
    (setf (alist-get 'child-frame-border-width corfu--frame-parameters) 8)
    ;; Override the "fringe" face for corfu buffers
    (defun corfu-fringe-restyle (buffer)
	(with-current-buffer buffer
	    (face-remap-add-relative 'fringe :background "#2A2A37"))
	buffer)
    (advice-add 'corfu--make-buffer :filter-return #'corfu-fringe-restyle))

(use-package markdown-mode
    :after eglot
    :config
    (set-face-attribute 'markdown-code-face nil :family "JetBrainsMono Nerd Font"))

(use-package eldoc-box
    :after eglot
    :custom
    (eldoc-box-max-pixel-height 300)
    :config
    (setf (alist-get 'internal-border-width eldoc-box-frame-parameters) 12))


;; Rust
(use-package rust-mode
    :init
    (setq rust-mode-treesitter-derive t))

(use-package rustic
    :after rust-mode
    :custom
    (rustic-lsp-client 'eglot)
    (xterm-color-names
	["#090c12"  ; black
	    "#ff94b7"  ; red
	    "#97db84"  ; green
	    "#ffc55c"  ; yellow
	    "#9fbbf5"  ; blue
	    "#c8a6ff"  ; magenta
	    "#5dc9ab"  ; cyan
	    "#E6E3D3"] ; white
	)
    (xterm-color-names-bright xterm-color-names)
    (xterm-color-use-bold-for-bright t))


;; Zig
(use-package zig-mode
    :defer t
    :mode "\\.zig$")


;; Typst
(use-package typst-ts-mode
    :defer t
    :vc (:url "https://codeberg.org/meow_king/typst-ts-mode.git")
    :config (add-to-list 'eglot-server-programs '(typst-ts-mode . ("tinymist"))))

(use-package websocket)
(use-package typst-preview
    :after typst-ts-mode
    :vc (:url "https://github.com/havarddj/typst-preview.el.git")
    :custom (typst-preview-invert-colors "never"))

;; Python
(use-package pyvenv
    :after python-ts-mode)

;; Mojo
(use-package mojo-mode
    :defer t
    :mode ("\\.mojo$" "\\.🔥$")
    :vc (:url "https://github.com/andcarnivorous/mojo-hl.git")
    :config (add-to-list 'eglot-server-programs '(mojo-mode . ("magic" "run" "mojo-lsp-server"))))

;; Nextflow
(use-package nextflow-mode
    :defer t
    :mode "\\.nf$"
    :vc (:url "https://github.com/edmundmiller/nextflow-mode.git"))
