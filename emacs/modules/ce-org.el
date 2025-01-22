;;; ce-org.el --- Org-mode configuration -*- lexical-binding: t; -*-

;; Copyright (C) 2022 Cem Eröncel

;; Author: Cem Eröncel <cemeroncel@gmail.com>
;; Created: 29 Oct 2022
;; URL:

;; This file is NOT part of GNU Emacs.

;; This program is free software: you can redistribute it and/or
;; modify it under the terms of the GNU General Public License as
;; published by the Free Software Foundation, either version 3 of the
;; License, or (at your option) any later
;;
;; This program is distributed in the hope that it will be useful, but
;; WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
;; General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program. If not, see <https://www.gnu.org/licenses/>.

;;; Commentary

;;; Code

;; Automatically save files after org-refile
;; https://github.com/rougier/emacs-gtd/issues/9

;; Save the corresponding buffers
(defun ce/gtd-save-org-buffers ()
  "Save `org-agenda-files' buffers without user confirmation.
See also `org-save-all-org-buffers'"
  (interactive)
  (message "Saving org-agenda-files buffers...")
  (save-some-buffers t (lambda () 
			 (when (member (buffer-file-name) org-agenda-files) 
			   t)))
  (message "Saving org-agenda-files buffers... done"))

;; Add it after refile
(advice-add 'org-refile :after
	    (lambda (&rest _)
	      (ce/gtd-save-org-buffers)))

;; Make invisible parts of Org elements appear visible.
(use-package org-appear
  :ensure t
  :hook org-mode
  :custom
  (org-appear-autolinks t "Automatic toggling of links.")
  (org-appear-autosubmarkers t "Toggle subscript and superscripts.")
  (org-appear-autoentities t "Toggle Org entities.")
  (org-appear-autokeywords t "Toggle keywords in `org-hidden-keywords'")
  (org-appear-inside-latex t "Toggle entities and sub/super subscripts in LaTeX fragments.")
  )

;; Org directory
(defvar ce/org-directory
  (expand-file-name "~/Dropbox/zettelkasten")
  "Path to Org directory.")

