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
  (sumiInk-2		"#2A2A37" "#121212")
  (sumiInk-3		"#363646" "#303030")
  (sumiInk-4		"#54546D" "#303030")
  (sumiInk-5		"#888899" "#303030")
  (sumiInk-6		"#a0a0ae" "#303030")

  (waveBlue-1		"#223249" "#4e4e4e")
  (waveBlue-2		"#2D4F67" "#585858")
  (waveAqua1		"#5dc9ab" "#6a9589")
  (waveAqua2		"#92e8d7" "#717C7C")
  
  (samuraiRed       "#E82438" "#585858")

  (winterGreen		"#215c22" "#585858")
  (winterYellow		"#473420" "#585858")
  (winterRed		"#211a1c" "#585858")
  (winterBlue		"#1c1c29" "#585858")

  (autumnGreen		"#90d47f" "#585858")
  (autumnRed		"#f74043" "#585858")
  (autumnYellow		"#f2c47e" "#585858")

  (roninYellow		"#ffc55c" "#585858")

  (dragonBlue		"#b9d5eb" "#658594")
  (fujiGray             "#94938e" "#717C7C")
  (springViolet1	"#b9a8e0" "#717C7C")
  (oniViolet		"#c8a6ff" "#717C7C")
  (crystalBlue		"#9fbbf5" "#717C7C")
  (springViolet2	"#a3c0ff" "#717C7C")
  (springBlue		"#a3e3ff" "#717C7C")
  (springGreen		"#97db84" "#717C7C")
  (boatYellow2		"#e6bd70" "#717C7C")
  (carpYellow		"#fce397" "#717C7C")
  (sakuraPink		"#ff94b7" "#717C7C")
  (peachRed             "#ff8a97" "#717C7C")
  (surimiOrange		"#fa9775" "#717C7C")
  (comet                "#6f6d94" "#4e4e4e"))

 ;; Customize faces
 (
  (default                                       (:background sumiInk-1b :foreground fujiWhite))
  (border                                        (:foreground sumiInk-2))
  (button                                        (:foreground sakuraPink))
  (child-frame-border                            (:foreground sumiInk-0))
  (cursor                                        (:background peachRed :foreground sumiInk-0 :bold t))
  (error                                         (:foreground peachRed))
  (fringe                                        (:foreground dragonBlue))
  (glyph-face                                    (:background sumiInk-4))
  (glyphless-char                                (:foreground sumiInk-4))
  (header-line                                   (:background sumiInk-1b :overline fujiGray))
  (header-line-inactive                          (:background sumiInk-1b :weight 'medium :overline fujiGray))
  (highlight                                     (:background winterBlue :foreground oniViolet))
  (hl-line                                       (:background sumiInk-2))
  (homoglyph                                     (:foreground waveAqua2))
  (line-number                                   (:foreground sumiInk-4))
  (line-number-current-line                      (:background sumiInk-2 :foreground crystalBlue :weight 'semi-bold))
  (lv-separator                                  (:foreground waveBlue-2 :background sumiInk-2))
  (match                                         (:background carpYellow :foreground sumiInk-0))
  (menu                                          (:foreground fujiWhite))
  (mode-line                                     (:background sumiInk-1b :color sumiInk-2))
  (mode-line-inactive                            (:background sumiInk-1b :foreground fujiGray :box (:line-width 6 :color sumiInk-1) :weight 'extra-light :overline fujiGray))
  (mode-line-active                              (:background sumiInk-1b :foreground fujiWhite :box (:line-width 6 :color sumiInk-1) :overline fujiWhite))
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
  (font-lock-keyword-face                        (:foreground springBlue :weight 'semi-bold :slant 'italic))
  (font-lock-type-face                           (:foreground oniViolet :weight 'normal))
  (font-lock-warning-face                        (:foreground roninYellow))
  (font-lock-string-face                         (:foreground springGreen :italic t))
  (font-lock-builtin-face                        (:foreground springViolet1))
  (font-lock-reference-face                      (:foreground peachRed))
  (font-lock-constant-face                       (:foreground carpYellow))
  (font-lock-function-name-face                  (:foreground sakuraPink))
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
  (dired-directory                               (:foreground carpYellow))
  (trailing-whitespace                           (:background comet))
  (mode-line                                     (:background sumiInk-0 :foreground fujiWhite :bold t))

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

  (consult-file (:foreground springViolet2))

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
  
  (eldoc-highlight-function-argument (:foreground carpYellow :background winterYellow))

  ;; dashboard
  (dashboard-heading                             (:foreground springViolet2 :bold t))
  (dashboard-items-face                          (:foreground fujiWhite))
  (dashboard-banner-logo-title                   (:bold t :height 200))
  (dashboard-no-items-face                       (:foreground sumiInk-4))
  (dashboard-text-heading                        (:foreground crystalBlue))
  (dashboard-text-banner                         (:foreground crystalBlue))

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
  (dape-breakpoint-face (:foreground samuraiRed))

  (completions-annotations                       (:foreground dragonBlue :italic t))

  (corfu-current                                 (:background sumiInk-2 :foreground oniViolet :weight 'bold))
  (corfu-annotations                             (:background winterGreen :foreground springGreen))
  (corfu-default                                 (:background sumiInk-1 :foreground fujiWhite))
  (corfu-border                                  (:background waveBlue-2))
  (corfu-popupinfo                               (:background sumiInk :foreground springBlue :box (:line-width 2 :color sumiInk)))

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

  (magit-diff-file-heading (:foreground fujiWhite :weight 'normal))

  (transient-key (:foreground peachRed :bold t))
  (transient-key-stay (:foreground springBlue :backgroud winterBlue :bold t))
  (transient-key-exit (:foreground peachRed :background winterRed :bold t))
 ))

;;;###autoload
(and load-file-name
     (boundp 'custom-theme-load-path)
     (add-to-list 'custom-theme-load-path
                  (file-name-as-directory
                   (file-name-directory load-file-name))))

(provide-theme 'photon-dark)
