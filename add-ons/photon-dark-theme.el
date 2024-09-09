;;; package: --- A theme inspired by the colors of the famous painting by Katsushika Hokusa

;;; Commentary: Original theme created by rebelot see: https://github.com/rebelot/kanagawa.nvim
;;; Code:

(eval-when-compile
  (require 'cl-lib))

(require 'autothemer)

(unless (>= emacs-major-version 24)
  (error "Requires Emacs 24 or later"))

(autothemer-deftheme
 photon-dark "A modified version of Kanagawa, a theme inspired by the colors of the famous painting by Katsushika Hokusa"

 ((((class color) (min-colors #xFFFFFF))        ; col 1 GUI/24bit
   ((class color) (min-colors #xFF)))           ; col 2 Xterm/256

  (padding 7)
  ;; Define our color palette
  (fujiWhite		"#E6E3D3" "#ffffff")
  (old-white		"#C8C093" "#ffffff")

  (sumiInk              "#090c12" "#13131a")
  (sumiInk-0		"#00010D" "#000000")
  (sumiInk-1b		"#1c1c24" "#000000")
  (sumiInk-1		"#18181c" "#080808")
  (sumiInk-2		"#2d2d30" "#121212")
  (sumiInk-3		"#2e2e57" "#303030")
  (sumiInk-4		"#545485" "#303030")
  (sumiInk-5		"#9999cf" "#303030")
  (sumiInk-6		"#a0a0ae" "#303030")

  (waveBlue-1		"#1f3e69" "#4e4e4e")
  (waveBlue-2		"#475e80" "#585858")
  (waveAqua1		"#60b59d" "#6a9589")
  (waveAqua2		"#83d4c4" "#717C7C")
  
  (samuraiRed       "#E82438" "#585858")

  (winterGreen		"#144015" "#585858")
  (winterYellow		"#473420" "#585858")
  (winterRed		"#211a1c" "#585858")
  (winterBlue		"#1c1c29" "#585858")

  (autumnGreen		"#84bf75" "#585858")
  (autumnRed		"#f74043" "#585858")
  (autumnYellow		"#edbc72" "#585858")

  (roninYellow		"#fca253" "#585858")

  (dragonBlue		"#abc9e0" "#658594")
  (fujiGray             "#94938e" "#717C7C")
  (springViolet1	"#af9ed9" "#717C7C")
  (oniViolet		"#aa7ff0" "#717C7C")
  (crystalBlue		"#8db0f7" "#717C7C")
  (springViolet2	"#a1bbf0" "#717C7C")
  (springBlue		"#98d9f5" "#717C7C")
  (springGreen		"#8ad674" "#717C7C")
  (boatYellow2		"#e6bd70" "#717C7C")
  (carpYellow		"#fade8c" "#717C7C")
  (sakuraPink		"#f799b7" "#717C7C")
  (peachRed             "#ff7887" "#717C7C")
  (surimiOrange		"#ff906b" "#717C7C")
  (comet                "#6f6d94" "#4e4e4e"))

 ;; Customize faces
 (
  (default                                       (:background sumiInk-1 :foreground fujiWhite))
  (border                                        (:foreground sumiInk-2))
  (button                                        (:foreground sakuraPink))
  (child-frame-border                            (:foreground sumiInk-0))
  (cursor                                        (:background peachRed :foreground sumiInk-0 :bold t))
  (error                                         (:foreground peachRed))
  (fringe                                        (:foreground sumiInk-2))
  (glyph-face                                    (:background sumiInk-4))
  (glyphless-char                                (:foreground sumiInk-4))
  (header-line                                   (:background sumiInk-2 :box (:line-width padding :color sumiInk-2)))
  (highlight                                     (:background winterBlue :foreground oniViolet))
  (hl-line                                       (:background sumiInk-2))
  (homoglyph                                     (:foreground waveAqua2))
  (line-number                                   (:foreground sumiInk-4))
  (line-number-current-line                      (:background sumiInk-2 :foreground crystalBlue :weight 'semi-bold))
  (lv-separator                                  (:foreground waveBlue-2 :background sumiInk-2))
  (match                                         (:background carpYellow :foreground sumiInk-0))
  (menu                                          (:foreground fujiWhite))
  (mode-line                                     (:background sumiInk-2 :box (:line-width padding :color sumiInk-2)))
  (mode-line-inactive                            (:background sumiInk-2 :foreground sumiInk-4 :box (:line-width padding :color sumiInk-2)))
  (mode-line-active                              (:background sumiInk-2 :foreground sumiInk-5 :box (:line-width padding :color sumiInk-2)))
  (mode-line-highlight                           (:foreground boatYellow2))
  (mode-line-buffer-id                           (:foreground crystalBlue))
  (numbers                                       (:background sakuraPink))
  (region                                        (:background waveBlue-2))
  (separator-line                                (:background sumiInk-0))
  (success                                       (:foreground waveAqua2))
  (vertical-border                               (:foreground sumiInk-2))
  (window-divider                                (:background sumiInk-5 :foreground sumiInk-5))
  (window-divider-first-pixel                    (:background sumiInk-5 :foreground sumiInk-5))
  (window-divider-last-pixel                     (:background sumiInk-5 :foreground sumiInk-5))
  (warning                                       (:foreground carpYellow ))
  (hi-yellow                                     (:background carpYellow :foreground sumiInk-1b))

  ;; Font lock
  (font-lock-keyword-face                        (:foreground springBlue :weight 'semi-bold))
  (font-lock-type-face                           (:foreground sakuraPink :weight 'normal))
  (font-lock-warning-face                        (:foreground roninYellow))
  (font-lock-string-face                         (:foreground springGreen :italic t))
  (font-lock-builtin-face                        (:foreground springViolet1))
  (font-lock-reference-face                      (:foreground peachRed))
  (font-lock-constant-face                       (:foreground carpYellow))
  (font-lock-function-name-face                  (:foreground oniViolet))
  (font-lock-variable-name-face                  (:foreground springViolet2))
  (font-lock-negation-char-face                  (:foreground peachRed))
  (font-lock-comment-face                        (:foreground comet :italic t))
  (font-lock-comment-delimiter-face              (:foreground comet :italic t))
  (font-lock-doc-face                            (:foreground fujiGray))
  (font-lock-doc-markup-face                     (:foreground fujiGray))
  (font-lock-preprocessor-face	                 (:foreground boatYellow2))
  (font-lock-regexp-grouping-backslash           (:foreground boatYellow2))
  (font-lock-number-face                         (:foreground roninYellow :weight 'normal))
  (font-lock-operator-face                       (:foreground peachRed))
  (font-lock-misc-punctuation-face               (:foreground peachRed))
  (font-lock-punctuation-face                    (:foreground peachRed))
  (elisp-shorthand-font-lock-face                (:foreground fujiWhite))

  (info-xref                                     (:foreground peachRed))
  (minibuffer-prompt-end                         (:foreground autumnRed :background winterRed))
  (minibuffer-prompt                             (:foreground peachRed :background winterRed :bold t))
  (epa-mark                                      (:foreground peachRed))
  (dired-mark                                    (:foreground peachRed))
  (trailing-whitespace                           (:background comet))
  (mode-line                                     (:background sumiInk-0 :foreground fujiWhite :bold t))

  ;; Doom Nano Modeline
  (doom-nano-modeline-active-face                (:foreground fujiWhite :bold t))
  (doom-nano-modeline-active-modified-face       (:foreground sakuraPink :bold t))
  (doom-nano-modeline-evil-emacs-state-face      (:background oniViolet :foreground "black" :box oniViolet :bold t))
  (doom-nano-modeline-evil-normal-state-face     (:background springGreen :foreground "black" :box springGreen :bold t))
  (doom-nano-modeline-evil-insert-state-face     (:background dragonBlue :foreground "black" :box dragonBlue :bold t))
  (doom-nano-modeline-evil-visual-state-face     (:background samuraiRed :foreground "black" :box samuraiRed :bold t))
  (doom-nano-modeline-evil-replace-state-face    (:background oniViolet :foreground "black" :box oniViolet :bold t))

  ;; Battery colors
  (doom-modeline-battery-critical                (:foreground peachRed))
  (doom-modeline-battery-warning                 (:foreground springGreen))
  (doom-modeline-battery-charging                (:foreground fujiGray))
  (doom-modeline-battery-error                   (:foreground peachRed))
  (doom-modeline-battery-normal                  (:foreground springViolet1))
  (doom-modeline-battery-full                    (:foreground waveAqua2))
  
  ;; Doom visual state
  (doom-modeline-evil-motion-state               (:foreground waveAqua2))
  (doom-modeline-evil-emacs-state                (:foreground crystalBlue))
  (doom-modeline-evil-insert-state               (:foreground peachRed))
  (doom-modeline-evil-normal-state               (:foreground waveAqua2))
  (doom-modeline-evil-visual-state               (:foreground springGreen))
  (doom-modeline-evil-replace-state              (:foreground roninYellow))
  (doom-modeline-evil-operator-state             (:foreground crystalBlue))

  (doom-modeline-project-dir                     (:bold t :foreground waveAqua2))
  (doom-modeline-buffer-path                     (:inherit 'bold :foreground waveAqua2))
  (doom-modeline-buffer-file                     (:inherit 'bold :foreground oniViolet))
  (doom-modeline-buffer-modified                 (:inherit 'bold :foreground carpYellow))
  (doom-modeline-error                           (:background peachRed))
  (doom-modeline-buffer-major-mode               (:foreground waveAqua2 :bold t))
  (doom-modeline-info                            (:bold t :foreground waveAqua2))
  (doom-modeline-project-dir                     (:bold t :foreground surimiOrange))
  (doom-modeline-bar                             (:bold t :background springViolet1))
  (doom-modeline-panel                           (:inherit 'bold :background boatYellow2 :foreground sumiInk-2))
  (doom-themes-visual-bell                       (:background autumnRed))

  ;; elfeed
  (elfeed-search-feed-face                       (:foreground springViolet1))
  (elfeed-search-tag-face                        (:foreground waveAqua2))

  ;; message colors
  (message-header-name                           (:foreground sumiInk-4))
  (message-header-other                          (:foreground surimiOrange))
  (message-header-subject                        (:foreground carpYellow))
  (message-header-to                             (:foreground old-white))
  (message-header-cc                             (:foreground waveAqua2))
  (message-header-xheader                        (:foreground old-white))
  (custom-link                                   (:foreground crystalBlue))
  (link                                          (:foreground crystalBlue))

  (winum-face (:foreground samuraiRed :bold t))
  
  ;; org-mode
  (org-done                                      (:foreground dragonBlue))
  (org-drawer                                    (:foreground springBlue :background winterBlue :height 0.8 :weight 'normal))
  (org-special-keyword                           (:background winterRed :foreground peachRed :height 0.8))
  (org-code                                      (:background sumiInk-0))
  (org-verbatim                                  (:background roninYellow :foreground "black"))
  (org-meta-line                                 (:background winterBlue :foreground autumnGreen))
  (org-block                                     (:background sumiInk :foreground fujiWhite))
  (org-block-begin-line                          (:background sumiInk :foreground dragonBlue))
  (org-block-end-line	                         (:background sumiInk :foreground dragonBlue))
  (org-headline-done                             (:foreground dragonBlue :strike-through t))
  (org-todo                                      (:foreground surimiOrange :bold t))
  (org-headline-todo                             (:foreground sumiInk-2))
  (org-upcoming-deadline                         (:foreground peachRed))
  (org-footnote                                  (:foreground waveAqua2))
  (org-date                                      (:foreground waveBlue-2))
  (org-ellipsis                                  (:foreground waveBlue-2 :bold t))
  (org-level-1                                   (:foreground springGreen))
  (org-level-2                                   (:foreground springBlue))
  (org-level-3                                   (:foreground sakuraPink))
  (org-level-4                                   (:foreground roninYellow))
  (org-level-5                                   (:foreground peachRed))
  (org-level-6                                   (:foreground carpYellow))
  (org-level-7                                   (:foreground surimiOrange))
  (org-level-8                                   (:foreground springGreen))
  (org-table                                     (:foreground dragonBlue))
  (org-document-title                            (:foreground springViolet2))
  (org-document-info                             (:foreground springViolet2))
  (org-document-info-keyword                     (:foreground springViolet2))
  (doom-nano-modeline-active-modified-face       (:foreground sakuraPink))

  (org-modern-statistics                         (:foreground crystalBlue :background winterBlue :height 0.8 :weight 'normal))
  (org-modern-tag                                (:foreground sumiInk-4 :background winterBlue :height 0.8 :weight 'semi-bold))

  ;; which-key
  (which-key-key-face                            (:inherit 'font-lock-variable-name-face))
  (which-func                                    (:inherit 'font-lock-function-name-face :bold t))
  (which-key-group-description-face              (:foreground peachRed))
  (which-key-command-description-face            (:foreground crystalBlue))
  (which-key-local-map-description-face          (:foreground carpYellow))
  (which-key-posframe                            (:background waveBlue-1))
  (which-key-posframe-border	                 (:background waveBlue-1))

  ;; swiper
  (swiper-line-face                              (:foreground carpYellow))
  (swiper-background-match-face-1                (:background surimiOrange :foreground sumiInk-0))
  (swiper-background-match-face-2                (:background crystalBlue :foreground sumiInk-0))
  (swiper-background-match-face-3                (:background boatYellow2 :foreground sumiInk-0))
  (swiper-background-match-face-4                (:background peachRed :foreground sumiInk-0))
  (swiper-match-face-1                           (:inherit 'swiper-background-match-face-1))
  (swiper-match-face-2                           (:inherit 'swiper-background-match-face-2))
  (swiper-match-face-3                           (:inherit 'swiper-background-match-face-3))
  (swiper-match-face-4                           (:inherit 'swiper-background-match-face-4))

  (counsel-outline-default                       (:foreground carpYellow))
  (info-header-xref                              (:foreground carpYellow))
  (xref-file-header                              (:foreground carpYellow))
  (xref-match                                    (:foreground carpYellow))

  ;; rainbow delimiters
  (rainbow-delimiters-mismatched-face            (:foreground peachRed))
  (rainbow-delimiters-unmatched-face             (:foreground waveAqua2))
  (rainbow-delimiters-base-error-face            (:foreground peachRed))
  (rainbow-delimiters-base-face                  (:foreground carpYellow))

  (rainbow-delimiters-depth-1-face               (:foreground crystalBlue))
  (rainbow-delimiters-depth-2-face               (:foreground roninYellow))
  (rainbow-delimiters-depth-3-face               (:foreground waveAqua2))
  (rainbow-delimiters-depth-4-face               (:foreground sakuraPink))
  (rainbow-delimiters-depth-5-face               (:foreground carpYellow))
  (rainbow-delimiters-depth-6-face               (:foreground peachRed))
  (rainbow-delimiters-depth-7-face               (:foreground peachRed))
  (rainbow-delimiters-depth-8-face               (:foreground waveAqua2))
  (rainbow-delimiters-depth-9-face               (:foreground springViolet2))

  ;; show-paren
  (show-paren-match                              (:background waveAqua1 :foreground sumiInk-0 :bold t))
  (show-paren-match-expression	                 (:background waveAqua1 :foreground sumiInk-0 :bold t))
  (show-paren-mismatch                           (:background peachRed :foreground old-white))

  (tooltip                                       (:foreground sumiInk :background carpYellow))
  ;; company-box
  (company-tooltip                               (:background sumiInk-2))
  (company-tooltip-common                        (:foreground autumnYellow))
  (company-tooltip-quick-access                  (:foreground springViolet2))
  (company-tooltip-scrollbar-thumb               (:background autumnRed))
  (company-tooltip-scrollbar-track               (:background sumiInk-2))
  (company-tooltip-search                        (:background carpYellow :foreground sumiInk-0 :distant-foreground fujiWhite))
  (company-tooltip-selection                     (:background peachRed :foreground winterRed :bold t))
  (company-tooltip-mouse                         (:background sumiInk-2 :foreground sumiInk-0 :distant-foreground fujiWhite))
  (company-tooltip-annotation                    (:foreground peachRed :distant-foreground sumiInk-1))
  (company-scrollbar-bg                          (:inherit 'tooltip))
  (company-scrollbar-fg                          (:background peachRed))
  (company-preview                               (:foreground carpYellow))
  (company-preview-common                        (:foreground peachRed :bold t))
  (company-preview-search                        (:inherit 'company-tooltip-search))
  (company-template-field                        (:inherit 'match))

  (consult-file (:foreground springViolet2))

  ;; (flycheck-error-list-error (:box (:color winterRed :line-width 2) :foreground peachRed :background winterRed :height 140 :weight 'bold))
  ;; (flycheck-error-list-warning (:box (:color winterYellow :line-width 2) :foreground carpYellow :background winterYellow :height 140 :weight 'bold))
  ;; (flycheck-error-list-info (:box (:color winterBlue :line-width 2) :foreground crystalBlue :background winterBlue :height 140 :weight 'bold))

  ;; (flycheck-error                     (:box (:color winterRed :line-width 2) :foreground peachRed :background winterRed :height 140 :weight 'bold))
  ;; (flycheck-warning                   (:box (:color winterYellow :line-width 2) :foreground carpYellow :background winterYellow :height 140 :weight 'bold))
  ;; (flycheck-info                      (:box (:color winterBlue :line-width 2) :foreground crystalBlue :background winterBlue :height 140 :weight 'bold))

  (flycheck-inline-error                         (:foreground peachRed :background winterRed :height 150 :italic t))
  (flycheck-inline-info                          (:foreground crystalBlue :background waveBlue-2 :height 150 :italic t))
  (flycheck-inline-warning                       (:foreground carpYellow :background winterYellow :height 150 :italic t))
  (jinx-misspelled                               (:underline (:color roninYellow :style 'wave)))

  ;; indent dots
  (highlight-indent-guides-character-face        (:foreground sumiInk-3))
  (highlight-indent-guides-stack-character-face  (:foreground sumiInk-3))
  (highlight-indent-guides-stack-odd-face        (:foreground sumiInk-3))
  (highlight-indent-guides-stack-even-face       (:foreground comet))
  (highlight-indent-guides-stack-character-face  (:foreground sumiInk-3))
  (highlight-indent-guides-even-face             (:foreground sumiInk-2))
  (highlight-indent-guides-odd-face              (:foreground comet))

  (highlight-indentation-current-column-face     (:background sumiInk-2))
  (highlight-indentation-face                    (:foreground comet :background comet))

  (highlight-operators-face                      (:foreground boatYellow2))
  (highlight-quoted-symbol                       (:foreground springGreen))
  (highlight-numbers-face                        (:foreground sakuraPink))
  (highlight-symbol-face                         (:background winterBlue :foreground springBlue :weight 'normal))
  
  ;; ivy
  (ivy-current-match                             (:background crystalBlue :foreground sumiInk-0 :bold t))
  (ivy-action                                    (:foreground fujiWhite))
  (ivy-grep-line-number                          (:foreground springGreen))
  (ivy-minibuffer-match-face-1                   (:foreground peachRed))
  (ivy-minibuffer-match-face-2                   (:foreground springGreen))
  (ivy-minibuffer-match-highlight                (:foreground waveAqua2))
  (ivy-grep-info                                 (:foreground waveAqua2))
  (ivy-grep-line-number                          (:foreground springViolet2))
  (ivy-confirm-face                              (:foreground waveAqua2))

  ;; posframe's
  (ivy-posframe                                  (:background sumiInk-2))
  (ivy-posframe-border                           (:background sumiInk-3))

  ;;treemacs
  (treemacs-directory-collapsed-face             (:foreground sumiInk-5 :weight 'normal))
  (treemacs-window-background-face               (:background sumiInk-1b))
  (treemacs-directory-face                       (:foreground sumiInk-5 :weight 'normal))
  (treemacs-file-face                            (:foreground sumiInk-5 :weight 'thin))
  (treemacs-nerd-icons-file-face                 (:inherit 'treemacs-file-face))
  (treemacs-nerd-icons-root-face                 (:inherit 'treemacs-directory-face))

  (treemacs-git-added-face                       (:foreground surimiOrange :weight 'normal))
  (treemacs-git-renamed-face                     (:foreground springGreen :weight 'normal))
  (treemacs-git-ignored-face                     (:foreground sumiInk-4 :italic t :weight 'thin))
  (treemacs-git-unmodified-face                  (:foreground sumiInk-5 :weight 'thin))
  (treemacs-git-untracked-face                   (:foreground fujiGray :weight 'normal))
  (treemacs-git-renamed-face                     (:foreground carpYellow :weight 'normal))
  (treemacs-git-modified-face                    (:foreground springBlue :weight 'normal))

  ;; lsp and lsp-ui
  (lsp-headerline-breadcrumb-path-error-face     (:underline (:color springGreen :style 'wave) :foreground sumiInk-4 :background sumiInk-0))
  (lsp-headerline-breadcrumb-path-face           (:background sumiInk-0))
  (lsp-headerline-breadcrumb-path-hint-face      (:background sumiInk-0))
  (lsp-headerline-breadcrumb-path-info-face      (:background sumiInk-0))
  (lsp-headerline-breadcrumb-separator-face      (:background sumiInk-0))
  (lsp-headerline-breadcrumb-symbols-face        (:background sumiInk-0))
  (lsp-headerline-breadcrumb-project-prefix-face (:background sumiInk-0))
  (lsp-headerline-breadcrumb-symbols-error-face  (:foreground peachRed))

  (lsp-ui-doc-background                         (:background sumiInk-0 :foreground peachRed))
  (lsp-ui-doc-header                             (:background sumiInk-0 :foreground peachRed))
  (lsp-ui-doc-border                             (:foreground nil))
  (lsp-ui-peek-filename                          (:foreground waveAqua2))
  (lsp-ui-sideline-code-action                   (:foreground carpYellow))
  (lsp-ui-sideline-current-symbol                (:foreground springBlue))
  (lsp-ui-sideline-symbol                        (:foreground dragonBlue))

  (eldoc-highlight-function-argument (:foreground carpYellow :background winterYellow))

  ;; dashboard
  (dashboard-heading                             (:foreground springViolet2 :bold t))
  (dashboard-items-face                          (:foreground fujiWhite))
  (dashboard-banner-logo-title                   (:bold t :height 200))
  (dashboard-no-items-face                       (:foreground sumiInk-4))
  (dashboard-text-heading                        (:foreground crystalBlue))
  (dashboard-text-banner                         (:foreground crystalBlue))

  ;; all-the-icons
  (all-the-icons-dgreen                          (:foreground waveAqua2))
  (all-the-icons-green                           (:foreground waveAqua2))
  (all-the-icons-dpurple                         (:foreground springViolet2))
  (all-the-icons-purple                          (:foreground springViolet2))

  ;; evil
  (evil-ex-lazy-highlight                        (:foreground winterRed :background sakuraPink :bold t))
  (evil-ex-substitute-matches                    (:foreground winterRed :background autumnRed :strike-through t))
  (evil-ex-substitute-replacement                (:foreground winterBlue :background crystalBlue :bold))
  (evil-search-highlight-persist-highlight-face  (:background carpYellow))

  ;; term
  (term                                          (:background sumiInk-0 :foreground fujiWhite))
  (term-color-blue                               (:background dragonBlue :foreground dragonBlue))
  (term-color-bright-blue                        (:inherit 'term-color-blue))
  (term-color-green                              (:background waveAqua2 :foreground waveAqua2))
  (term-color-bright-green                       (:inherit 'term-color-green))
  (term-color-black                              (:background sumiInk-0 :foreground fujiWhite))
  (term-color-bright-black                       (:background sumiInk-1b :foreground sumiInk-1b))
  (term-color-white                              (:background fujiWhite :foreground fujiWhite))
  (term-color-bright-white                       (:background old-white :foreground old-white))
  (term-color-red                                (:background peachRed :foreground peachRed))
  (term-color-bright-red                         (:background springGreen :foreground springGreen))
  (term-color-yellow                             (:background roninYellow :foreground autumnRed))
  (term-color-bright-yellow                      (:background carpYellow :foreground carpYellow))
  (term-color-cyan                               (:background springBlue :foreground springBlue))
  (term-color-bright-cyan                        (:background springBlue :foreground springBlue))
  (term-color-magenta                            (:background springViolet2 :foreground springViolet2))
  (term-color-bright-magenta                     (:background springViolet2 :foreground springViolet2))

  ;; popup
  (popup-face                                    (:inherit 'tooltip))
  (popup-selection-face                          (:inherit 'tooltip))
  (popup-tip-face                                (:inherit 'tooltip))

  ;; anzu
  (anzu-match-1                                  (:foreground waveAqua2 :background sumiInk-2))
  (anzu-match-2                                  (:foreground carpYellow :background sumiInk-2))
  (anzu-match-3                                  (:foreground waveAqua2 :background sumiInk-2))

  (anzu-mode-line                                (:foreground sumiInk-0 :background springViolet2))
  (anzu-mode-no-match	                         (:foreground fujiWhite :background peachRed))
  (anzu-replace-to                               (:foreground springBlue :background winterBlue))
  (anzu-replace-highlight                        (:foreground peachRed :background winterRed :strike-through t))

  ;; ace
  (ace-jump-face-background                      (:foreground waveBlue-2))
  (ace-jump-face-foreground                      (:foreground peachRed :background sumiInk-0 :bold t))
  
  ;; vertico
  (vertico-multiline                             (:background winterBlue :foreground waveAqua2))
  (vertico-group-title                           (:foreground sumiInk-5 :bold t))
  (vertico-group-separator                       (:foreground sumiInk-5 :strike-through t))
  (vertico-current                               (:background sumiInk-2 :weight 'normal))

  (vertico-posframe-border                       (:background sumiInk))
  (vertico-posframe                              (:background sumiInk))

  (orderless-match-face-0                        (:foreground fujiWhite :weight 'bold))
  (orderless-match-face-1                        (:foreground peachRed :weight 'bold))
  (orderless-match-face-2                        (:foreground springGreen :weight 'bold))
  (orderless-match-face-3                        (:foreground carpYellow :weight 'bold))

  (comint-highlight-prompt                       (:foreground crystalBlue :background winterBlue :italic t))
  (comint-highlight-input                        (:foreground peachRed :weight 'semi-bold))

  (dape-stack-trace (:background winterRed))

  (completions-annotations                       (:foreground dragonBlue :italic t))

  (corfu-current                                 (:inherit 'vertico-current))
  (corfu-annotations                             (:background winterGreen :foreground springGreen))
  (corfu-default                                 (:background sumiInk-1 :foreground springViolet2))
  (corfu-border                                  (:background waveBlue-2))
  (corfu-popupinfo                               (:background sumiInk :foreground springBlue :box (:line-width 2 :color sumiInk)))

  ;; hydra
  (hydra-face-amaranth                           (:foreground autumnRed))
  (hydra-face-blue                               (:foreground springBlue))
  (hydra-face-pink                               (:foreground sakuraPink))
  (hydra-face-red                                (:foreground peachRed))
  (hydra-face-teal                               (:foreground waveAqua2))

  ;; centaur-tabs
  (centaur-tabs-active-bar-face                  (:background springBlue :foreground fujiWhite))
  (centaur-tabs-selected                         (:background sumiInk-1b :foreground fujiWhite :bold t))
  (centaur-tabs-selected-modified                (:background sumiInk-1b :foreground fujiWhite))
  (centaur-tabs-modified-marker-selected         (:background sumiInk-1b :foreground autumnYellow))
  (centaur-tabs-close-selected                   (:inherit 'centaur-tabs-selected))
  (tab-line                                      (:background sumiInk-0))

  (centaur-tabs-unselected                       (:background sumiInk-0 :foreground sumiInk-4))
  (centaur-tabs-default                          (:background sumiInk-0 :foreground sumiInk-4))
  (centaur-tabs-unselected-modified              (:background sumiInk-0 :foreground peachRed))
  (centaur-tabs-modified-marker-unselected       (:background sumiInk-0 :foreground sumiInk-4))
  (centaur-tabs-close-unselected                 (:background sumiInk-0 :foreground sumiInk-4))

  (centaur-tabs-close-mouse-face                 (:background nil :foreground peachRed))
  (centaur-tabs-default                          (:background roninYellow ))
  (centaur-tabs-name-mouse-face                  (:foreground springBlue :bold t))

  (git-gutter:added                              (:foreground autumnGreen))
  (git-gutter:deleted                            (:foreground peachRed))
  (git-gutter:modified                           (:foreground springBlue))

  (marginalia-documentation (:foreground sumiInk-5 :italic t :weight 'thin))

  (diff-hl-margin-change                         (:foreground springBlue :background winterBlue))
  (diff-hl-margin-delete                         (:foreground peachRed :background winterRed))
  (diff-hl-margin-insert                         (:foreground comet :background winterBlue))

  (bm-fringe-face                                (:background peachRed :foreground sumiInk-3))
  (bm-fringe-persistent-face                     (:background peachRed :foreground sumiInk-3))

  (ansi-color-green                              (:foreground springGreen))
  (ansi-color-black                              (:background sumiInk-0))
  (ansi-color-cyan                               (:foreground waveAqua2))
  (ansi-color-magenta                            (:foreground sakuraPink))
  (ansi-color-blue                               (:foreground crystalBlue))
  (ansi-color-red                                (:foreground peachRed))
  (ansi-color-white                              (:foreground fujiWhite))
  (ansi-color-yellow                             (:foreground autumnYellow))
  (ansi-color-bright-white                       (:foreground old-white))
  (ansi-color-bright-white                       (:foreground old-white))

 ;; Tree sitter highlightning
  (tree-sitter-hl-face:annotation                (:foreground crystalBlue :weight 'semi-bold))
  (tree-sitter-hl-face:annotation.builtin        (:foreground sakuraPink :weight 'semi-bold))
  (tree-sitter-hl-face:annotation.type           (:foreground peachRed))

  (tree-sitter-hl-face:function                  (:inherit 'font-lock-function-name-face))
  (tree-sitter-hl-face:function.call             (:foreground springBlue :weight 'thin))
  (tree-sitter-hl-face:function.builtin          (:foreground springGreen))
  (tree-sitter-hl-face:function.special          (:foreground springGreen :italic t :bold t))
  (tree-sitter-hl-face:function.macro            (:foreground waveAqua2))
  (tree-sitter-hl-face:function.label            (:foreground autumnYellow))

  (tree-sitter-hl-face:method                    (:inherit 'tree-sitter-hl-face:function))
  (tree-sitter-hl-face:method.call               (:inherit 'tree-sitter-hl-face:method))

  (tree-sitter-hl-face:type                      (:inherit 'font-lock-type-face))
  (tree-sitter-hl-face:type.parameter            (:foreground peachRed :italic t))
  (tree-sitter-hl-face:type.argument             (:foreground sumiInk-4))
  (tree-sitter-hl-face:type.builtin              (:inherit 'font-lock-builtin-face))
  (tree-sitter-hl-face:type.super                (:foreground peachRed))
  (tree-sitter-hl-face:constructor               (:foreground waveAqua2 :weight 'semi-bold))

  (tree-sitter-hl-face:variable                  (:inherit 'font-lock-variable-name-face))
  (tree-sitter-hl-face:variable.parameter        (:inherit 'tree-sitter-hl-face:type.parameter))
  (tree-sitter-hl-face:variable.builtin          (:foreground springBlue :italic t))
  (tree-sitter-hl-face:variable.special          (:foreground oniViolet :italic t))
  (tree-sitter-hl-face:variable.synthesized      (:foreground peachRed))

  (tree-sitter-hl-face:property                  (:foreground crystalBlue :weight 'extra-light))
  (tree-sitter-hl-face:property.definition       (:foreground crystalBlue :italic t))

  (tree-sitter-hl-face:comment                   (:inherit 'font-lock-comment-face))
  (tree-sitter-hl-face:doc                       (:inherit 'font-lock-comment-face))
  (tree-sitter-hl-face:string                    (:inherit 'font-lock-string-face))
  (tree-sitter-hl-face:string.special            (:inherit 'font-lock-string-face))
  (tree-sitter-hl-face:escape                    (:inherit 'font-lock-regexp-grouping-backslash))
  (tree-sitter-hl-face:embedded                  (:foreground springBlue))

  (tree-sitter-hl-face:keyword                   (:inherit 'font-lock-keyword-face))
  (tree-sitter-hl-face:keyword.compiler          (:foreground peachRed))
  (tree-sitter-hl-face:keyword.type              (:foreground crystalBlue))
  (tree-sitter-hl-face:operator                  (:inherit 'font-lock-operator-face))
  (tree-sitter-hl-face:label                     (:foreground sumiInk-4))
  (tree-sitter-hl-face:constant                  (:inherit 'font-lock-constant-face))
  (tree-sitter-hl-face:constant.builtin          (:inherit 'font-lock-constant-face :weight 'normal))
  (tree-sitter-hl-face:number                    (:inherit 'font-lock-number-face))

  (tree-sitter-hl-face:punctuation               (:foreground crystalBlue :weight 'normal))
  (tree-sitter-hl-face:punctuation.bracket       (:foreground springBlue))
  (tree-sitter-hl-face:punctuation.delimiter     (:foreground old-white))
  (tree-sitter-hl-face:punctuation.special       (:foreground surimiOrange))

  (tree-sitter-hl-face:case-pattern              (:foreground autumnYellow))
  (tree-sitter-hl-face:keyword.compiler          (:foreground sumiInk-4 :italic t :weight 'normal))

  (focus-unfocused (:foreground sumiInk-4))
  (window-stool-face (:background sumiInk-2 :underline (:color sumiInk-3)))

  (solaire-default-face (:background sumiInk-2 :foreground sumiInk-5))
  (solaire-fringe-face (:background sumiInk-2 :foreground sumiInk-5))

  (minimap-active-region-background (:background sumiInk-3))

  ;; (magit-filename (:foreground crystalBlue))
  (magit-diff-file-heading (:foreground fujiWhite :weight 'normal))

  (copilot-overlay-face (:background sumiInk-3 :foreground springViolet2))

  (transient-key (:foreground peachRed :bold t))
  (transient-key-stay (:foreground springBlue :backgroud winterBlue :bold t))
  (transient-key-exit (:foreground peachRed :background winterRed :bold t))

  ;; (magit-section-heading (:foreground carpYellow :background winterYellow :weight 'normal))

  ;; (magit-diff-base (:foreground crystalBlue :background winterBlue))
  ;; (magit-diff-base-highlight (:foreground crystalBlue :background winterBlue))

  ;; (magit-diff-added (:foreground autumnGreen :background winterGreen))
  ;; (magit-diff-added-highlight (:foreground springGreen :background winterGreen))

  ;; (magit-our-added (:background winterRed))
  ;; (magit-our-added-highlight (:background winterRed))

  ;; (magit-removed-added (:background winterRed))
  ;; (magit-removed-added-highlight (:background winterRed))

 ))

;;;###autoload
(and load-file-name
     (boundp 'custom-theme-load-path)
     (add-to-list 'custom-theme-load-path
                  (file-name-as-directory
                   (file-name-directory load-file-name))))

(provide-theme 'photon-dark)
;;; kanagawa-theme.el ends here
