;;; ce-ide.el --- Configuration for the IDE module  -*- lexical-binding: t; -*-

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

;;;; Eldoc
;; Use at most 2 lines when showing the Eldoc documentation in the echo area. 
(setopt eldoc-echo-area-use-multiline-p 2)
(setopt eldoc-documentation-strategy 'eldoc-documentation-compose)

;;;; Eglot
;; Do not show the progress of LSP server work
(setopt eglot-report-progress nil)


;;;; Tree-sitter

;; A function that installs particular releases of the `tree-sitter'
;; language grammers that are known to work with Emacs and the
;; `combobulate' package
;; Taken from https://github.com/mickeynp/combobulate
(defun ce/mp-setup-install-grammars ()
    "Install Tree-sitter grammars if they are absent."
    (interactive)
    (dolist (grammar
             ;; Note the version numbers. These are the versions that
             ;; are known to work with Combobulate *and* Emacs.
             '((css . ("https://github.com/tree-sitter/tree-sitter-css" "v0.20.0"))
               (go . ("https://github.com/tree-sitter/tree-sitter-go" "v0.20.0"))
               (html . ("https://github.com/tree-sitter/tree-sitter-html" "v0.20.1"))
               (javascript . ("https://github.com/tree-sitter/tree-sitter-javascript" "v0.20.1" "src"))
               (json . ("https://github.com/tree-sitter/tree-sitter-json" "v0.20.2"))
               (markdown . ("https://github.com/ikatyang/tree-sitter-markdown" "v0.7.1"))
               (python . ("https://github.com/tree-sitter/tree-sitter-python" "v0.20.4"))
               (rust . ("https://github.com/tree-sitter/tree-sitter-rust" "v0.21.2"))
               (toml . ("https://github.com/tree-sitter/tree-sitter-toml" "v0.5.1"))
               (tsx . ("https://github.com/tree-sitter/tree-sitter-typescript" "v0.20.3" "tsx/src"))
               (typescript . ("https://github.com/tree-sitter/tree-sitter-typescript" "v0.20.3" "typescript/src"))
               (yaml . ("https://github.com/ikatyang/tree-sitter-yaml" "v0.5.0"))))
      (add-to-list 'treesit-language-source-alist grammar)
      ;; Only install `grammar' if we don't already have it
      ;; installed. However, if you want to *update* a grammar then
      ;; this obviously prevents that from happening.
      (unless (treesit-language-available-p (car grammar))
        (treesit-install-language-grammar (car grammar)))))

;; You can remap major modes with `major-mode-remap-alist'. Note
  ;; that this does *not* extend to hooks! Make sure you migrate them
;; also

;; Remap major modes with `major-mode-remap-alist'. Note that this
;; does not extend to hooks. Migrate them also.
(dolist (mapping
         '((python-mode . python-ts-mode)
           (css-mode . css-ts-mode)
           (typescript-mode . typescript-ts-mode)
           (js2-mode . js-ts-mode)
           (bash-mode . bash-ts-mode)
           (conf-toml-mode . toml-ts-mode)
           (go-mode . go-ts-mode)
           (css-mode . css-ts-mode)
           (json-mode . json-ts-mode)
           (js-json-mode . json-ts-mode)))
  (add-to-list 'major-mode-remap-alist mapping))



(provide 'ce-ide)
;;; ce-ide.el ends here
