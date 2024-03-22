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

(defvar ce/default-conda-environment "sci"
  "Name of the conda environment that will be used by default.")

(defconst ce/default-conda-environment-bin
  (expand-file-name "bin"
                    (expand-file-name
                     ce/default-conda-environment
                     "~/miniforge3/envs"))
  "The `bin' directory of the conda environment `ce/default-conda-environment'."
  )

(setopt python-shell-interpreter
        (expand-file-name "ipython" ce/default-conda-environment-bin))
(setopt python-shell-interpreter-args "--simple-prompt")

;; Do not try to guess indentation
(setopt python-indent-guess-indent-offset nil)
(setopt python-indent-offset 4)

;; From https://www.emacswiki.org/emacs/ExecPath
(setenv "PATH" (concat (getenv "PATH") (concat ":" ce/default-conda-environment-bin)))
(setq exec-path (append exec-path `(,ce/default-conda-environment-bin)))

;; Eglot configuration
(with-eval-after-load 'eglot
  (add-to-list 'eglot-server-programs
               `(python-mode . ,(eglot-alternatives
                                 '(("pylsp")
                                   ("pyright-langserver" "--stdio")))
                             )))
(setq-default eglot-workspace-configuration
              '(:pylsp (:plugins (:jedi_completion (:include_params t
                                                    :fuzzy t)
                                                   :pylint (:enabled :json-false)))))

(provide 'ce-lang-python)
;;; ce-lang-python.el ends here
