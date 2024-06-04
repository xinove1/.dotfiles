;;;  -*- lexical-binding: t; -*-
;;;
(require 'org-roam-export)
(setq org-html-preamble "---\n---")
(setq org-publish-project-alist
      '(
        ("org-site"
         ;; Path to your org files.
         :base-directory "~/stuff/Notas/roam/site/"
         :base-extension "org"

         ;; Path to your Jekyll project.
         :publishing-directory "~/stuff/xinove1.github.io/"
         :recursive t
         ;:publishing-function org-html-publish-to-html
         :publishing-function org-md-publish-to-md
         :headline-levels 4
         :html-extension "html"
         :body-only t ;; Only export section between <body> </body>
         )

        ("org-site-assets"
         :base-directory "~/stuff/Notas/roam/site/"
         :base-extension "yml\\|css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|ogg\\|swf\\|php"
         :publishing-directory "~/stuff/xinove1.github.io/"
         :recursive t
         :publishing-function org-publish-attachment)

        ("site" :components ("org-site" "org-site-assets"))
        ))

(defun t/org-roam-capture ()
  (interactive)
  (org-roam-capture- :node (org-roam-node-create)
                     :templates '(
                                  ("d" "default" plain "%?"
                                   :target (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n")
                                   :unnarrowed t)
                                  ("b" "blog post" plain "%?"
                                   :if-new (file+head "site/_posts/%<%Y-%m-%d>-%(my/generate-name).org"
                                                      "%(format \"#+title: %s\" my-org-note-name)\n #+filetags: site blog\n"))
                                  ("w" "site page" plain "%?"
                                   :if-new (file+head "site/%(my/generate-name).org"
                                                      "%(format \"#+title: %s\" my-org-note-name)\n #+filetags: site\n"))
                                  )))


(defun my/find-site-nodes ()
  (interactive)

)

(defun my/find-site-nodes (&optional other-window initial-input pred)
  (interactive current-prefix-arg)
  (let ((node (org-roam-node-read initial-input (lambda (node) (member "site" (org-roam-node-tags node)))  pred)))
    (if (org-roam-node-file node)
        (org-roam-node-visit node other-window)
      (org-roam-capture-
       :node node
       :templates '(("d" "default" plain "%?"
                     :target (file+head "site/posts/%<%Y%m%d>-${slug}.org" "#+title: ${title}\n")
                     :unnarrowed t))
       :props '(:finalize find-file)))))

(defun my/generate-name ()
  (setq my-org-note-name (read-string "Name: "))
  my-org-note-name)

; https://github.com/org-roam/org-roam/issues/1633
(remove-hook 'calendar-today-visible-hook #'org-roam-dailies-calendar-mark-entries)

(setq org-directory "~/stuff/Notas")
;; config org pomodoro sons 😏
(setq org-pomodoro-finished-sound "~/Music/dogdoin.wav")
(setq org-pomodoro-short-break-sound "~/Music/fart.wav")
;; (setq org-pomodoro-finished-sound-args)

(with-eval-after-load 'org
  (setq org-todo-keywords
        '((sequence "TODO(t)" "NEXT(n)" "PROJ(p)" "LOOP(r)" "STRT(s)" "WAIT(w)" "HOLD(h)" "IDEA(i)" "|" "DONE(d)" "KILL(k)")
          (sequence "[ ](T)" "[-](S)" "[?](W)" "|" "[X](D)")
          (sequence "|" "OKAY(o)" "YES(y)" "NO(N)"))))

(setq-default org-display-custom-times t)
(setq org-time-stamp-custom-formats '("<%A %e %b %Y>" . "<%A %e %b %Y %H:%M>"))
(setq org-agenda-prefix-format
      '((agenda . " %i %-12:c%?-12t ")
        (todo   . " %i %9:c ")
        (tags   . " %i")
        (search . " %i %-12:c")))

(setq org-ellipsis " ,,,")

(setq org-roam-directory "/home/xinove/stuff/Notas/roam")
(setq org-roam-dailies-capture-templates
      '(("d" "default" entry "* %? - %<%A %d %R>"
         :if-new (file+head "%<%Y-%m-%d>.org" "#+title: %<%Y-%m-%d>\n"))
        ("h" "jush heading" entry "* %?"
         :if-new (file+head "%<%Y-%m-%d>.org" "#+title: %<%Y-%m-%d>\n"))
        ("t" "todo" entry "* TODO %?"
         :if-new (file+head "%<%Y-%m-%d>.org" "#+title: %<%Y-%m-%d>\n"))
        ("j" "journal" entry "*  [[id:d10cd556-cc88-4393-96d2-11526fa4fcfe][Journal]] - %<%A %d %R> \n  - %?"
         :if-new (file+head "%<%Y-%m-%d>.org" "#+title: %<%Y-%m-%d>\n"))))


(setq org-agenda-show-future-repeats nil)

