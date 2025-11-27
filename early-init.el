;; -*- lexical-binding: t; -*-

(setq package-enable-at-startup nil)

(push '(visibility . nil) initial-frame-alist)
(add-hook 'window-setup-hook #'make-frame-visible)
(run-with-timer 5 nil #'make-frame-visible)
