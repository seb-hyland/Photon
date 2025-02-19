(setq dashboard-center-content t
      dashboard-vertically-center-content t)

(setopt dashboard-banner-logo-title "P    H    O    T    O    N"
	dashboard-startup-banner "~/.emacs.d/add-ons/photon-banner.txt"
        dashboard-startupify-list '(dashboard-insert-banner
				    dashboard-insert-newline
				    dashboard-insert-banner-title
                                    dashboard-insert-newline
                                    dashboard-insert-init-info
                                    dashboard-insert-newline
                                    dashboard-insert-newline
                                    dashboard-insert-newline
                                    dashboard-insert-newline))
