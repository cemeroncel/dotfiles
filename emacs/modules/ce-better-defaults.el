;;; ce-better-defaults.el --- Configuration of defaults module  -*- lexical-binding: t; -*-

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

;; This module modifies some of the built-in variables in Emacs.

;;; Code

;; Revert Dired and other buffers
(setopt global-auto-revert-non-file-buffers t)

;; Revert buffers when the underlying file has changed
(global-auto-revert-mode 1)

;; Activate Delete Selection mode. When this mode is enabled, typed
;; text replaces the selection if the selection is active. Otherwise,
;; typed text is just inserted at point regardless of any selection.
(delete-selection-mode)

;; Use spaces instead of tabs
(setq-default indent-tabs-mode nil)

;; Use "y" and "n" to confirm/negate prompt instead of "yes" and "no"
(setq use-short-answers t)

;; Turn on recentf mode
(add-hook 'after-init-hook #'recentf-mode)

;; Do not save duplicates in kill-ring
(setopt kill-do-not-save-duplicates t)

;; Make scrolling less stuttered
(setq auto-window-vscroll nil)
(setopt fast-but-imprecise-scrolling t)
(setopt scroll-conservatively 101)
(setopt scroll-margin 0)
(setopt scroll-preserve-screen-position t)

;; Better support for files with long lines
(setq-default bidi-paragraph-direction 'left-to-right)
(setq-default bidi-inhibit-bpa t)
(global-so-long-mode 1)

;; Make shebang (#!) file executable when saved
(add-hook 'after-save-hook #'executable-make-buffer-file-executable-if-script-p)

;; Iterate through the CamelCase words
(global-subword-mode 1)

;; Enable some of the disabled commends
(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)

;; Set the default encoding to UTF-8
(set-default-coding-systems 'utf-8)

;; Use visual flash instead of beeping
(setq visible-bell t)

;; Enable line numbers in programming modes
(add-hook 'prog-mode-hook #'display-line-numbers-mode)

;; Enable savehist-mode for command history
(savehist-mode 1)

;; Enable automatic parens pairing
(electric-pair-mode 1)

(provide 'ce-better-defaults)
;;; ce-better-defaults.el ends here
