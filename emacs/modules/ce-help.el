;;; ce-help.el --- Help buffers                      -*- lexical-binding: t; -*-

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

(use-package helpful
  :ensure t
  ;; The built-in `describe-function' includes both functions
  ;; and macros. `helpful-function' is functions only,
  ;; `helpful-callable' as a drop-in replacement.
  :bind (("C-h f" . helpful-callable)
         ("C-h v" . helpful-variable)
         ("C-h k" . helpful-key)
         ("C-h x" . helpful-command)
         ("C-h d" . helpful-at-point))
  )

(use-package elisp-demos
  :after helpful
  :ensure t
  :defer t
  :config
  (advice-add 'helpful-update :after #'elisp-demos-advice-helpful-update)
  )

(provide 'ce-help)
;;; ce-help.el ends here
