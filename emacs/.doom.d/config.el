;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "xinove"
      user-mail-address "xinovebig@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
 ;; (setq doom-font (font-spec :family "monospace" :size 13 :weight 'semi-light)
 ;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))
;; (setq doom-font (font-spec :family "Mononoki Nerd Font" :size 13.0)
;;       doom-variable-pitch-font (font-spec :family "Mononoki Nerd Font" :size 13.0))
;;(setq doom-font (font-spec :family "JetBrains Mono" :size 13.0))
(setq doom-font (font-spec :family "Roboto Mono" :size 13.0)
       doom-variable-pitch-font (font-spec :family "Roboto Mono" :size 13.0))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;;(setq doom-theme 'doom-gruvbox)
;; Some themes I liked: doom-peacock, doom-henna, doom-horizon, doom-monokai-pro
;;
;; Random themes at startup
(setq doom-theme (seq-random-elt (custom-available-themes)))


;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/stuff/Notas")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

(setq treemacs-width 17)

(setq-hook! '(c-mode-hook c++-mode-hook) indent-tabs-mode t)

;; Dvorak only in insert mode
(add-hook 'evil-insert-state-entry-hook (lambda () (shell-command "setxkbmap dvorak")))
(add-hook 'evil-insert-state-exit-hook (lambda () (shell-command "setxkbmap br")))

;; config org pomodoro sons 😏
(setq org-pomodoro-finished-sound "~/Music/dogdoin.wav")
(setq org-pomodoro-short-break-sound "~/Music/fart.wav")
;; (setq org-pomodoro-finished-sound-args)


;; old config
;; Mudando o formato de data do org-mode
(setq-default org-display-custom-times t)
(setq org-time-stamp-custom-formats '("<%A %e %b %Y>" . "<%A %e %b %Y %H:%M>"))

;; mudando o bullet list de org-superstar
;; (setq-default org-superstar-headline-bullets-list '("☭" "▧" "◈" "ᛜ" "►" "◇"))
(setq-default org-superstar-headline-bullets-list '("͏" "◈" "▧" "ᛜ" "►" "◇"))
(add-hook 'org-mode-hook (lambda () (org-superstar-mode 1)))

;; Maximizar no start-up
(add-to-list 'default-frame-alist '(fullscreen . maximized))

;; Pretty org mode https://zzamboni.org/post/beautifying-org-mode-in-emacs/
;;(setq org-hide-emphasis-markers t)
;;(font-lock-add-keywords 'org-mode'(("^ *\\([-]\\) "(0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•"))))))
(let* ((variable-tuple
          (cond ((x-list-fonts "ETBembo")         '(:font "ETBembo"))
                ((x-list-fonts "Source Sans Pro") '(:font "Source Sans Pro"))
                ((x-list-fonts "Lucida Grande")   '(:font "Lucida Grande"))
                ((x-list-fonts "Verdana")         '(:font "Verdana"))
                ((x-family-fonts "Sans Serif")    '(:family "Sans Serif"))
                (nil (warn "Cannot find a Sans Serif Font.  Install Source Sans Pro."))))
         (base-font-color     (face-foreground 'default nil 'default))
         (headline           `(:inherit default :weight bold :foreground ,base-font-color)))

    (custom-theme-set-faces
     'user
     `(org-level-8 ((t (,@headline ,@variable-tuple))))
     `(org-level-7 ((t (,@headline ,@variable-tuple))))
     `(org-level-6 ((t (,@headline ,@variable-tuple))))
     `(org-level-5 ((t (,@headline ,@variable-tuple))))
     `(org-level-4 ((t (,@headline ,@variable-tuple :height 1.0))))
     `(org-level-3 ((t (,@headline ,@variable-tuple :height 1.1))))
     `(org-level-2 ((t (,@headline ,@variable-tuple :height 1.2))))
     `(org-level-1 ((t (,@headline ,@variable-tuple :height 1.35))))
     `(org-document-title ((t (,@headline ,@variable-tuple :height 1.5 :underline nil))))))
(custom-theme-set-faces
 'user
  '(variable-pitch ((t (:family "Fira Code Retina" :height 150 :weight thin))))
  '(fixed-pitch ((t ( :family "ETBembo" :height 160)))))
(add-hook 'org-mode-hook 'variable-pitch-mode)
(custom-theme-set-faces
   'user
   '(org-block ((t (:inherit fixed-pitch))))
   '(org-code ((t (:inherit (shadow fixed-pitch)))))
   '(org-document-info ((t (:foreground "dark orange"))))
   '(org-document-info-keyword ((t (:inherit (shadow fixed-pitch)))))
   '(org-indent ((t (:inherit (org-hide fixed-pitch)))))
   '(org-link ((t (:foreground "royal blue" :underline t))))
   '(org-meta-line ((t (:inherit (font-lock-comment-face fixed-pitch)))))
   '(org-property-value ((t (:inherit fixed-pitch))) t)
   '(org-special-keyword ((t (:inherit (font-lock-comment-face fixed-pitch)))))
   '(org-table ((t (:inherit fixed-pitch :foreground "#83a598"))))
   '(org-tag ((t (:inherit (shadow fixed-pitch) :weight bold :height 0.8))))
   '(org-verbatim ((t (:inherit (shadow fixed-pitch))))))

(use-package org-roam
  :ensure t
  :init (setq org-roam-v2-ack t)
  :custom (org-roam-directory "~/stuff/Notas/roam")
  :config (org-roam-setup))

(map! :leader
      (:prefix-map ("n" . "Org roam")
        :desc "Node find" "f" #'org-roam-node-find
        :desc "Node insert" "i" #'org-roam-node-insert
        :desc "Buffer toggle" "l" #'org-roam-buffer-toggle
        :desc "Org capture finalize" "s" #'org-capture-finalize
        ;; Bindings from doom, activate as needed
        ;; :desc "Open random node"           "a" #'org-roam-node-random
        ;; :desc "Find node"                  "f" #'org-roam-node-find
        ;; :desc "Find ref"                   "F" #'org-roam-ref-find
        ;; :desc "Show graph"                 "g" #'org-roam-graph
        ;; :desc "Insert node"                "i" #'org-roam-node-insert
        ;; :desc "Capture to node"            "n" #'org-roam-capture
        :desc "Toggle roam buffer"         "r" #'org-roam-buffer-toggle
        :desc "Launch roam buffer"         "R" #'org-roam-buffer-display-dedicated
        :desc "Todo list"                    "t" #'org-todo-list
        ;; :desc "Sync database"              "s" #'org-roam-db-sync
         (:prefix ("d" . "by date")
           :desc "Goto previous note"        "b" #'org-roam-dailies-goto-previous-note
           :desc "Goto date"                 "d" #'org-roam-dailies-goto-date
           :desc "Capture date"              "D" #'org-roam-dailies-capture-date
           :desc "Goto next note"            "f" #'org-roam-dailies-goto-next-note
           :desc "Goto tomorrow"             "m" #'org-roam-dailies-goto-tomorrow
           :desc "Capture tomorrow"          "M" #'org-roam-dailies-capture-tomorrow
           :desc "Capture today"             "n" #'org-roam-dailies-capture-today
           :desc "Goto today"                "t" #'org-roam-dailies-goto-today
           :desc "Capture today"             "T" #'org-roam-dailies-capture-today
           :desc "Goto yesterday"            "y" #'org-roam-dailies-goto-yesterday
           :desc "Capture yesterday"         "Y" #'org-roam-dailies-capture-yesterday
           :desc "Find directory"            "-" #'org-roam-dailies-find-directory)
        ;;old notes bindins
        (:prefix-map ("n" . "notes")
         :desc "Search notes for symbol"      "*" #'+default/search-notes-for-symbol-at-point
         :desc "Org agenda"                   "a" #'org-agenda
         (:when (featurep! :tools biblio)
          :desc "Bibliographic entries"        "b"
          (cond ((featurep! :completion vertico)  #'bibtex-actions-open-entry)
                ((featurep! :completion ivy)      #'ivy-bibtex)
                ((featurep! :completion helm)     #'helm-bibtex)))
         :desc "Toggle last org-clock"        "c" #'+org/toggle-last-clock
         :desc "Cancel current org-clock"     "C" #'org-clock-cancel
         :desc "Open deft"                    "d" #'deft
         (:when (featurep! :lang org +noter)
          :desc "Org noter"                  "e" #'org-noter)
         :desc "Find file in notes"           "f" #'+default/find-in-notes
         :desc "Browse notes"                 "F" #'+default/browse-notes
         :desc "Org store link"               "l" #'org-store-link
         :desc "Tags search"                  "m" #'org-tags-view
         :desc "Org capture"                  "n" #'org-capture
         :desc "Goto capture"                 "N" #'org-capture-goto-target
         :desc "Active org-clock"             "o" #'org-clock-goto
         :desc "Todo list"                    "t" #'org-todo-list
         :desc "Search notes"                 "s" #'+default/org-notes-search
         :desc "Search org agenda headlines"  "S" #'+default/org-notes-headlines
         :desc "View search"                  "v" #'org-search-view
         :desc "Org export to clipboard"        "y" #'+org/export-to-clipboard
         :desc "Org export to clipboard as RTF" "Y" #'+org/export-to-clipboard-as-rich-text)))
