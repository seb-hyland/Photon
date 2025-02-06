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


(defun photon-modeline-project ()
  (if-let ((path (if buffer-file-name
		     buffer-file-name
		   (if dired-directory
		       dired-directory))))
      (let ((buffer-name
	     (cond ((vc-git-root path)
		    (let ((status (vc-git--run-command-string (vc-git-root path) "status" "--porcelain")))
		      (if (or (string= "" status)
			      (null status))
			  (concat "(󰊢 " (file-name-nondirectory (directory-file-name (vc-git-root path))) ")"))
		      (concat "[󰊢 " (file-name-nondirectory (directory-file-name (vc-git-root path))) "]")))
		   ((project-name (project-current))
		    (concat "[<> " (project-name (project-current)) "]")))))
	(propertize buffer-name 'face '(:weight extra-light) 'face 'mode-line))))


(defun photon-buffer-name ()
  (let ((name 
	 (cond ((buffer-file-name) (file-name-nondirectory (buffer-file-name)))
	       (t (buffer-name)))))
    (propertize name 'face '(:weight bold) 'face 'mode-line)))


(setq-default mode-line-format
	      '(
		" "
		(:eval (photon-modeline-evil)) "   "
		(:eval (photon-modeline-modification)) " "
		(:eval (photon-buffer-name)) "   "
		(:eval (photon-modeline-project)) "   "
		mode-line-format-right-align
		(:eval (photon-modeline-major-mode))
		"   "
		mode-line-end-spaces))


(set-face-attribute 'mode-line nil
		    :background (face-background 'default)
		    :box nil)

(set-face-attribute 'mode-line-active nil
		    :foreground "White"
		    :background (face-background 'default)
		    :box `(:line-width 6 :color ,(face-background 'default))
		    :overline "White")

(set-face-attribute 'mode-line-inactive nil
		    :background (face-background 'default)
		    :foreground "DarkGrey"
		    :box `(:line-width 6 :color ,(face-background 'default))
		    :weight 'extra-light
		    :overline "#3A3B3C")

(set-face-attribute 'header-line nil
		    :background (face-background 'default)
		    :box nil
		    :overline "#3A3B3C")

(set-face-attribute 'header-line-inactive nil
		    :background (face-background 'default)
		    :box nil
		    :weight 'medium
		    :overline "#3A3B3C")
