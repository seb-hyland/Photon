;; -*- lexical-binding: t; -*-

;; Setup straight.el
(setq straight-use-package-by-default t)
(defvar bootstrap-version)
(let ((bootstrap-file
	  (expand-file-name
              "straight/repos/straight.el/bootstrap.el"
              (or (bound-and-true-p straight-base-dir)
		  user-emacs-directory)))
	 (bootstrap-version 7))
    (unless (file-exists-p bootstrap-file)
	(with-current-buffer
            (url-retrieve-synchronously
		"https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
		'silent 'inhibit-cookies)
	    (goto-char (point-max))
	    (eval-print-last-sexp)))
    (load bootstrap-file nil 'nomessage))

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

;; Load Photon helpers
(load "functions")

;; Load functional packages
(load "packages")

;; Load language preferences 
(load "langs")

;; Load Photon keybinds 
(load "keys")

;; Load modeline
(add-hook 'window-setup-hook (lambda () (load "modeline")))

(setq gc-cons-threshold (expt 2 23))
