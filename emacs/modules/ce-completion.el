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
  :init
  ;; Marginalia must be activated in the :init section of use-package such that
  ;; the mode gets enabled right away. Note that this forces loading the
  ;; package.
  (marginalia-mode)
  )

;; Consult
(use-package consult
  :ensure t
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
         ("M-s t" . consult-theme)
         :map ce/prefix-buffer-map
         ("b" . consult-buffer)
         ("w" . consult-buffer-other-window)
         ("f" . consult-buffer-other-frame)
         ("p" . consult-project-buffer)
         )
  :config
  (with-eval-after-load 'org
    (keymap-set org-mode-map "M-s /" 'consult-org-heading)
    (keymap-set org-mode-map "M-s a" 'consult-org-agenda))
  )


;; Embark
(use-package embark
  :ensure t
  :bind
  (("C-." . embark-act)         ;; pick some comfortable binding
   ("M-." . embark-dwim)        ;; good alternative: M-.
   ("C-h B" . embark-bindings)) ;; alternative for `describe-bindings'

  :init

  ;; Optionally replace the key help with a completing-read interface
  (setq prefix-help-command #'embark-prefix-help-command)

  ;; Show the Embark target at point via Eldoc. You may adjust the
  ;; Eldoc strategy, if you want to see the documentation from
  ;; multiple providers. Beware that using this can be a little
  ;; jarring since the message shown in the minibuffer can be more
  ;; than one line, causing the modeline to move up and down:

  ;; (add-hook 'eldoc-documentation-functions #'embark-eldoc-first-target)
  ;; (setq eldoc-documentation-strategy #'eldoc-documentation-compose-eagerly)

  :config

  ;; Hide the mode line of the Embark live/completions buffers
  (add-to-list 'display-buffer-alist
               '("\\`\\*Embark Collect \\(Live\\|Completions\\)\\*"
                 nil
                 (window-parameters (mode-line-format . none)))))  

(use-package embark-consult
  :ensure t
  :after (consult embark))


;;;; Completion in Region

;; Enable the mode in programming modes only for now
(add-hook 'prog-mode-hook #'completion-preview-mode)

;; and in shell and friends
(with-eval-after-load 'comint
  (add-hook 'comint-mode-hook #'completion-preview-mode))

;; Some tweaks
(with-eval-after-load 'completion-preview
  ;; Show the preview already after two symbol characters
  (setq completion-preview-minimum-symbol-length 2)

  ;; Non-standard commands to that should show the preview:

  ;; Org mode has a custom `self-insert-command'
  (push 'org-self-insert-command completion-preview-commands)
  ;; Paredit has a custom `delete-backward-char' command
  (push 'paredit-backward-delete completion-preview-commands)

  ;; Bindings that take effect when the preview is shown:

  ;; Cycle the completion candidate that the preview shows
  (keymap-set completion-preview-active-mode-map "M-n" #'completion-preview-next-candidate)
  (keymap-set completion-preview-active-mode-map "M-p" #'completion-preview-prev-candidate)
  ;; Convenient alternative to C-i after typing one of the above
  (keymap-set completion-preview-active-mode-map "M-i" #'completion-preview-insert))

;;;; TODO Cape

;;;; TODO TempEL or yassnippet

(provide 'ce-completion)
;;; ce-completion.el ends here
