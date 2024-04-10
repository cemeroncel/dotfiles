;;; ce-biblio.el --- Bibliography management         -*- lexical-binding: t; -*-

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
  (expand-file-name "Library" "~/Documents")
  "Path to library folder.")

;; Location of the .bib files
(defvar ce/bibliography-files
  `(
    ,(expand-file-name "library.bib" ce/bibliography-folder)
    )
  "List of .bib file location.")

;; Location for the files of the bibliography items
(defvar ce/bibliography-pdfs
  (expand-file-name "pdfs/" ce/bibliography-folder)
  "Path to the folder where files for the bibliography items are
stored.")

;; Emacs interface to inspire
;; https://github.com/Simon-Lin/inspire.el
(use-package inspire
  :ensure t
  :custom
  ;; Make display faces use variable fonts
  (inspire-use-variable-pitch nil)
  ;; Not pop up a new frame when initiating a new inspire query
  (inspire-pop-up-new-frame nil)
  ;; Default download folder for papers
  (inspire-default-download-folder ce/bibliography-pdfs)
  ;; Set the master bib file
  (inspire-master-bibliography-file (car ce/bibliography-files))
  ;; Use absolute paths for pdf links when exporting bibTeX entries
  (inspire-pdf-use-absolute-path t)
  )



(provide 'ce-biblio)
;;; ce-biblio.el ends here
