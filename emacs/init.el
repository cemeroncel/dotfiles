;;; init.el --- Main init file -*- lexical-binding: t; -*-

;; Copyright (C) 2024 Cem Eröncel

;; Author: Cem Eröncel
;; Version: 0.1.0
;; Package-Requires: ((emacs "29.1"))

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

;;;; Personal information
;; use name and e-mail address
(setq user-full-name "Cem Eröncel"
      user-mail-address "cemeroncel@gmail.com")

;;;; Package archives
;; Starting from Emacs 28.1, gnu elpa and nongnu elpa are included in
;; the `package-archives' list by default. We only need to add melpa
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)

;; Set the preferred channels to download the packages. 
(setopt package-archive-priorities '(
				     ("gnu" . 99)
				     ("nongnu" . 80)
				     ("melpa" . 70)
				     ))

;;;; Custom file
;; Save customizations to an external file instead of init.el. Do not
;; load this file so our configuration becomes the only source of
;; truth.
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))

;; If we decide to load this file, we load it early so that any
;; customization we state in our configuration can override what's in
;; the custom.el file, but at the same time the customizations that we
;; miss in our configuration are loaded as well.

;; (when (and custom-file
;; 	   (file-exists-p custom-file))
;;   (load custom-file nil 'nomessage))


;;;; Font configuration

;; Setting the font height
(defvar ce/font-height 130
  "Font height that will be passed to `set-face-attribute'.")

(when (string-equal (system-name) "titus")
  (setq ce/font-height 140))

(when (string-equal (system-name) "universalis")
  (setq ce/font-height 130))

;; Setting the mono-spaced typeface
(defvar ce/mono-spaced-font "Iosevka Curly"
  "Font family that will be passed to `default' and `fixed-pitch'
face attributes.")

(when (string-equal (system-name) "universalis")
  (setq ce/mono-spaced-font "Iosevka Curly"))

(when (string-equal (system-name) "tuxedus")
  (setq ce/mono-spaced-font "Iosevka Comfy"))

;; (when (string-equal (system-name) "titus")
;;   (setq ce/mono-spaced-font "Cascadia Code"))

;; Setting the proportionally-spaced typeface
(defvar ce/variable-spaced-font "Iosevka Etoile"
  "Font family that will be passed to `variable-pitch' face attribute.")

(when (string-equal (system-name) "universalis")
  (setq ce/variable-spaced-font "Iosevka Etoile"))

(when (string-equal (system-name) "tuxedus")
  (setq ce/variable-spaced-font "Iosevka Comfy Duo"))

(when (string-equal (system-name) "titus")
  (setq ce/variable-spaced-font "Iosevka Etoile"))

;; Typefaces
(set-face-attribute 'default nil :family ce/mono-spaced-font :height ce/font-height)
(set-face-attribute 'variable-pitch nil :family ce/variable-spaced-font :height ce/font-height)
(set-face-attribute 'fixed-pitch nil :family (face-attribute 'default :family))

;;;; Custom modules
;; Define a variable for the custom modules and add them to the `load-path'
(defvar ce/modules-directory (expand-file-name "modules/" user-emacs-directory)
  "The directory that store custom lisp modules.")
(add-to-list 'load-path ce/modules-directory)



;; Load the custom modules
(require 'ce-backups)                   ; sane defaults for backups
(require 'ce-better-defaults)           ; better defaults for Emacs
(require 'ce-biblio)                    ; bibliography management
(require 'ce-completion)                ; modern completion mechanism
(require 'ce-help)                      ; more helpful help buffers
(require 'ce-ide)                       ; Turn Emacs into an IDE for all languages
(require 'ce-lang-julia)                ; Julia configuration
(require 'ce-lang-jupyter)              ; Who needs JupyterLab?
(require 'ce-lang-python)               ; Python configuration
(require 'ce-latex)                     ; For doing science
(require 'ce-org)                       ; Organize your life in plain text
(require 'ce-pdf)                       ; Read PDFs from Emacs
(require 'ce-prose)                     ; Better editing experience for prose
(require 'ce-pkm)                       ; Personal knowledge management
(require 'ce-ui)                        ; theming and user interface
(require 'ce-vc)                        ; version control
(require 'ce-vterm)                     ; Proper terminal emulation

;;; init.el ends here
