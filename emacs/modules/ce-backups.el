;;; ce-backups.el --- Configuration of the backups module  -*- lexical-binding: t; -*-

;; Copyright (C) 2024 Cem Eröncel

;; Author: Cem Eröncel <cemeroncel@gmail.com>

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

;; This module customizes the backup system.

;;; Code
;; Defining the path to store the backups
(defvar backups-path
  (expand-file-name "backups" user-emacs-directory)
  "The path where the backups are located")

;; Make sure the backups path exists
(unless (file-exists-p backups-path)
  (mkdir backups-path t))

;; Save all backups to the backup path
(setopt backup-directory-alist (list (cons "." backups-path)))

;; Make numeric backup versions
(setopt version-control t)

;; Make backups by copying instead of renaming
(setopt backup-by-copying t)

;; Do not keep all the versions
(setopt delete-old-versions t
        kept-old-versions 5
        kept-new-versions 5)

;;; Auto-save mode
;; This way we have a fallback in case of crashes or lost data. user
;; `recover-file` or `recover-session` to recover them. The following
;; code is adapted from Doom Emacs.
(setopt auto-save-default t)

;; Don't auto-disable auto-save after deleting big chunks. This defeats
;; the purpose of a failsafe. This adds the risk of losing the data we
;; just deleted, but I believe that's VCS's jurisdiction, not ours.
(setq auto-save-include-big-deletions t)

(provide 'ce-backups)
;;; ce-backups.el ends here
