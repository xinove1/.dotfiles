;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

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
;(setq doom-font (font-spec :family "TamzenForPowerline" :size 20.0))
;(setq doom-font (font-spec :family "trigon8x15r"))
;(setq doom-font (font-spec :family "Tamsyn" ))

(setq doom-font (seq-random-elt '(
                                "JetBrains Mono-13"
                                "Mononoki Nerd Font-13"
                                "Roboto Mono-13"
                                "Hack-13"
                                "Iosevka Term-13"
                                "TamzenForPowerline-15")))

(setq doom-theme (seq-random-elt '(doom-peacock doom-henna doom-horizon doom-laserwave doom-rouge modus-vivendi modus-vivendi-tinted
                                   doom-molokai doom-monokai-pro doom-old-hope doom-gruvbox old-rice-putin)))

(setq org-directory "~/stuff/Notas")

(setq display-line-numbers-type 'relative)

(with-eval-after-load 'evil
    (defalias #'forward-evil-word #'forward-evil-symbol)
    ;; make evil-search-word look for symbol rather than word boundaries
    (setq-default evil-symbol-word-search t))

;; TODO Check if this is really needed
(setq-hook! '(c-mode-hook c++-mode-hook) indent-tabs-mode t)

;; (defun change-kbd-dvorak()
;;   (if (or (eq major-mode 'shell-mode ) (eq major-mode 'vterm-mode ))
;;        (shell-command "setxkbmap br")
;;        ;(shell-command "setxkbmap us -variant colemak_dh")))
;;        (shell-command "setxkbmap dvorak")))

;; I guess this was from tramp shenaniggans
;(setq tmp default-directory)
;(setq default-directory "~/")
;(shell-command "setxkbmap br")
;(setq default-directory tmp)

;; Vterm shell
(setq! vterm-shell "/bin/zsh")

;; TODO Maybe turn back to func and add-hook

(defun t/change-kbd-layout (layout)
  "Runs (shell-command \"setxkbmap <layout>\""
  (shell-command (concat "setxkbmap " layout)))

(add-hook! 'evil-insert-state-entry-hook (t/change-kbd-layout "dvorak"))
(add-hook! 'evil-insert-state-exit-hook (t/change-kbd-layout "br"))

;; config org pomodoro sons 😏
(setq org-pomodoro-finished-sound "~/Music/dogdoin.wav")
(setq org-pomodoro-short-break-sound "~/Music/fart.wav")
;; (setq org-pomodoro-finished-sound-args)

(with-eval-after-load 'org
  (setq org-todo-keywords
        '((sequence "TODO(t)" "DO(T)" "PROJ(p)" "LOOP(r)" "STRT(s)" "WAIT(w)" "HOLD(h)" "IDEA(i)" "|" "DONE(d)" "KILL(k)")
          (sequence "[ ](T)" "[-](S)" "[?](W)" "|" "[X](D)")
          (sequence "|" "OKAY(o)" "YES(y)" "NO(n)"))))


(setq-default org-display-custom-times t)
(setq org-time-stamp-custom-formats '("<%A %e %b %Y>" . "<%A %e %b %Y %H:%M>"))
(setq org-agenda-prefix-format
      '((agenda . " %i %-12:c%?-12t% s")
        (todo   . " ")
        (tags   . " %i %-12:c")
        (search . " %i %-12:c")))

(add-to-list 'default-frame-alist '(fullscreen . maximized))
(setq fancy-splash-image (seq-random-elt '("~/Documents/imagens/snail2.png" "~/Documents/imagens/dardo2.png" "~/Documents/imagens/frutacomun.png" "~/Documents/imagens/sapo.png" "~/Documents/imagens/sapo2.png" "~/Documents/imagens/cafe2.png")))
(remove-hook '+doom-dashboard-functions #'doom-dashboard-widget-shortmenu)
(remove-hook '+doom-dashboard-functions #'doom-dashboard-widget-footer)

(setq org-ellipsis " ,,,")

(setq org-roam-directory "~/stuff/Notas/roam")
(setq org-roam-dailies-capture-templates
      '(("d" "default" entry "* %? - %<%A %d %R>"
         :if-new (file+head "%<%Y-%m-%d>.org" "#+title: %<%Y-%m-%d>\n"))
        ("h" "jush heading" entry "* %?"
         :if-new (file+head "%<%Y-%m-%d>.org" "#+title: %<%Y-%m-%d>\n"))
        ("t" "todo" entry "* TODO %?"
         :if-new (file+head "%<%Y-%m-%d>.org" "#+title: %<%Y-%m-%d>\n"))
        ("j" "journal" entry "*  [[id:d10cd556-cc88-4393-96d2-11526fa4fcfe][Journal]] - %<%A %d %R> \n  - %?"
         :if-new (file+head "%<%Y-%m-%d>.org" "#+title: %<%Y-%m-%d>\n"))))

(map! :map doom-leader-workspace-map
      :desc "Switch workspace" "h" #'+workspace/switch-left
      :desc "Switch workspace" "j" #'+workspace/switch-to-0
      :desc "Switch workspace" "k" #'+workspace/switch-to-1
      :desc "Switch workspace" "l" #'+workspace/switch-right
     ;; :desc "Switch workspace" "TAB" #'+workspace/switch-to
      )

(map! :after rustic
      :map rustic-mode-map
      :localleader
      :desc "Cargo run"           "r" #'rustic-cargo-run
      :desc "Cargo test"          "t" #'rustic-cargo-test
      :desc "Cargo current test"  "T" #'rustic-cargo-current-test)

(map! :leader
      :prefix-map ("d" . "utilites")
      :desc "Display tab bar"           "d" #'+workspace/display
      :desc "Switch workspace"          "h" #'+workspace/other
      :desc "Switch workspace"          "j" #'+workspace/switch-to-0
      :desc "Switch workspace"          "k" #'+workspace/switch-to-1
      :desc "Switch workspace"          "l"  #'+workspace/switch-to-2
      :desc "Switch workspace"          "SPC" #'+workspace/switch-to
      :desc "Switch project"            "p" #'projectile-switch-project
      :desc "Switch to last workspace"  "m"   #'+workspace/other
      :desc "New workspace"             "n"   #'+workspace/new
      :desc "New named workspace"       "N"   #'+workspace/new-named
      :desc "Delete this workspace"     "K"   #'+workspace/delete
      :desc "Rename workspace"          "r"   #'+workspace/rename
      :desc "Switch to 1st workspace"   "1"   #'+workspace/switch-to-0
      :desc "Switch to 2nd workspace"   "2"   #'+workspace/switch-to-1
      :desc "Switch to 3rd workspace"   "3"   #'+workspace/switch-to-2
      :desc "Switch to 4th workspace"   "4"   #'+workspace/switch-to-3
      :desc "Switch to 5th workspace"   "5"   #'+workspace/switch-to-4
      :desc "Switch to 6th workspace"   "6"   #'+workspace/switch-to-5
      :desc "Switch to 7th workspace"   "7"   #'+workspace/switch-to-6
      :desc "Switch to 8th workspace"   "8"   #'+workspace/switch-to-7
      :desc "Switch to 9th workspace"   "9"   #'+workspace/switch-to-8
      :desc "Switch to final workspace" "0"   #'+workspace/switch-to-final
      )

(map! :leader
      :desc "vterm" "?" #'vterm
      :prefix-map ("j" . "utilites")
       :desc "Comment region"          "c" #'comment-region
       :desc "Uncomment region"        "u" #'uncomment-region
       :desc "Format region"           "f" #'+format/region-or-buffer
       :desc "vterm"                   "v" #'vterm
       :desc "Maxize window"           "w" #'doom/window-maximize-buffer
       :desc "Switch project"           "p" #'projectile-switch-project
       )

(map!
      :leader
       :prefix-map ("n" . "Notes")
       :desc "Node find"               "f" #'org-roam-node-find
       :desc "Node insert"             "i" #'org-roam-node-insert
       :desc "Node immediate insert"   "I" #'org-roam-node-insert-immediate
       :desc "Buffer toggle"           "l" #'org-roam-buffer-toggle
       :desc "Org capture finalize"    "s" #'org-capture-finalize
       :desc "Random Todo file"        "R" #'t/random-todo-heading
       :desc "Random Todo agenda"      "r" #'t/random-todo-heading-agenda
       ;:desc "Toggle roam buffer"      "R" #'org-roam-buffer-toggle
       ;:desc "Launch roam buffer"      "R" #'org-roam-buffer-display-dedicated
       :desc "Todo list"               "t" #'my/org-todo-list
       :desc "Do list"                 "d" #'my/org-do-list
       :desc "Org Capture"             "c" #'t/org-roam-capture
       :desc "Calendar"                "C" #'=calendar
       :desc "Pomodoro"                "p" #'org-pomodoro
       ;; :desc "Sync database"              "s" #'org-roam-db-sync
       (:prefix ("D" . "by date")
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
       (:prefix-map ("N" . "notes")
        :desc "Search notes for symbol"      "*" #'+default/search-notes-for-symbol-at-point
        :desc "Org agenda"                   "a" #'org-agenda
        :desc "Toggle last org-clock"        "c" #'+org/toggle-last-clock
        :desc "Cancel current org-clock"     "C" #'org-clock-cancel
        :desc "Open deft"                    "d" #'deft
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
        :desc "Org export to clipboard as RTF" "Y" #'+org/export-to-clipboard-as-rich-text))

(use-package! websocket
    :after org-roam)

(use-package! org-roam-ui
    :after org-roam
    :config
    (setq org-roam-ui-sync-theme t
          org-roam-ui-follow t
          org-roam-ui-update-on-save t
          org-roam-ui-open-on-start t))

(with-eval-after-load 'lsp-clangd
  (setq lsp-clients-clangd-args
        '("-j=3"
          "--background-index"
          "--clang-tidy"
          "--completion-style=detailed"
          "--header-insertion=never"
          "--header-insertion-decorators=0"))
  (set-lsp-priority! 'clangd 2))

;(load "~/.doom.d/lisp/header.el")

;(add-hook 'window-setup-hook (lambda () (find-file "~/stuff/Notas/roam/20210913110509-home.org")))
;(add-hook 'window-setup-hook #'doom/quickload-session)

(defun ranger-hook-config ()
  (setq display-line-numbers-mode t)
  (setq display-line-numbers 'relative))

(setq ranger-show-hidden t)
(add-hook! 'ranger-mode-hook (ranger-hook-config))

(with-eval-after-load 'org (load! "org_roam_custom.el"))
(load! "themes/modus-themes.el")

;; (after! projectile
;;   (setq projectile-project-root-files-bottom-up '(".projectile" ".project"))
;;   (setq projectile-project-root-files-top-down-recurring '( ".projectile" ".project")))

;; (setq evil-vsplit-window-right t
;;       evil-split-window-below t)

;; (defadvice! prompt-for-buffer (&rest _)
;;   :after '(evil-window-split evil-window-vsplit)
;;   (consult-buffer))

;; (set-popup-rules!
;;   '(("^\\*cargo" :side right
;;      :size 80
;;      :select t)
;;     ("^\\*vterm" :side right
;;      :size 80
;;      :select t)
;;     ))

;; (add-hook! 'window-setup-hook
;;   (load! "org_roam_custom.el"))

(set-popup-rules!
    '(("^\\*cargo" :side right
       :size 80
       :select t)))

(with-eval-after-load 'vterm
  (set-popup-rules!
    '(("^\\*vterm" :side right
       :size 80
       :select t))))



;; (after! 'evil
;;   (evil-set-initial-state 'vterm-mode 'insert))

(add-hook! 'vterm-exit-functions (t/change-kbd-layout "br"))

(setq org-agenda-custom-commands
      '(("v" "A better agenda view"
         ((tags "PRIORITY=\"A\""
                ((org-agenda-skip-function '(org-agenda-skip-entry-if 'todo 'done))
                 (org-agenda-overriding-header "High-priority unfinished tasks:")))
          (agenda "")
          (alltodo "")))))

(defun t/random-todo-heading()
  (interactive)
  (org-randomnote--go-to-random-header buffer-file-name "TODO=\"TODO\""))

(defun t/random-todo-heading-agenda()
  (interactive)
    (org-randomnote "TODO=\"TODO\""))

(defun t/org-roam-capture ()
  (interactive)
  (org-roam-capture- :node (org-roam-node-create)
                     :templates '(("n" "inbox note" plain "* [%<%A %d %R>] %?"
                                   :if-new (file+head "Inbox.org" "#+title: Inbox\n"))
                                  ("t" "inbox todo" plain "* TODO %?"
                                   :if-new (file+head "Inbox.org" "#+title: Inbox\n"))
                                  )))
(setq yequake-frames
      '(("Scratch" .
         ((width . 0.75)
          (height . 0.5)
          (alpha . 0.93)
          (buffer-fns . ("*scratch*"))
          (frame-parameters . ((undecorated . t)))))

        ("Todos" .
         ((width . 0.75)
          (height . 0.5)
          (alpha . 0.93)
          (buffer-fns . (my/org-do-list))
          (frame-parameters . ((undecorated . t)))))

        ("Agenda" .
         ((width . 0.75)
          (height . 0.5)
          (alpha . 0.93)
          (buffer-fns . (org-agenda-list))
          (frame-parameters . ((undecorated . t)))))
        ))
