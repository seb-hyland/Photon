(use-package rustic
  :defer t
  :custom
  (rustic-lsp-client 'eglot)
  :config
  (add-to-list 'auto-mode-alist '("\\.rs$" . rustic-mode)))


(use-package zig-mode
  :defer t
  :config
  (add-to-list 'auto-mode-alist '("\\.zig$" . zig-mode)))


(use-package typst-ts-mode
  :defer t
  :vc (:url "https://codeberg.org/meow_king/typst-ts-mode.git"))
