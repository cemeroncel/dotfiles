;;; ce-latex.el --- LaTeX configuration              -*- lexical-binding: t; -*-

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

(use-package cdlatex
  :ensure t
  :hook ((LaTeX-mode . turn-on-cdlatex)
         (latex-mode . turn-on-cdlatex))
  )

(use-package tex
  :ensure auctex
  :config
  ;; Basic settings
  (customize-set-variable 'TeX-auto-save t)
  (customize-set-variable 'TeX-parse-self t)
  (setq-default TeX-master nil)

  ;; compile to pdf
  (tex-pdf-mode)

  ;; correlate the source and the output
  (TeX-source-correlate-mode)

  ;; set a correct indentation in a few additional environments
  ;; (add-to-list 'LaTeX-indent-environment-list '("lstlisting" current-indentation))
  ;; (add-to-list 'LaTeX-indent-environment-list '("tikzcd" LaTeX-indent-tabular))
  ;; (add-to-list 'LaTeX-indent-environment-list '("tikzpicture" current-indentation))

  ;; add a few macros and environment as verbatim
  ;; (add-to-list 'LaTeX-verbatim-environments "lstlisting")
  ;; (add-to-list 'LaTeX-verbatim-environments "Verbatim")
  ;; (add-to-list 'LaTeX-verbatim-macros-with-braces "lstinline")
  ;; (add-to-list 'LaTeX-verbatim-macros-with-delims "lstinline")

  ;; electric pairs in auctex
  (customize-set-variable 'TeX-electric-math (cons "$" "$"))
  (customize-set-variable 'TeX-electric-sub-and-superscript t)
  (customize-set-variable 'LaTeX-electric-left-right-brace t)

  ;; open all buffers with the math mode and visual-line mode
  (add-hook 'LaTeX-mode-hook #'LaTeX-math-mode)
  (add-hook 'LaTeX-mode-hook #'visual-line-mode)

  ;; unicode symbols
  (customize-set-variable 'prettify-symbols-unprettify-at-point t)
  (add-hook 'TeX-mode-hook #'prettify-symbols-mode)

  ;; customized buffer setup
  ;; (add-hook 'LaTeX-mode-hook #'ce/latex-buffer-setup)
  (add-hook 'LaTeX-mode-hook #'rainbow-delimiters-mode)

  ;; add support for references
  (add-hook 'LaTeX-mode-hook 'turn-on-reftex)
  (customize-set-variable 'reftex-plug-into-AUCTeX t)

  ;; force buffer refresh after compilation
  (add-hook 'TeX-after-compilation-finished-functions #'TeX-revert-document-buffer)

  ;; to use pdfview with auctex
  (customize-set-variable 'TeX-view-program-selection '((output-pdf "PDF Tools")))
  (customize-set-variable 'TeX-view-program-list '(("PDF Tools" TeX-pdf-tools-sync-view)))
  (customize-set-variable 'TeX-source-correlate-start-server t)
  )



(provide 'ce-latex)
;;; ce-latex.el ends here
