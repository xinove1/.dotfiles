;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;(setq doom-theme 'doom-one)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
;(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
;(setq org-directory "~/org/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
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
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

(setq user-full-name "xinove"
      user-mail-address "xinovebig@gmail.com")

;(setq doom-font (font-spec :family "Roboto Mono" :size 13.0))
;(setq doom-font (font-spec :family "Iosevka Term" :size 13.0))
;(setq doom-font (font-spec :family "Hack" :size 13.0))
;(setq doom-font (font-spec :family "JetBrains Mono" :size 13.0))
;(setq doom-font (font-spec :family "Mononoki Nerd Font" :size 13.0))

(setq doom-font (seq-random-elt '("JetBrains Mono-13"
                                 "Mononoki Nerd Font-13"
                                 "Roboto Mono-13"
                                 "Hack-13"
                                 "Iosevka Term-13")))

(setq doom-theme (seq-random-elt '(doom-peacock doom-henna doom-horizon doom-laserwave doom-rouge
                                   doom-molokai doom-monokai-pro doom-old-hope doom-gruvbox)))

(setq org-directory "~/stuff/Notas")

(setq display-line-numbers-type t)

(with-eval-after-load 'evil
    (defalias #'forward-evil-word #'forward-evil-symbol)
    ;; make evil-search-word look for symbol rather than word boundaries
    (setq-default evil-symbol-word-search t))

;(setq treemacs-width 20)
;(setq doom-themes-treemacs-theme "doom-colors")

(setq-hook! '(c-mode-hook c++-mode-hook) indent-tabs-mode t)
;(setq rtags-path "~/Documents/rtags/bin")

;; Dvorak only in insert mode
(defun change-kbd-dvorak()
  (if (or (eq major-mode 'shell-mode ) (eq major-mode 'vterm-mode ))
       (shell-command "setxkbmap br")
       ;(shell-command "setxkbmap us -variant colemak_dh")))
       (shell-command "setxkbmap dvorak")))
(eq major-mode "vterm-mode")
;(setq tmp default-directory)
;(setq default-directory "~/")
;(shell-command "setxkbmap br")
;(setq default-directory tmp)

(defun change-kbd-br()
  (if (not (or (eq major-mode 'shell-mode ) (eq major-mode 'vterm-mode )))
       (shell-command "setxkbmap br")
       (shell-command "setxkbmap br")))

(add-hook 'evil-insert-state-entry-hook 'change-kbd-dvorak)
(add-hook 'evil-insert-state-exit-hook 'change-kbd-br)

;; config org pomodoro sons 😏
(setq org-pomodoro-finished-sound "~/Music/dogdoin.wav")
(setq org-pomodoro-short-break-sound "~/Music/fart.wav")
;; (setq org-pomodoro-finished-sound-args)


(setq-default org-display-custom-times t)
(setq org-time-stamp-custom-formats '("<%A %e %b %Y>" . "<%A %e %b %Y %H:%M>"))
(setq org-agenda-prefix-format
      '((agenda . " %i %-12:c%?-12t% s")
        (todo   . " ")
        (tags   . " %i %-12:c")
        (search . " %i %-12:c")))

(add-to-list 'default-frame-alist '(fullscreen . maximized))
;;(setq fancy-splash-image (seq-random-elt '("~/grub/imagens/snail2.png" "~/grub/imagens/dardo2.png" "~/grub/imagens/frutacomun.png" "~/grub/imagens/sapo.png" "~/grub/imagens/sapo2.png" "~/grub/imagens/cafe2.png")))

;; Pretty org mode https://zzamboni.org/post/beautifying-org-mode-in-emacs/
(defun pretty()
  (let* ((variable-tuple
          (cond
           ((x-list-fonts "ETBembo")         '(:font "ETBembo"))
           (nil (warn "Cannot find a Sans Serif Font.  Install Source Sans Pro."))
           ((x-list-fonts "Iosevka")         '(:font "Iosevka"))
           ((x-list-fonts "Roboto Mono")     '(:font "Roboto Mono"))
           ((x-list-fonts "JetBrains Mono")  '(:font "JetBrains Mono"))
           ((x-list-fonts "Source Sans Pro") '(:font "Source Sans Pro"))
           ((x-list-fonts "Lucida Grande")   '(:font "Lucida Grande"))
           ((x-list-fonts "Verdana")         '(:font "Verdana"))
           ((x-family-fonts "Sans Serif")    '(:family "Sans Serif"))
          ))
         (base-font-color     (face-foreground 'default nil 'default))
         (headline           `(:inherit default :weight bold :foreground ,base-font-color))
         )
    (custom-theme-set-faces
     'user
     `(org-level-8 ((t (,@headline ,@variable-tuple))))
     `(org-level-7 ((t (,@headline ,@variable-tuple))))
     `(org-level-6 ((t (,@headline ,@variable-tuple))))
     `(org-level-5 ((t (,@headline ,@variable-tuple))))
     `(org-level-4 ((t (,@headline ,@variable-tuple :height 1.0))))
     `(org-level-3 ((t (,@headline ,@variable-tuple :height 1.0))))
     `(org-level-2 ((t (,@headline ,@variable-tuple :height 1.05))))
     `(org-level-1 ((t (,@headline ,@variable-tuple :height 1.15))))
     `(org-todo-keyword-active ((t (,@headline ,@variable-tuple :height 0.35))))
     `(org-document-title ((t (,@headline ,@variable-tuple :height 1.5 :underline nil))))))
  ;; (custom-theme-set-faces
  ;;  'user
  ;;  '(variable-pitch ((t (:family "Fira Code Retina" :height 150 :weight thin))))
  ;;  '(fixed-pitch ((t ( :family "ETBembo" :height 160)))))
  ;;(add-hook 'org-mode-hook 'variable-pitch-mode)
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
)
(defun setup-org()
  (setq org-superstar-item-bullet-alist
        '((?* . ?•)
          (?+ . ?➤)
          (?- . ?•)))
  (setq org-superstar-headline-bullets-list '(?\s))
  (setq org-superstar-special-todo-items t)
  (setq org-superstar-remove-leading-stars t)
  ;; Enable custom bullets for TODO items
  (setq org-superstar-todo-bullet-alist
        '(("TODO" . ?➤)
          ("NEXT" . ?☕)
          ("HOLD" . ?✰)
          ("WAIT" . ?⏳)
          ("IDEA" . ?★)
          ("CANCELLED" . ?✘)
          ("DONE" . ?✔)))
  (setq org-superstar-headline-bullets-list '("⬢" "▧" "☭" "ᛜ" "►" "◇"))
  ;;(setq org-superstar-headline-bullets-list '("☭" "▫▧" "◈" "ᛜ" "►" "◇"))◆
  ;; I have removed indentation to make the file look cleaner
  ;; (org-indent-mode -1)
  ;; (setq line-spacing 0.1
  ;;       org-pretty-entities t
  ;;       org-startup-indented t
  ;;       org-adapt-indentation nil)
  (variable-pitch-mode +1)
  (prettify-symbols-mode +1)
  (org-superstar-mode +1)
  (org-superstar-restart)
  (emojify-mode 0)
)
(setq org-ellipsis " ,,,")
;(add-hook 'org-mode-hook 'setup-org)
(add-hook 'org-mode-hook 'pretty)

;; (use-package org-roam
;;   :ensure t
;;   :init (setq org-roam-v2-ack t)
;;   :custom
   (setq org-roam-directory "~/stuff/Notas/roam")
;;   :config (org-roam-setup))

(setq org-roam-dailies-capture-templates
      '(("d" "default" entry "* %? - %<%A %d %R>"
         :if-new (file+head "%<%Y-%m-%d>.org" "#+title: %<%Y-%m-%d>\n"))
        ("h" "jush heading" entry "* %?"
         :if-new (file+head "%<%Y-%m-%d>.org" "#+title: %<%Y-%m-%d>\n"))
        ("t" "todo" entry "* TODO %?"
         :if-new (file+head "%<%Y-%m-%d>.org" "#+title: %<%Y-%m-%d>\n"))
        ("j" "journal" entry "*  [[id:d10cd556-cc88-4393-96d2-11526fa4fcfe][Journal]] - %<%A %d %R> \n  - %?"
         :if-new (file+head "%<%Y-%m-%d>.org" "#+title: %<%Y-%m-%d>\n"))))

(map! :leader
      :desc "vterm" "?" #'vterm)

(map! :leader
      (:prefix-map ("n" . "Org roam")
        :desc "Node find" "f" #'org-roam-node-find
        :desc "Node insert" "i" #'org-roam-node-insert
        :desc "Node immediate insert" "I" #'org-roam-node-insert-immediate
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
        :desc "Calendar"                      "c" #'=calendar
        :desc "Pomodoro"                      "p" #'org-pomodoro

        ;; :desc "42 header"                     "h" #'header-insert
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

(use-package! websocket
    :after org-roam)

(use-package! org-roam-ui
    :after org-roam ;; or :after org
;;         normally we'd recommend hooking orui after org-roam, but since org-roam does not have
;;         a hookable mode anymore, you're advised to pick something yourself
;;         if you don't care about startup time, use
;;  :hook (after-init . org-roam-ui-mode)
    :config
    (setq org-roam-ui-sync-theme t
          org-roam-ui-follow t
          org-roam-ui-update-on-save t
          org-roam-ui-open-on-start t))

;; (defun my/monkeytype-mode-hook ()
;;   "Hooks for monkeytype-mode."
;;   (centered-cursor-mode)
;;   (evil-insert -1))
;; (add-hook 'monkeytype-mode-hook #'my/monkeytype-mode-hook)

;; (after! ccls
;;   (setq ccls-initialization-options '(:index (:comments 2) :completion (:detailedLabel t)))
;;   (set-lsp-priority! 'ccls 2)) ; optional as ccls is the default in Doom

(setq lsp-clients-clangd-args '("-j=3"
                                "--background-index"
                                "--clang-tidy"
                                "--completion-style=detailed"
                                "--header-insertion=never"
                                "--header-insertion-decorators=0"))
(after! lsp-clangd (set-lsp-priority! 'clangd 2))


;(load "~/.doom.d/lisp/header.el")

(add-hook 'window-setup-hook (lambda () (find-file "~/stuff/Notas/roam/20210913110509-home.org")))
(add-hook 'window-setup-hook #'doom/quickload-session)

(setq ranger-show-hidden t)

(after! org-roam (load! "org_roam_custom.el"))

(after! projectile
  (setq projectile-project-root-files-bottom-up '(".projectile" ".project"))
  (setq projectile-project-root-files-top-down-recurring '( ".projectile" ".project")))

