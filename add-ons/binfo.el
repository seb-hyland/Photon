(require 'hexl)

;;;###autoload
(define-derived-mode binfo-mode fundamental-mode "BInfo"
  "Mode for displaying binary file information and a hex dump of the contents."
  (setq buffer-read-only t)
  (binfo-update-display))

(defun hline ()
  "Return a horizontal line made of dashes."
  (concat (make-string (- (window-width) 5) ?─) "\n"))

(defun binfo-update-display ()
  "Update buffer with file info and hex dump."
  (let* ((inhibit-read-only t)
	 (hex-dump (hexlify-buffer-to-string)))
    (erase-buffer)
    (insert (binfo-header))
    (insert "\n")
    (insert hex-dump))
  (set-buffer-modified-p nil)
  (beginning-of-buffer))

(defun binfo-header ()
  "Return file information as a string."
  (if (buffer-file-name)
      (let* ((name (buffer-file-name))
             (file-info (string-trim 
                         (shell-command-to-string 
                          (format "file -b '%s' | sed 's/, /\\n    /g'" name))))
             (ldd-info (string-trim 
                        (shell-command-to-string 
                         (format "ldd '%s' | sed 's/^[[:space:]]*/  /g'" name))))
	     (info-fmt (lambda (input)
			 (propertize input 'face '(:foreground "#ff94b7" :weight bold)))))
        (concat (hline)
		(funcall info-fmt "Binary information:\n  ")
		file-info "\n"
		(hline)
		(funcall info-fmt "Linked libraries:\n  ")
		ldd-info "\n"
		(hline)
                (funcall info-fmt "Size:\n  ")
		(number-to-string (file-attribute-size (file-attributes name))) " b\n"
		(hline)))
    "No file associated with buffer"))

(defun hexlify-buffer-to-string ()
  (let* ((coding-system-for-read 'raw-text)
         (temp-buffer (generate-new-buffer "*hexl-temp*"))
	 (buf (current-buffer)))
    (unwind-protect
        (with-current-buffer temp-buffer
          (insert-buffer-substring buf)
          (apply 'call-process-region (point-min) (point-max)
                 (expand-file-name hexl-program exec-directory)
                 t t nil
                 (mapcar (lambda (s)
                           (if (not (multibyte-string-p s)) s
                             (encode-coding-string s locale-coding-system)))
                         (split-string (hexl-options))))
          (buffer-string))
      (when (buffer-live-p temp-buffer)
        (kill-buffer temp-buffer)))))

(provide 'binfo-mode)