;; Plain Org
(use-package org
  :hook (org-mode . visual-line-mode)
  :bind (("C-c c" . org-capture)
         ("C-c o a" . org-agenda))
  :custom
  ;; Return or left-clock with mouse follows link
  (org-return-follows-link t)
  (org-mouse-1-follows-link t)
  ;; Show pretty entities
  (org-pretty-entities t)
  ;; Hide the emphasis markers
  (org-hide-emphasis-markers t)
  ;; Start the org modes indented
  (org-startup-indented t)
  ;; Set the `org-directory'
  (org-directory ce/org-directory)
  ;; Fontify quote/verse blocks
  (org-fontify-quote-and-verse-blocks t)
  ;; Highlight LaTeX fragments
  (org-highlight-latex-and-related '(native))
  ;; Interpret `_' and `^' for display
  (org-use-sub-superscripts t)
  ;; Preview of the LaTeX fragments
  (org-format-latex-options '(
                              :foreground default
                              :background default
                              :scale 1.5
                              :html-foreground "Black"
                              :html-background "Transparent"
                              :html-scale 1.0
                              :matchers ("begin" "$1" "$" "$$" "\\(" "\\[")))
  ;; Record when the task is moved to the DONE state
  (org-log-done t)
  ;; TODO keywords
  (org-todo-keywords '((sequence "NEXT(n)"
                                 "TODO(t)"
                                 "PROJ(p)"
                                 "WAIT(w@)"
                                 "HOLD(h)"
                                 "|"
                                 "DONE(d!)"
                                 "CANCELED(c@)")))
  ;; Faces for the TODO keywords
  (org-todo-keyword-faces '(("NEXT" . org-todo)
                            ("TODO" . org-todo)
                            ("PROJ" . org-tag-group)
                            ("WAIT" . org-warning)
                            ("HOLD" . org-warning)
                            ("CANCELED" . gnus-summary-cancelled)))
  ;; TODO: Capture templates
  ;; Refile targets
  (org-refile-targets '(
                        (nil . (:level . 1))
                        ("tasks.org" :level . 1)))
  ;; Agenda files
  (org-agenda-files (list
                     (expand-file-name "Tasks/projects.org" org-directory)
                     (expand-file-name "Tasks/tasks.org" org-directory)
                     ))
  ;; Include entries from the Emacs diary into Org mode's agenda
  (org-agenda-include-diary t)
  ;; Use tag inheritance but exclude some of the tags
  (org-use-tag-inheritance t)
  (org-tags-exclude-from-inheritance '("active"))
  ;; Get the image with from the attributes
  (org-image-actual-width nil)
  ;; Do not align tags
  (org-auto-align-tags nil)
  (org-tags-column nil)
  ;; Org-agenda views
  (org-agenda-custom-commands '(
                                ("d" "Daily view"
                                 (
                                  (agenda ""
                                          (
                                           (org-agenda-block-separator " ")
                                           (org-agenda-overriding-header "📅 Today's agenda\n")
                                           (org-agenda-span 1)
                                           ))
                                 )
                                 )
                                ("n" "Next action list"
                                 (
                                  (tags-todo "deep/NEXT"
                                             (
                                              (org-agenda-overriding-header "🍵 Deep work\n")
                                              )
                                             )
                                  (tags-todo "shallow/NEXT"
                                             (
                                              (org-agenda-overriding-header "🍺 Shallow work\n")
                                              )
                                             )
                                  ))
                                ("p" "Project list"
                                 (
                                  (tags-todo "active/PROJ"
                                             (
                                              (org-agenda-overriding-header "🔥 Active projects\n")
                                              (org-agenda-remove-tags t)
                                              (org-agenda-prefix-format " ")
                                              )
                                             )
                                  (tags-todo "waiting/PROJ"
                                             (
                                              (org-agenda-overriding-header "🚏 Projects in waiting\n")
                                              (org-agenda-remove-tags t)
                                              (org-agenda-prefix-format " ")
                                              )
                                             )
                                  (tags-todo "backburner/PROJ"
                                             (
                                              (org-agenda-overriding-header "🧊 Projects in backburner\n")
                                              (org-agenda-remove-tags t)
                                              (org-agenda-prefix-format " ")
                                              )
                                             )
                                  ))
                                ))
  ;; Set a default target file for notes
  (org-default-notes-file (concat org-directory "/inbox.org"))
  ;; Org capture templates
  (org-capture-templates '(
                           ("n" "Generic note" entry (file "") "* %?\n %i\n Entered on %U" :empty-lines 1)))
  :config
  ;; Activate CDLaTeX
  (add-hook 'org-mode-hook #'turn-on-org-cdlatex)

  ;; Add new items to `org-structure-template-alist'
  (add-to-list 'org-structure-template-alist
               '("d" . "definition"))

  ;; Enable additional Org modules
  ;; (add-to-list 'org-modules 'habit)

  ;; Org babel languages for `emacs-jupyter'
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((emacs-lisp . t)
     (julia . t)
     (python . t)
     (jupyter . t)))

  ;; Default configuration for some Org babel languages
  (setq org-babel-default-header-args:jupyter-julia '((:async . "yes")
                                                      (:session . "jl")
                                                      (:kernel . "julia-1.10")))
  )




;;;; Org-pomodoro
(use-package org-pomodoro
  :after org
  :ensure t
  :commands (org-pomodoro)
  :custom
  (org-pomodoro-length 50)
  (org-pomodoro-short-break-length 10)
  (org-pomodoro-finished-sound-p t)
  )

;;;; org-fragtog
;; Automatically toggle Org model LaTeX fragment previews as the
;; cursor enters and exists them.
;; https://github.com/io12/org-fragtog
(use-package org-fragtog
  :after org
  :commands (org-fragtog-mode)
  )

;;;; org-download
;; Easily insert images to Org files
;; https://github.com/abo-abo/org-download
(use-package org-download
  :ensure t
  :after org
  :custom
  (org-download-method 'directory)
  :config
  (setq-default org-download-image-dir (expand-file-name "Attachments" ce/org-directory)))


(provide 'ce-org)
;;; ce-org.el ends here

