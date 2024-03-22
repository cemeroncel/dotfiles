;;; ce-ui.el --- Configuration for the UI module  -*- lexical-binding: t; -*-

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

;; ef-themes
(use-package ef-themes
  :ensure t
  :bind ("<f6>" . ef-themes-toggle)
  :custom
  ;; If you like two specific themes and want to switch between them, you
  ;; can specify them in `ef-themes-to-toggle' and then invoke the command
  ;; `ef-themes-toggle'.  All the themes are included in the variable
  ;; `ef-themes-collection'.
  (ef-themes-to-toggle '(ef-frost ef-elea-dark))

  (ef-themes-headings ; read the manual's entry or the doc string
   '((0 variable-pitch light 1.9)
     (1 variable-pitch light 1.8)
     (2 variable-pitch regular 1.7)
     (3 variable-pitch regular 1.6)
     (4 variable-pitch regular 1.5)
     (5 variable-pitch 1.4) ; absence of weight means `bold'
     (6 variable-pitch 1.3)
     (7 variable-pitch 1.2)
     (t variable-pitch 1.1)))

  (ef-themes-mixed-fonts t)
  (ef-themes-variable-pitch-ui t)

  :init
  ;; Disable all other themes to avoid awkward blending:
  (mapc #'disable-theme custom-enabled-themes)

  ;; Load the theme of choice:
  ;; (load-theme 'ef-elea-dark :no-confirm)

  ;; OR use this to load the theme which also calls `ef-themes-post-load-hook':
  (ef-themes-select 'ef-elea-dark)

  ;; The themes we provide are recorded in the `ef-themes-dark-themes',
  ;; `ef-themes-light-themes'.

  ;; We also provide these commands, but do not assign them to any key:
  ;;
  ;; - `ef-themes-toggle'
  ;; - `ef-themes-select'
  ;; - `ef-themes-select-dark'
  ;; - `ef-themes-select-light'
  ;; - `ef-themes-load-random'
  ;; - `ef-themes-preview-colors'
  ;; - `ef-themes-preview-colors-current'
  )

;; Spacious padding
(use-package spacious-padding
  :ensure t
  :custom
  ;; These is the default value, but I keep it here for visiibility.
  (spacious-padding-widths
   '( :internal-border-width 15
      :header-line-width 4
      :mode-line-width 6
      :tab-width 4
      :right-divider-width 30
      :scroll-bar-width 8
      :fringe-width 8))

  ;; Read the doc string of `spacious-padding-subtle-mode-line' as it
  ;; is very flexible and provides several examples.
  (spacious-padding-subtle-mode-line
   `( :mode-line-active 'default
      :mode-line-inactive vertical-border))
  :init
  (spacious-padding-mode 1)

  )

;; Rainbow delimiters
(use-package rainbow-delimiters
  :ensure t
  :hook prog-mode)

(provide 'ce-ui)
;;; ce-ui.el ends here
