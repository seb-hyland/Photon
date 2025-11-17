;; -*- lexical-binding: t; -*-

(defun photon-modeline-modification ()
  (cond (buffer-file-name
	 (if (buffer-modified-p)
	     (propertize "**" 'face '(:foreground "#FF7F7F" :weight bold))
	   (propertize "--" 'face '(:foreground "DarkGrey"))))
	(t (propertize "~~" 'face '(:foreground "DarkGrey")))))


(defun photon-modeline-major-mode ()
  (let ((mode-name (if (listp mode-name)
		       (car mode-name)
		     mode-name)))
    (if (not (equal mode-name "Dashboard"))
	(propertize mode-name 'face '(:weight extra-light) 'face 'mode-line))))


(defun photon-modeline-evil ()
  (let ((symbol
	 (cond ((eq evil-state 'normal) "λ")
	       ((eq evil-state 'insert) "Σ")
	       ((eq evil-state 'visual) "δ")
	       (t "?"))))
    (propertize symbol 'face '(:weight extra-light) 'face 'mode-line)))


(defun photon--get-buffer-name ()
    (let* ((buf-file-name (buffer-file-name))
	   (name (if buf-file-name
		     (file-name-nondirectory buf-file-name)
		     (buffer-name))))
	(cons name buf-file-name)))

(defun photon-buffer-name ()
    (cl-destructuring-bind (name . buf-file-name) (photon--get-buffer-name)
	(propertize name
	    'face '(:weight bold)
	    'face 'mode-line
	    'help-echo buf-file-name)))


(defun photon-modeline-diagnostics ()
    (let ((output-str ""))
	(if (eglot-managed-p)
	    (let ((diagnostics (flymake--project-diagnostics))
		     (errors 0)
		     (warnings 0))
		(dolist (diag diagnostics)
		    (let ((diag-type (flymake-diagnostic-type diag)))
			(cond
			    ((eq diag-type 'eglot-error) (cl-incf errors))
			    ((eq diag-type 'eglot-warning) (cl-incf warnings)))))
		(when (not (eq errors 0))
		    (setq output-str
			(concat output-str (propertize (concat " " (number-to-string errors))
					       'face '(:foreground "#FF94B7")))))
		(when (not (eq warnings 0))
		    (setq output-str
			(concat output-str (propertize (concat " " " " (number-to-string warnings))
					       'face '(:foreground "#FCE397")))))))
	output-str))


(setq-default mode-line-format
	      '(
		" "
		(:eval (photon-modeline-evil)) "   "
		(:eval (photon-modeline-modification)) " "
		(:eval (photon-buffer-name)) "   "
		(:eval (photon-modeline-diagnostics))
		mode-line-format-right-align
		(:eval (photon-modeline-major-mode))
		"   "
		mode-line-end-spaces))
