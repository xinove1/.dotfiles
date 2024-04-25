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
                                  ;"TamzenForPowerline-15"
                                  )))

; TODO different seletction of themes for term mode
(setq doom-theme (seq-random-elt '(doom-horizon modus-vivendi-tinted
                                   doom-peacock doom-henna doom-horizon doom-laserwave doom-rouge modus-vivendi modus-vivendi-tinted
                                   doom-molokai doom-monokai-pro doom-old-hope doom-gruvbox doom-tomorrow-night old-rice-putin
                                   )))

(setq display-line-numbers-type 'relative)
(setq scroll-margin 8)

(defun t/scroll-down-recenter ()
  (interactive)
  (evil-scroll-down 0)
  (evil-scroll-line-to-center nil))

(defun t/scroll-up-recenter ()
  (interactive)
  (evil-scroll-up 0)
  (evil-scroll-line-to-center nil))

(with-eval-after-load 'evil
  (defalias #'forward-evil-word #'forward-evil-symbol)
  ;; make evil-search-word look for symbol rather than word boundaries
  (setq-default evil-symbol-word-search t)
  (define-key evil-normal-state-map (kbd "C-D") 't/scroll-down-recenter)
  (define-key evil-normal-state-map (kbd "C-U") 't/scroll-up-recenter)
  )


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

;; TODO Maybe turn back to not use func
(defun t/change-kbd-layout (layout)
  "Runs (shell-command \"setxkbmap <layout>\""
  (shell-command (concat "setxkbmap " layout)))


(defun set-evil-hooks ()
  (add-hook! 'evil-insert-state-entry-hook (t/change-kbd-layout "us -variant dvorak"))
  (add-hook! 'minibuffer-mode-hook (t/change-kbd-layout "us -variant dvorak"))
  (add-hook! 'minibuffer-exit-hook (t/change-kbd-layout "br"))
  (add-hook! 'evil-insert-state-exit-hook (t/change-kbd-layout "br")))

(add-hook! 'window-setup-hook (set-evil-hooks))

(add-to-list 'default-frame-alist '(fullscreen . maximized))
(setq fancy-splash-image (seq-random-elt '("~/Documents/imagens/snail2.png" "~/Documents/imagens/dardo2.png" "~/Documents/imagens/frutacomun.png" "~/Documents/imagens/sapo.png" "~/Documents/imagens/sapo2.png" "~/Documents/imagens/cafe2.png")))
(remove-hook '+doom-dashboard-functions #'doom-dashboard-widget-shortmenu)
(remove-hook '+doom-dashboard-functions #'doom-dashboard-widget-footer)

(map! :map doom-leader-workspace-map
      :desc "Switch workspace" "h" #'+workspace/switch-left
      :desc "Switch workspace" "j" #'+workspace/switch-to-0
      :desc "Switch workspace" "k" #'+workspace/switch-to-1
      :desc "Switch workspace" "l" #'+workspace/switch-right
      ;; :desc "Switch workspace" "TAB" #'+workspace/switch-to
      )

(setq! sly-command-switch-to-existing-lisp 'always)

(map! :after sly
      :localleader
      :map lisp-mode-map
      :desc "Sly" "l" #'sly)

(map! :after rustic
      :map rustic-mode-map
      :localleader
      :desc "Cargo run"           "r" #'rustic-cargo-run
      :desc "Cargo test"          "t" #'rustic-cargo-test
      :desc "Cargo current test"  "T" #'rustic-cargo-current-test)

(map! :leader
      :prefix-map ("d" . "quick workspaces")
      :desc "Display tab bar"           "d" #'+workspace/display
      :desc "Switch to last workspace"  "h" #'+workspace/other
      :desc "Switch workspace 0"        "j" #'+workspace/switch-to-0
      :desc "Switch workspace 1"        "k" #'+workspace/switch-to-1
      :desc "Switch workspace 2"        "l"  #'+workspace/switch-to-2
      :desc "Switch workspace 3"        "ç"  #'+workspace/switch-to-3
      :desc "Select workspace"          "SPC" #'+workspace/switch-to
      :desc "Switch project"            "p" #'projectile-switch-project
      )

(map!
      ;:desc "open allacrity" "M-w" #'(lambda () (shell-command "tdrop -ar -y 60 -x 5% -w 90% -h 80% -C 'zel a h' alacritty"))
      :leader
      :prefix-map ("j" . "Utilites")
      :desc "Comment region"          "c" #'comment-region
      :desc "Uncomment region"        "u" #'uncomment-region
      :desc "Format region"           "F" #'+format/region-or-buffer
      :desc "vterm open"              "v" #'t/vterm-open
      :desc "vterm send compile"      "s" #'t/vterm-send
      :desc "vterm compile and switch""a" #'t/vterm-send-switch
      :desc "Maxize window"           "w" #'doom/window-maximize-buffer
      :desc "Switch project"          "p" #'projectile-switch-project
      )

;; Harpoon
;; (setq! harpoon-project-package '+workspace-current-name)
(setq! harpoon-project-package 'projectile)
(map! :leader
      :prefix-map ("k" . "Harpoon")
      :desc "Go to file 1" "a" #'harpoon-go-to-1
      :desc "Go to file 2" "s" #'harpoon-go-to-2
      :desc "Go to file 3" "d" #'harpoon-go-to-3
      :desc "Go to file 4" "f" #'harpoon-go-to-4
      :desc "Go to file 5" "q" #'harpoon-go-to-5
      :desc "Go to file 6" "w" #'harpoon-go-to-6
      :desc "Go to file 7" "e" #'harpoon-go-to-7
      :desc "Go to file 8" "r" #'harpoon-go-to-8
      :desc "Open Menu" "SPC" #'harpoon-toggle-quick-menu
      :desc "Open Harpoon File" "k" #'harpoon-toggle-file
      :desc "Delete some harpoon" "x" #'harpoon-delete-item
      :desc "Clear Harpoon" "c" #'harpoon-clear
      :desc "Save Current File to Harpoon" "j" #'harpoon-add-file
      )

(map!
 :leader
 :prefix-map ("n" . "Notes")
 :desc "Node find"               "f" #'org-roam-node-find
 :desc "Node insert"             "i" #'org-roam-node-insert
 :desc "Node immediate insert"   "I" #'org-roam-node-insert-immediate
 :desc "Buffer toggle"           "l" #'org-roam-buffer-toggle
 :desc "Org capture finalize"    "S" #'org-capture-finalize
 ;:desc "Org capture finalize"    "s" #'t/org-roam-rg-search
 :desc "Random org heading"        "R" #'t/random-heading
 :desc "Random Todo agenda"      "r" #'t/random-todo-heading-agenda
                                        ;:desc "Toggle roam buffer"      "R" #'org-roam-buffer-toggle
                                        ;:desc "Launch roam buffer"      "R" #'org-roam-buffer-display-dedicated
 :desc "Org Agenda"              "a" #'org-agenda
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
     :select t
     :ttl nil)
    ;; ("^\\*t/vterm" :side right
    ;;  :size 80
    ;;  :select t
    ;;  :ttl nil
    ;;  :quit 'other)
    ))

(with-eval-after-load 'vterm
  (set-popup-rules!
    '(("^\\*vterm" :side right
       :size 80
       :select t
       :ttl nil
       :quit 'other))))



;; (after! 'evil
;;   (evil-set-initial-state 'vterm-mode 'insert))

(add-hook! 'vterm-exit-functions (t/change-kbd-layout "br"))


(setq t/vterm-before nil)

(defun t/new-or-existing-vterm (buffer-name)
  "Open an existing buffer or create one with the BUFFER-NAME given."
  (or (get-buffer buffer-name) (vterm buffer-name)))

(defun t/vterm-open ()
  (interactive)
  (if t/vterm-before
    (progn (switch-to-buffer t/vterm-before)
           (setq t/vterm-before nil))
    (progn (setq t/vterm-before (buffer-name))
           (switch-to-buffer (t/new-or-existing-vterm (concat "t/vterm" (+workspace-current-name)))))
     ))

;; NOTE exemple of spawning or switching to vterm buffer and entering a command
(defun t/vterm-send-command (command)
  "Sends COMMAND to a REPL running in vterm."
  (vterm-send-string command)
  (vterm-send-return))

(defun t/vterm-compile (command)
  (setq-local compile-command command)
  (t/vterm-send-command command))

(defun t/vterm-send ()
  (interactive)
  (with-current-buffer (t/new-or-existing-vterm (concat "t/vterm" (+workspace-current-name)))
    (t/vterm-compile (compilation-read-command compile-command))))

(defun t/vterm-send-switch ()
  (interactive)
  (setq! t/vterm-buff (t/new-or-existing-vterm (concat "t/vterm" (+workspace-current-name))))
  (switch-to-buffer t/vterm-buff)
  (t/vterm-compile (compilation-read-command compile-command)))

;; (setq yequake-frames
;;       '(("Scratch" .
;;          ((width . 0.75)
;;           (height . 0.5)
;;           (alpha . 0.93)
;;           (buffer-fns . ("*scratch*")) ; TODO See if i can enter already in insert mode
;;           (frame-parameters . ((undecorated . t)))))

;;         ("Todos" .
;;          ((width . 0.75)
;;           (height . 0.5)
;;           (alpha . 0.93)
;;           (buffer-fns . (my/org-do-list))
;;           (frame-parameters . ((undecorated . t)))))

;;         ("Agenda" .
;;          ((width . 0.75)
;;           (height . 0.5)
;;           (alpha . 0.93)
;;           (buffer-fns . (org-agenda-list))
;;           (frame-parameters . ((undecorated . t)))))
;;         ("godot" .
;;          ((width . 0.75)
;;           (height . 0.5)
;;           (alpha . 1.00)
;;           (buffer-fns (projectile-switch-project-by-name "galaxy-defience"))
;;           (frame-parameters . ((undecorated . t)))))
;;         ))

(setq lsp-zig-zls-executable "~/stuff/zls/zig-out/bin/zls")

(with-eval-after-load  'sly
 (setq sly-complete-symbol-function 'sly-flex-completions)
 (set-popup-rule! "^\\*sly-mrepl"
   :side 'right
   :with 100
   :select t
   :quit nil
   )
 (set-popup-rule! "^\\*sly-inspector"
   ;; :side 'bottom
   ;; :height 50
   ;; :select t
   ;; :quit t
   :ignore t
   )
 )

(require 'golden)
(global-golden-mode 1)

(require 'vertico-posframe)
(vertico-posframe-mode 1)
(setq vertico-posframe-parameters
      '((left-fringe . 8)
        (right-fringe . 8)))
