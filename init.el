(package-initialize)

;; Load these packages before anything else
(require 'use-package)
(require 'bind-key)

;; Load core modules
(add-to-list 'load-path "~/.emacs.d/core/")

;; Local local modules
(add-to-list 'load-path "~/.emacs.d/local/")

;; Setup Solarized Theme
(require 'core-ui)
;; Variables used mostly for evil mode customization
(require 'core-variables)
;; Utility functions and macros
(require 'core-funcs)
;; Custom functions to set key bindings
(require 'core-keybindings)
;; Functions and macros for jumping around
(require 'core-jump)
;; Function and macros for transient states
(require 'core-transient-state)
;; Macro for toggles
(require 'core-toggle)
;; Setup evil mode
(require 'core-evil)
;; Core settings
(require 'core-settings)
;; Load evil-evilified-state
(require 'evil-evilified-state)
;; Settings for an assortment of useful packages
;; Mostly consists configurations for built-in packages
(require 'core-packages)
;; Evil key bindings
(require 'core-evil-keybindings)
;; Editing preferences
(require 'core-editing)
;; Editing visual preferences
(require 'core-editing-visual)
;; Setup workspaces using persp-mode
(require 'core-workspaces)
;; Setup Ivy and Company
(require 'core-search-and-completion)
;; Setup projectile
(require 'core-project-management)
;; Setup magit
(require 'core-version-control)

;; Prefer UTF-8 enconding
(prefer-coding-system 'utf-8)

;; Set personal info
(setq user-full-name "Suraj Kumar Reddy"
      user-mail-address "suraj@gmail.com"
      calendar-latitude 17.3
      calendar-longitude -78.4
      calendar-location-name "Hyderabad, IND")

;; Add the anaconda bin dir for executables
(add-to-list 'exec-path "~/anaconda2/bin/")

;; Some sensible defaults
(load-file "~/.emacs.d/resources/sensible-defaults.el")
(sensible-defaults/use-all-settings)
(sensible-defaults/use-all-keybindings)
(sensible-defaults/backup-to-temp-directory)

;; Set custom file location
(setq custom-file "~/.emacs.d/custom2.el")
(load custom-file 'noerror)

;; Python module
(use-package elpy
  :defer t
  :init
  (add-hook 'python-mode-hook 'elpy-mode)
  :config
  (elpy-enable)
  (when (require 'flycheck nil t)
    (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
    (add-hook 'elpy-mode-hook 'flycheck-mode))
  (setq elpy-rpc-backend "jedi")
  (elpy-use-ipython "ipython2")
  (setq elpy-company-post-completion-function 'elpy-company-post-complete-parens)
  (use-package py-autopep8
    :config
    (add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save)
    (message "py-autopep8 loaded"))
    (message "elpy loaded"))

(use-package ein
  :defer t
  :init
  (setq jupyter-server-command-path "~/anaconda2/bin/jupyter")
  (setq jupyter-server-dir "~/Projects/data-science/")
  (global-set-key (kbd "C-x j") (lambda()(interactive)(ein:jupyter-server-start jupyter-server-command-path jupyter-server-dir)))
  :config
  (require 'ein)
  (require 'ein-loaddefs)
  (require 'ein-notebook)
  (require 'ein-subpackages)
  (setq ein:log-message-level 0)
  (message "ein loaded"))

(setq python-indent 2)

;; Org mode
(global-set-key (kbd "C-c l") 'org-store-link)
(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c c") 'org-capture)
(global-set-key (kbd "C-c b") 'org-iswitchb)

(with-eval-after-load 'org
(bind-key "C-M-w" 'append-next-kill org-mode-map)
(bind-key "C-c t" 'org-show-todo-tree org-mode-map)
(bind-key "C-c r" 'org-refile org-mode-map))

(setq org-fontify-whole-heading-line t
      org-fontify-done-headline t
      org-fontify-quote-and-verse-blocks t)

(setq org-src-fontify-natively t)

(setq org-src-tab-acts-natively t)

(setq org-ellipsis "↴")
(setq org-src-window-setup 'current-window)

;; Process management
(use-package prodigy
  :defer t
  :config
  (message "prodigy loaded"))
