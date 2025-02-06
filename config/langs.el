(use-package eglot
  :defer t
  :bind (:map eglot-mode-map
	      ("<normal-state> K" . nil))
  :config
  (add-to-list 'eglot-server-programs
	     '((rustic-mode) . ("rust-analyzer" :initializationOptions (:check (:command "clippy"))))))


(use-package dape
  :after eglot)


;; Zig
(use-package zig-mode
  :defer t
  :config
  (add-to-list 'auto-mode-alist '("\\.zig$" . zig-mode)))


;; Typst
(use-package typst-ts-mode
  :defer t
  :vc (:url "https://codeberg.org/meow_king/typst-ts-mode.git"))
