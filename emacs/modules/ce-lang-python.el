;;; ce-lang-python.el --- Configuration for the Python module  -*- lexical-binding: t; -*-

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

;; Do not try to guess indentation
(setopt python-indent-guess-indent-offset nil)
(setopt python-indent-offset 4)

;; Eglot configuration
(with-eval-after-load 'eglot
  (add-to-list 'eglot-server-programs
               `(python-mode . ,(eglot-alternatives
                                 '(
                                   ("basedpyright-langserver" "--stdio")))
                             ))
  )

;;;; docstrings
;; For conveniently entering numpy style docstrings
(use-package numpydoc
  :ensure t
  :after python
  :bind (
         :map python-ts-mode-map
              ("C-c d" . numpydoc-generate))
  :custom
  ;; Do not prompt for descriptions
  (numpydoc-prompt-for-input nil)
  ;; Do not insert Examples block
  (numpydoc-insert-examples-block nil)
  )

;; This package provides a minor mode for editing Python
;; docstrings. It provides syntax highlighting for docstrings and
;; overrides the `fill-paragraph' function so that lines are wrapped
;; according to the Python style convention.
(use-package python-docstring
  :ensure t
  :hook python-ts-mode)

;;;; Testing

;; Running pytest from emacs
(use-package python-pytest
    :ensure t
    :after python
    :bind (
           :map python-ts-mode-map
                ("C-c t" . python-pytest-dispatch)))


;;;; uv integration
(use-package uv-mode
  :ensure t
  :hook (python-ts-mode . uv-mode-auto-activate-hook))

(provide 'ce-lang-python)
;;; ce-lang-python.el ends here
