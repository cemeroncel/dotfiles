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

;;;; Modus themes
(use-package modus-themes
  :ensure t
  :config
  ;; Add all your customizations prior to loading the themes
  (setq modus-themes-italic-constructs t
        modus-themes-bold-constructs t)

  ;; Load the theme of your choice.
  (modus-themes-load-theme 'modus-operandi)
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

;; Pretty mode line
(use-package mood-line
  :ensure t
  ;; Enable mood-line
  :config
  (mood-line-mode)

  ;; Use pretty Fira Code-compatible glyphs
  :custom
  (mood-line-glyph-alist mood-line-glyphs-unicode))

;;;; Font configuration
(use-package fontaine
  :ensure t
  :bind (:map ce/prefix-toggle-map
  	    ("f" . fontaine-set-preset))
  :custom
  (fontaine-latest-state-file (locate-user-emacs-file "fontaine-latest-state.eld"))
  (fontaine-presets '(
                      (titus
  		       :default-family "Aporetic Serif Mono"
  		       :default-height 120
                       :fixed-pitch-family "Aporetic Serif Mono"
  		       :fixed-pitch-height 1.0
  		       :variable-pitch-family "Aporetic Sans"
  		       :variable-pitch-height 1.0
  		     )
  		    (2160p
  		     :default-family "Aporetic Serif Mono"
  		     :default-height 140
                       :fixed-pitch-family "Aporetic Serif Mono"                       
  		     :fixed-pitch-height 1.0
  		     :variable-pitch-family "Aporetic Sans"
  		     :variable-pitch-height 1.0
  		     )
  		    )
  		  )
  :init
  ;; Set the last preset or fall back to desired style from `fontaine-presets'
  ;; (the `regular' in this case).
  (fontaine-set-preset 'titus)

  ;; Persist the latest font preset when closing/starting Emacs and
  ;; while switching between themes.
  (fontaine-mode 1)
  )





(provide 'ce-ui)
;;; ce-ui.el ends here
