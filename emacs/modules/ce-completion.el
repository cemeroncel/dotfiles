;;; ce-completion.el --- Configuration for the completion module  -*- lexical-binding: t; -*-

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

;; Add prompt indicator to `completing-read-multiple'.
;; We display [CRM<separator>], e.g., [CRM,] if the separator is a comma.
(defun crm-indicator (args)
  (cons (format "[CRM%s] %s"
                (replace-regexp-in-string
                 "\\`\\[.*?]\\*\\|\\[.*?]\\*\\'" ""
                 crm-separator)
                (car args))
        (cdr args)))
(advice-add #'completing-read-multiple :filter-args #'crm-indicator)

;; Do not allow the cursor in the minibuffer prompt
(setopt minibuffer-prompt-properties
        '(read-only t cursor-intangible t face minibuffer-prompt))
(add-hook 'minibuffer-setup-hook #'cursor-intangible-mode)

;; Enable recursive minibuffers
(setopt enable-recursive-minibuffers t)

;; Vertico
(use-package vertico
  :ensure t
  :custom
  (vertico-scroll-margin 0 "Set the scroll margin.")
  (vertico-count 10 "Set the number of candidates shown.")
  (vertico-resize nil "Do not grow and shring the Vertico minibuffer.")
  (vertico-cycle t "Enable cycling.")
  :init
  (vertico-mode)
  )

;; Orderless
(use-package orderless
  :ensure t
  :custom
  (completion-styles '(orderless basic))
  (completion-category-defaults nil)
  (completion-category-overrides '((file (styles partial-completion)))))

;; Marginalia
(use-package marginalia
  :ensure t
  ;; Bind `marginalia-cycle' locally in the minibuffer.  To make the binding
  ;; available in the *Completions* buffer, add it to the
  ;; `completion-list-mode-map'.
  :bind (:map minibuffer-local-map
         ("M-A" . marginalia-cycle))
  :custom
  (marginalia-annotators '(marginalia-annotators-heavy
                           marginalia-annotators-light
                           nil))
  :init
  ;; Marginalia must be activated in the :init section of use-package such that
  ;; the mode gets enabled right away. Note that this forces loading the
  ;; package.
  (marginalia-mode)
  )

;; Corfu

;; Emacs 28 and newer: Hide commands in M-x which do not apply to the current
;; mode.  Corfu commands are hidden, since they are not used via M-x. This
;; setting is useful beyond Corfu.
(setopt read-extended-command-predicate #'command-completion-default-include-p)

;; Enable indentation+completion using the TAB key.
;; `completion-at-point' is often to M-TAB.
(setopt tab-always-indent 'complete)

(use-package corfu
  :ensure t
  :custom
  ;; Enable auto completion
  (corfu-auto t)
  (corfu-quit-no-match 'separator)
  (corfu-preview-current nil)
  :init
  (global-corfu-mode))

(use-package company
  :ensure t
  :disabled
  :hook (after-init . global-company-mode))

;; Consult
(use-package consult
  :ensure t
  ;; TODO: Add `consult-org-heading' and `consult-org-agenda' into
  ;; `org-mode-map'
  :bind (
         ("M-s b" . consult-buffer)
         ("M-s y" . consult-yank-from-kill-ring)
         ("M-s r" . consult-register)
         ("M-s g" . consult-goto-line)
         ("M-s m" . consult-mark)
         ("M-s M" . consult-global-mark)
         ("M-s o" . consult-outline)
         ("M-s i" . consult-imenu)
         ("M-s I" . consult-imenu-multi)
         ("M-s l" . consult-line)
         ("M-s L" . consult-line-multi)
         ("M-s ." . consult-ripgrep)
         ("M-s e" . consult-flymake)
         ("M-s E" . consult-compile-error)
         ("M-s x" . consult-xref)
         ("M-s i" . consult-info)
         ("M-s t" . consult-theme)))

;; Embark
(use-package embark
  :ensure t)

(use-package embark-consult
  :ensure t
  :after (consult embark))

(provide 'ce-completion)
;;; ce-completion.el ends here
