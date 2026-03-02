;;; ce-keybindings.el --- Module that sets up keybindings  -*- lexical-binding: t; -*-

;; Copyright (C) 2025  Cem Eröncel

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

;; Starting with Emacs 30.1, the `which-key' package is included in Emacs.
(which-key-mode)

;; I'm using `C-z' as my leader key. By default, this keybinding is
;; bound to `suspend-frame' function. which I never use. So, I should
;; first disable it.
(keymap-set global-map "C-z" nil)

;; Define the keymaps that will be added to the global prefix map
(defvar-keymap ce/prefix-buffer-map
  :doc "My prefix key for buffer-related functions.")
(defvar-keymap ce/prefix-help-map
  :doc "My prefix key for help-related functions.")
(defvar-keymap ce/prefix-library-map
  :doc "My prefix key for library-related functions.")
(defvar-keymap ce/prefix-notes-map
  :doc "My prefix key for notes-related functions.")
(defvar-keymap ce/prefix-search-map
  :doc "My prefix key for search-related functions.")
(defvar-keymap ce/prefix-toggle-map
  :doc "My prefix key for toggle functions.")


;; Define a global prefix map with commands and nested key maps.
(defvar-keymap ce/global-prefix-map
  :doc "My global prefix map."
  "b" ce/prefix-buffer-map
  "h" ce/prefix-help-map
  "l" ce/prefix-library-map
  "n" ce/prefix-notes-map
  "s" ce/prefix-search-map
  "t" ce/prefix-toggle-map
  )

;; Define how the nested keymaps are labelled in `which-key-mode'.
(which-key-add-keymap-based-replacements ce/global-prefix-map
    "b" `("buffer" . ,ce/prefix-buffer-map)
    "h" `("help" . ,ce/prefix-help-map)
    "l" `("library" . ,ce/prefix-library-map)
    "n" `("notes" . ,ce/prefix-notes-map)
    "s" `("search" . ,ce/prefix-search-map)
    "t" `("toggle" . ,ce/prefix-toggle-map)
    )

;; Bind the global prefix map to a key.
(keymap-set global-map "C-z" ce/global-prefix-map)


(provide 'ce-keybindings)
;;; ce-keybindings.el ends here
