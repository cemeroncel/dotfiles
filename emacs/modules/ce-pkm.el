;;; ce-pkm.el --- Personal Knowledge Management         -*- lexical-binding: t; -*-

;; Copyright (C) 2024  Cem Eröncel

;; Author: Cem Eröncel <cemeroncel@gmail.com>
;; Keywords: 

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.

;;; Commentary:

;; 

;;; Code:

;; Location of the library folder
(defvar ce/bibliography-folder
  ""
  "Path to library folder.")

;; Location of the .bib files
(defvar ce/bibliography-files
  ()
  "List of .bib file location.")

;; Location for the files of the bibliography items
(defvar ce/bibliography-pdfs
  ""
  "Path to the folder where files for the bibliography items are
stored.")

(setq ce/bibliography-folder (expand-file-name "Library" "~/Dropbox"))
(setq ce/bibliography-files `(
                              ,(expand-file-name "library.bib" ce/bibliography-folder)
                              ))
(setq ce/bibliography-pdfs (expand-file-name "pdfs/" ce/bibliography-folder))

;; Citar
(use-package citar
  :ensure t
  ;; Use the `completion-at-point' (capf) functionality in LaTeX and
  ;; Org mode
  :hook
  (LaTeX-mode . citar-capf-setup)
  (org-mode . citar-capf-setup)
  ;; Replace the impossible to remember keybinding for inserting
  ;; citations in Org mode
  :bind
  (
   ("C-c n b" . #'citar-open)
   :map org-mode-map
        ("C-c b" . #'org-cite-insert))
  :custom
  ;; List of the bibliography files
  (citar-bibliography ce/bibliography-files)
  ;; Org-mode related settings
  (org-cite-global-bibliography ce/bibliography-files)
  (org-cite-insert-processor 'citar)
  (org-cite-follow-processor 'citar)
  (org-cite-activate-processor 'citar)
  )

(use-package citar-embark
  :ensure t
  :after (citar embark)
  :no-require
  :config (citar-embark-mode))

;; Emacs interface to inspire
;; https://github.com/Simon-Lin/inspire.el
(use-package inspire
  :ensure t
  :bind ("C-c s i" . inspire-literature-search)
  :custom
  ;; Make display faces use variable fonts
  (inspire-use-variable-pitch nil)
  ;; Not pop up a new frame when initiating a new inspire query
  (inspire-pop-up-new-frame nil)
  ;; Default download folder for papers
  (inspire-default-download-folder ce/bibliography-pdfs)
  ;; Set the master bib file
  (inspire-master-bibliography-file (car ce/bibliography-files))
  ;; Use relative paths for pdf links when exporting bibTeX entries
  (inspire-pdf-use-absolute-path nil)
  )

;; Note taking in Prot's way https://protesilaos.com/emacs/denote 
;; TODO Test the `denote-org-extras-extract-org-subtree' function which is
;; part of the optional `denote-org-extras.el' extension.
(use-package denote
  :ensure t
  :bind (("C-c n n" . denote)
         ("C-c n t" . denote-templates)
         ("C-c n d" . denote-date)
         ("C-c n s" . denote-signature)
         ("C-c n o" . denote-open-or-create))
  :custom
  ;; Set the denote directory
  (denote-directory (expand-file-name "~/Dropbox/Org/Notes"))

  ;; Use the more advanced date selection method of Org mode
  (denote-date-prompt-use-org-read-date t)
  )

;; Use citar and Denote together
(use-package citar-denote
  :ensure t
  :after (citar denote))

(provide 'ce-pkm)
;;; ce-pkm.el ends here
