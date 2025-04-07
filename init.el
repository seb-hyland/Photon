;; -*- lexical-binding: t; -*-

;; Setup use-package
(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure t
      use-package-vc-prefer-newest t)

(defvar addons-dir (concat user-emacs-directory "add-ons/"))
(add-to-list 'load-path addons-dir)
(defvar config-dir (concat user-emacs-directory "config/"))
(add-to-list 'load-path config-dir)

;; Reduce GC during startup
(setq gc-cons-threshold most-positive-fixnum
      gc-cons-percentage 0.6)

;; Enable native compilation
(if (boundp 'comp-deferred-compilation)
    (setq comp-deferred-compilation nil)
  (setq native-comp-deferred-compilation nil))
(setq load-prefer-newer noninteractive)
(setq comp-async-report-warnings-errors nil)
(setq package-native-compile t)


;; Load general config
(load "general")

;; Load functional packages
(load "packages")

;; Load language preferences 
(load "langs")

;; Load Photon transients
(load "functions")

;; Load Photon keybinds 
(load "keys")

;; Load modeline
(add-hook 'window-setup-hook (lambda () (load "modeline")))

(setq gc-cons-threshold (expt 2 23))
