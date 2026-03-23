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

;; Location for the files of the article bibliography items
(defvar ce/bibliography-article-pdfs
  ""
  "Path to the folder where files for the article bibliography items
are stored.")

;; Location for the files of the book bibliography items
(defvar ce/bibliography-book-pdfs
  ""
  "Path to the folder where files for the book bibliography items
are stored.")

(setq ce/bibliography-folder (expand-file-name "Library" "~/Nextcloud"))
(setq ce/bibliography-files `(
                              ,(expand-file-name "articles.bib" ce/bibliography-folder)                              
                              ,(expand-file-name "zotero.bib" ce/bibliography-folder)
                              ))
(setq ce/bibliography-article-pdfs
      (expand-file-name "pdfs_articles/" ce/bibliography-folder))
(setq ce/bibliography-book-pdfs
      (expand-file-name "pdfs_books/" ce/bibliography-folder))


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
   :map org-mode-map :package org
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
  (inspire-use-variable-pitch t)
  ;; Not pop up a new frame when initiating a new inspire query
  (inspire-pop-up-new-frame nil)
  ;; Default download folder for papers
  (inspire-default-download-folder ce/bibliography-article-pdfs)
  ;; Set the master bib file
  (inspire-master-bibliography-file (car ce/bibliography-files))
  ;; Use relative paths for pdf links when exporting bibTeX entries
  (inspire-pdf-use-absolute-path nil)
  )

;;;; Denote

;; Note taking in Prot's way https://protesilaos.com/emacs/denote 
;; TODO Test the `denote-org-extras-extract-org-subtree' function which is
;; part of the optional `denote-org-extras.el' extension.
(use-package denote
  :ensure t
  :bind (("C-c n n" . denote)
         ("C-c n t" . denote-templates)
         ("C-c n d" . denote-date)
         ("C-c n s" . denote-signature)
         ("C-c n o" . denote-open-or-create)
         ("C-c n j" . denote-journal-extras-new-or-existing-entry)
         :map ce/prefix-notes-map
         ("n" . denote)
         ("t" . denote-templates)
         ("d" . denote-date)
         ("s" . denote-signature)
         ("o" . denote-open-or-create)
         ("j" . denote-journal-extras-new-or-existing-entry)
         )
  :hook (dired-mode . denote-dired-mode)
  :custom
  ;; Set the denote directory
  (denote-directory (expand-file-name "~/Nextcloud/Org/Notes"))

  ;; Use the more advanced date selection method of Org mode
  (denote-date-prompt-use-org-read-date t)

  ;; Format for the Denote buffer names
  (denote-rename-buffer-format "%D [%k] %b")
  :config
  (denote-rename-buffer-mode 1)
  )

(use-package denote-org
  :ensure t
  :after denote
  :commands
  ;; I list the commands here so that you can discover them more
  ;; easily.  You might want to bind the most frequently used ones to
  ;; the `org-mode-map'.
  ( denote-org-link-to-heading
    denote-org-backlinks-for-heading

    denote-org-extract-org-subtree

    denote-org-convert-links-to-file-type
    denote-org-convert-links-to-denote-type

    denote-org-dblock-insert-files
    denote-org-dblock-insert-links
    denote-org-dblock-insert-backlinks
    denote-org-dblock-insert-missing-links
    denote-org-dblock-insert-files-as-headings)
  )

;;;; citar denote

;; Use citar and Denote together
(use-package citar-denote
  :ensure t
  :demand t
  :after (:any citar denote)
  :init
  (citar-denote-mode)
  :custom
  ;; Use citekey as the title of the note
  (citar-denote-title-format nil)
  )

;;;; arxiv-mode

;; Check arXiv (https://arxiv.org/) from Emacs
;; https://github.com/fizban007/arxiv-mode
(use-package arxiv-mode
  :ensure t
  :hook ((arxiv-abstract-mode arxiv-mode) . #'turn-on-visual-line-mode)
  :bind (:map ce/prefix-library-map
              ("a" . arxiv-read-new))
  :custom
  ;; Use variable pitch fonts in `arxiv-mode' buffers.
  (arxiv-use-variable-pitch t)
  ;; Where to store the PDFs?
  (arxiv-default-download-folder (expand-file-name "~/Nextcloud/Library/arxiv/"))
  (arxiv-default-bibliography (expand-file-name "~/Nextcloud/Library/arxiv.el"))
  )

(provide 'ce-pkm)
;;; ce-pkm.el ends here
