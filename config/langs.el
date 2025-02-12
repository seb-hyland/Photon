;; -*- lexical-binding: t; -*-

(use-package eglot
  :after prog-mode
  :bind (:map eglot-mode-map
	      ("<normal-state> K" . nil))
  :custom
  (project-vc-extra-root-markers '("Cargo.toml" "build.zig"))
  :config
  (add-to-list 'eglot-server-programs
	       '((rust-ts-mode) . ("rust-analyzer" :initializationOptions (:check (:command "clippy"))))))

(use-package dape
  :after eglot
  :init
  (setq dape-buffer-window-arrangement 'right))

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
  (corfu-popupinfo-mode t)
  (corfu-popupinfo-delay '(0.0 . 1.0)))

(use-package eglot-tempel
  :after eglot
  :init
  (eglot-tempel-mode t))


;; Zig
(use-package zig-mode
  :defer t
  :config
  (add-to-list 'auto-mode-alist '("\\.zig$" . zig-mode)))


;; Typst
(use-package typst-ts-mode
  :defer t
  :vc (:url "https://codeberg.org/meow_king/typst-ts-mode.git"))


;; Python
(use-package pyvenv
  :after python-ts-mode)
