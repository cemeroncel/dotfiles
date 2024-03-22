;;; early-init.el --- Early init configuration-*- lexical-binding: t; -*-

;; Copyright (C) 2024 Cem Eröncel

;; Author: Cem Eröncel
;; Package-Requires: ((emacs "29.2"))

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
;; This file is loaded before the initialization of the package system
;; and the GUI. This means that this file is for customizing the
;; variables related to the package initialization process or drawing
;; the GUI elements.

;;; Code

;;;; Tricks for faster startup
;; Increase the Garbage Collection (GC) threshold
;; temporarly. Following Prot
;; https://github.com/protesilaos/dotfiles/blob/master/emacs/.emacs.d/early-init.el,
;; we save its default value to a variable, and restore it after
;; startup has completed. Prot also does a similar trick for
;; `file-name-handler-alist' and `vc-handled-backends' by setting them
;; to `nil' temporarily. I should check these to see it they make a
;; speed difference.
(defvar ce/gc-cons-threshold gc-cons-threshold
  "Default value of the `gc-cons-threshold'.")
(setq gc-cons-threshold most-positive-fixnum)
(add-hook 'emacs-startup-hook
	  (lambda ()
	    (setq gc-cons-threshold ce/gc-cons-threshold)))

;; By default, resizing a frame rounds it sized to the frame's current
;; values of `frame-char-height' and `frame-char-width'. Setting this
;; to a non-nil value prevents the rounding, so the frame sizes can
;; increase/decrase by one pixel.
(setq frame-resize-pixelwise t)

;; Make the initial buffer load faster by setting its mode to fundamental-mode.
(customize-set-variable 'initial-major-mode 'fundamental-mode)

;; Do not resize the frame at this early stage
(setq frame-inhibit-implied-resize t)

;; Do not use X resources. I still didn't understand what these are
;; but I'm disabling them for now.
(setq inhibit-x-resources t)

;; Inhibits display of buffer list when more than 2 files are loaded.
(setq inhibit-startup-buffer-menu t)

;;;; Removing graphical elements
(setq inhibit-startup-screen t)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(tool-bar-mode -1)

;;;; Native comp settings
(when (featurep 'native-compile)
  ;; Do not report warnings and error from asynchronous native
  ;; compilation. I might turn this on later for debugging purposes.
  (setq native-comp-async-report-warnings-errors nil)
  )

;; Location of the native compilation cache
(when (fboundp 'startup-redirect-eln-cache)
  (startup-redirect-eln-cache
   (convert-standard-filename
    (expand-file-name  "var/eln-cache/" user-emacs-directory))))


;;; early-init.el ends here
