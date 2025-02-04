(define-minor-mode photon-mode
  "Minor mode for my personal keybindings."
  :init-value t
  :global t
  :keymap photon-keymap)

(add-to-list 'emulation-mode-map-alists
     	     `((photon-mode . ,photon-keymap)))

(photon-mode t)
(dolist (binding '(("C-SPC" . photon/main)
     		   ("M-h" . windmove-left)
     		   ("M-j" . windmove-down)
     		   ("M-k" . windmove-up)
     		   ("M-l" . windmove-right)
     		   ("C-j" . photon-C-j)
     		   ("C-k" . photon-C-k)
     		   ("C-/ k" . helpful-key)
     		   ("C-/ f" . helpful-function)
     		   ("C-/ v" . helpful-variable)
  		   ("C-a" . mark-whole-buffer)
		   ("M-<return>" . eglot-find-declaration)
		   ("S-<return>" . eldoc-doc-buffer)
     		   ("C-<return>" . photon-toggle)
		   ("M-<backspace>" . photon-delete)
     		   ))
  (define-key photon-keymap (kbd (car binding)) (cdr binding)))

(dolist (state '("normal" "visual"))
  (let ((map (symbol-value (intern (concat "evil-" state "-state-map")))))
    (define-key map (kbd "SPC") 'photon/main)
    (define-key map (kbd "<backspace>") "\"_x")
    (define-key map (kbd "H") 'evil-backward-word-begin)
    (define-key map (kbd "J") 'evil-forward-paragraph)
    (define-key map (kbd "K") 'evil-backward-paragraph)
    (define-key map (kbd "L") 'evil-forward-word-end)
    (define-key map (kbd "C-h") 'evil-first-non-blank)      
    (define-key map (kbd "C-j") 'evil-goto-line)
    (define-key map (kbd "C-k") 'evil-goto-first-line)      
    (define-key map (kbd "C-l") 'evil-last-non-blank)
    (define-key map (kbd "f") 'evil-avy-goto-char)
    (define-key map (kbd "F") 'evil-avy-goto-word-1)
    (define-key map (kbd "r") 'evil-redo)))

(with-eval-after-load 'dired
  (define-key dired-mode-map (kbd "<normal-state> SPC") 'photon/main)
  (define-key dired-mode-map (kbd "<visual-state> SPC") 'photon/window))
