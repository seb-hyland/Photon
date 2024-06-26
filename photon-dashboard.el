;;; Commentary:
;; Doom Like style for `emacs-dashboard'
;; https://github.com/emacs-dashboard/emacs-dashboard
;; It is recommended using it with `use-package' and turn on
;; `hl-line-mode' in dashboard.

;;; Code:

(setq dashboard-center-content t)
(setq dashboard-buffer-name "*Dashboard*")

;; Movement keys like doom.
;; (bind-keys
;;  :map dashboard-mode-map
;;  ("<remap> <dashboard-previous-line>" . widget-backward)
;;  ("<remap> <dashboard-next-line>" . widget-forward)
;;  ("<remap> <previous-line>" . widget-backward)
;;  ("<remap> <next-line>" . widget-forward)
;;  ("<remap> <right-char>" . widget-forward)
;;  ("<remap> <left-char>" . widget-backward))


;; Widgets functions
;; (you can use them as template for more widgets)
;; (defun dashboard-insert-homepage-footer ()
;;   (widget-create 'item
;;                  :tag (nerd-icons-faicon "nf-fa-github_alt" :face 'success)
;;                  :action (lambda (&rest _) (browse-url "https://github.com/emacs-dashboard/emacs-dashboard"))
;;                  :mouse-face 'highlight
;;                  :button-prefix ""
;;                  :button-suffix ""
;;                  :format "%[%t%]")
;;   (dashboard-center-text (- (point) 1) (point))
;;   (insert "\n"))

;; (defun dashboard-insert-notes-shortmenu (&rest _)
;;   (let* ((fn #'org-roam-node-find)
;;          (fn-keymap (format "\\[%s]" fn))
;;          (icon (nerd-icons-octicon "nf-oct-pencil" :face 'dashboard-heading)))
;;     (insert (format "%-3s" icon))
;;     (widget-create 'item
;;                    :tag (format "%-30s" "Open note")
;;                    :action (lambda (&rest _) (call-interactively #'org-roam-node-find))
;;                    :mouse-face 'highlight
;;                    :button-face 'dashboard-heading
;;                    :button-prefix ""
;;                    :button-suffix ""
;;                    :format "%[%t%]")
;;     (insert (propertize (substitute-command-keys fn-keymap)
;;                         'face
;;                         'font-lock-constant-face))))
;; 
;; (defun dashboard-insert-org-agenda-shortmenu (&rest _)
;;   (let* ((fn #'org-agenda)
;;          (fn-keymap (format "\\[%s]" fn))
;;          (icon (nerd-icons-octicon "nf-oct-calendar" :face 'dashboard-heading)))
;;     (insert (format "%-3s" icon))
;;     (widget-create 'item
;;                    :tag (format "%-30s" "Open org-agenda")
;;                    :action (lambda (&rest _) (call-interactively #'org-agenda))
;;                    :mouse-face 'highlight
;;                    :button-face 'dashboard-heading
;;                    :button-prefix ""
;;                    :button-suffix ""
;;                    :format "%[%t%]")
;;     (insert (propertize (substitute-command-keys fn-keymap)
;;                         'face
;;                         'font-lock-constant-face))))
;; 
;; (defun dashboard-insert-bookmark-shortmenu (&rest _)
;;   (let* ((fn #'bookmark-jump)
;;          (fn-keymap (format "\\[%s]" fn))
;;          (icon (nerd-icons-octicon "nf-oct-bookmark" :face 'dashboard-heading)))
;;     (insert (format "%-3s" icon))
;;     (widget-create 'item
;;                    :tag (format "%-30s" "Jump to bookmark")
;;                    :action (lambda (&rest _) (call-interactively #'bookmark-jump))
;;                    :mouse-face 'highlight
;;                    :button-face 'dashboard-heading
;;                    :button-prefix ""
;;                    :button-suffix ""
;;                    :format "%[%t%]")
;;     (insert (propertize (substitute-command-keys fn-keymap)
;;                         'face
;;                         'font-lock-constant-face))))
;; 
;; (defun dashboard-insert-recents-shortmenu (&rest _)
;;   (let* ((fn #'recentf-open)
;;          (fn-keymap (format "\\[%s]" fn))
;;          (icon (nerd-icons-octicon "nf-oct-history" :face 'dashboard-heading)))
;;     (insert (format "%-3s" icon))
;;     (widget-create 'item
;;                    :tag (format "%-30s" "Recently opened files")
;;                    :action (lambda (&rest _) (call-interactively #'recentf-open))
;;                    :mouse-face 'highlight
;;                    :button-face 'dashboard-heading
;;                    :button-prefix ""
;;                    :button-suffix ""
;;                    :format "%[%t%]")
;;     (insert (propertize (substitute-command-keys fn-keymap)
;;                         'face
;;                         'font-lock-constant-face))))



;; Dashboard configurations for a doom-esque
(setopt dashboard-banner-logo-title "P    H    O    T    O    N"
	dashboard-startup-banner "~/.emacs.d/add-ons/photon-banner.txt" ; File path as string
        dashboard-startupify-list '(dashboard-insert-newline
				    ;; dashboard-insert-newline
				    ;; dashboard-insert-newline
				    dashboard-insert-banner
				    dashboard-insert-newline
				    dashboard-insert-banner-title
                                    ;; dashboard-insert-newline
				    ;; dashboard-insert-newline
                                    ;; dashboard-insert-items
                                    dashboard-insert-newline
                                    dashboard-insert-newline
                                    dashboard-insert-init-info))
                                    ;; dashboard-insert-newline
                                    ;; dashboard-insert-newline
                                    ;; dashboard-insert-homepage-footer)
;;        dashboard-item-generators
;;        '((recents . dashboard-insert-recents-shortmenu)
;;          (bookmarks . dashboard-insert-bookmark-shortmenu)
;;          (notes . dashboard-insert-notes-shortmenu)
;;          (agenda . dashboard-insert-org-agenda-shortmenu))
;;        dashboard-items '(notes
;;                          agenda
;;                          bookmarks
;;                          recents))
