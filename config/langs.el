;; -*- lexical-binding: t; -*-

(use-package eglot
  :demand t
  :commands (eglot eglot-rename eglot-code-actions)
  :bind (:map eglot-mode-map
	      ("<normal-state> K" . nil)
	      ("M-<return>" . eglot-find-declaration))
  :custom
  (project-vc-extra-root-markers '("Cargo.toml" "build.zig"))
  (eldoc-echo-area-use-multiline-p t)
  :config
  (setf (plist-get eglot-events-buffer-config :size) 0)
  (fset #'jsonrpc--log-event #'ignore)
  (advice-add 'eglot-imenu :override (lambda (&rest _) (treesit-simple-imenu)))
  (setq-default eglot-workspace-configuration
		'(:basedpyright (:typeCheckingMode "standard")))
  (defun eglot-open-link ()
    "Open markdown link at point in the `eldoc-doc-buffer'."
    (interactive)
    (let ((url (get-text-property (point) 'help-echo)))
      (if url
	  (browse-url url)
	(message "No URL found at point")))))

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
  (typst-ts-mode . corfu-mode)
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
  :config (add-to-list 'eglot-server-programs '(typst-ts-mode . "tinymist")))

(use-package websocket)
(use-package typst-preview
  :after typst-ts-mode
  :vc (:url "https://github.com/havarddj/typst-preview.el.git"
	    :rev :newest))

;; Python
(use-package pyvenv
  :after python-ts-mode)

;; Mojo
(use-package mojo-mode
  :defer t
  :mode "\\.mojo$"
  :vc (:url "https://github.com/andcarnivorous/mojo-hl.git")
  :config (add-to-list 'eglot-server-programs '(mojo-mode . ("magic" "run" "mojo-lsp-server"))))

;; Nextflow
(use-package nextflow-mode
  :defer t
  :mode "\\.nf$"
  :vc (:url "https://github.com/edmundmiller/nextflow-mode.git" :rev :newest))