(setq org-agenda-custom-commands
      '(("v" "A better agenda view"
         ((tags "PRIORITY=\"A\""
                ((org-agenda-skip-function '(org-agenda-skip-entry-if 'todo 'done))
                 (org-agenda-overriding-header "High-priority unfinished tasks:")))
          (agenda "" (org-agenda-day-view))
          (alltodo "")))
        ("d" "Agenda view"
         ((todo "NEXT"
                ((org-agenda-skip-function '(org-agenda-skip-entry-if 'todo 'done))
                 (org-agenda-skip-function '(org-agenda-skip-entry-if 'scheduled))
                 (org-agenda-overriding-header "Next unscheduled tasks")
                 ))
          (agenda "" ((org-agenda-span 2)
                      (org-agenda-start-day "0d")
                      (org-deadline-warning-days 5)
                      (org-scheduled-past-days 5)
                      (org-use-tag-inheritance nil)
                      (org-agenda-block-separator nil)
                      ;(org-agenda-day-face-function (lambda (date) 'org-agenda-date))
                      (org-agenda-format-date "%A %-e %B %Y")
                      (org-agenda-overriding-header " ")))
          (alltodo "" ((org-agenda-block-separator nil)
                       (org-agenda-overriding-header "\nAll Todos")
                       ))))))

(defun t/random-heading()
  (interactive)
  (org-randomnote--go-to-random-header buffer-file-name "*"))

(defun t/random-todo-heading-agenda()
  (interactive)
  (org-randomnote "TODO=\"TODO\""))

;; (defun t/org-roam-rg-search ()
;;   "Search org-roam directory using consult-ripgrep. With live-preview."
;;   (interactive)
;;   (let ((consult-ripgrep-command "rg --null --ignore-case --type org --line-buffered --color=always --max-columns=500 --no-heading --line-number . -e ARG OPTS"))
;;     (consult-ripgrep org-roam-directory)))

;;; org roam

(defun my/org-todo-list ()
  (interactive)
  (org-todo-list "TODO"))

(defun my/org-do-list ()
  (interactive)
  (org-todo-list "NEXT"))

;; (defun org-roam-node-insert-immediate (arg &rest args)
;;   (interactive "P")
;;   (let ((args (push arg args))
;;         (org-roam-capture-templates (list (append (car org-roam-capture-templates)
;;                                                   '(:immediate-finish t)))))
;;     (apply #'org-roam-node-insert args)))

(defun my/org-roam-filter-by-tag (tag-name)
  (lambda (node)
    (member tag-name (org-roam-node-tags node))))

(defun my/org-roam-list-notes-by-tag (tag-name)
  (mapcar #'org-roam-node-file
          (seq-filter
           (my/org-roam-filter-by-tag tag-name)
           (org-roam-node-list))))

(defun my/org-roam-refresh-agenda-list ()
  (interactive)
  (setq org-agenda-files (my/org-roam-list-notes-by-tag "Agenda")))

;; Build the agenda list the first time for the session
(my/org-roam-refresh-agenda-list)

;; (defun my/org-roam-project-finalize-hook ()
;;   "Adds the captured project file to `org-agenda-files' if the
;; capture was not aborted."
;;   ;; Remove the hook since it was added temporarily
;;   (remove-hook 'org-capture-after-finalize-hook #'my/org-roam-project-finalize-hook)

;;   ;; Add project file to the agenda list if the capture was confirmed
;;   (unless org-note-abort
;;     (with-current-buffer (org-capture-get :buffer)
;;       (add-to-list 'org-agenda-files (buffer-file-name)))))

;; (defun my/org-roam-find-project ()
;;   (interactive)
;;   ;; Add the project file to the agenda after capture is finished
;;   (add-hook 'org-capture-after-finalize-hook #'my/org-roam-project-finalize-hook)

;;   ;; Select a project file to open, creating it if necessary
;;   (org-roam-node-find
;;    nil
;;    nil
;;    (my/org-roam-filter-by-tag "Projects")
;;    :templates
;;    '(("p" "project" plain "* Goals\n\n%?\n\n* Tasks\n\n** TODO Add initial tasks\n\n* Dates\n\n"
;;       :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n#+category: ${title}\n#+filetags: Projects")
;;       :unnarrowed t))))

;; (defun my/org-roam-capture-task ()
;;   (interactive)
;;   ;; Add the project file to the agenda after capture is finished
;;   (add-hook 'org-capture-after-finalize-hook #'my/org-roam-project-finalize-hook)

;;   ;; Capture the new task, creating the project file if necessary
;;   (org-roam-capture- :node (org-roam-node-read
;;                             nil
;;                             (my/org-roam-filter-by-tag "Projects"))
;;                      :templates '(("p" "project" plain "** TODO %?"
;;                                    :if-new (file+head+olp "%<%Y%m%d%H%M%S>-${slug}.org"
;;                                                           "#+title: ${title}\n#+category: ${title}\n#+filetags: Projects"
;;                                                           ("Tasks"))))))

;; (defun my/org-roam-copy-todo-to-today ()
;;   (interactive)
;;   (let ((org-refile-keep t) ;; Set this to nil to delete the original!
;;         (org-roam-dailies-capture-templates
;;          '(("t" "tasks" entry "%?"
;;             :if-new (file+head+olp "%<%Y-%m-%d>.org" "#+title: %<%Y-%m-%d>\n" ("Tasks")))))
;;         (org-after-refile-insert-hook #'save-buffer)
;;         today-file
;;         pos)
;;     (save-window-excursion
;;       (org-roam-dailies--capture (current-time) t)
;;       (setq today-file (buffer-file-name))
;;       (setq pos (point)))

;;     ;; Only refile if the target file is different than the current file
;;     (unless (equal (file-truename today-file)
;;                    (file-truename (buffer-file-name)))
;;       (org-refile nil nil (list "Tasks" today-file nil pos)))))

;; (add-to-list 'org-after-todo-state-change-hook
;;              (lambda ()
;;                (when (equal org-state "DONE")
;;                  (my/org-roam-copy-todo-to-today))))
