;; Set up load path TODO needed?
(setq settings-dir
            (expand-file-name "settings" user-emacs-directory))
(add-to-list 'load-path settings-dir)


;; Set up package.el to work with MELPA
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(package-initialize)
;; this part can be slow (network connection)
;; put it back in when I keep emacs open for long periods of time
;; (ie after I'm done with my initial play).
;;(package-refresh-contents)

;; Disable startup message
(setq inhibit-startup-message t)

;; START evil
;; Download Evil
;;(unless (package-installed-p 'evil)
;;  (package-install 'evil))

;; Enable Evil
(require 'evil)
(evil-mode 1)
;; END evil


;; Org Roam (WIP)
;; Needed this to get things working for me.
(add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/") t)
;; from https://systemcrafters.net/build-a-second-brain-in-emacs/keep-a-journal/
(use-package org-roam
  :ensure t
  :init
  (setq org-roam-v2-ack t)
  :custom
  (org-roam-directory "~/workspace/org-roam")
  (org-roam-completion-everywhere t)
  :bind (("C-c n l" . org-roam-buffer-toggle)
         ("C-c n f" . org-roam-node-find)
         ("C-c n i" . org-roam-node-insert)
         :map org-mode-map
         ("C-M-i" . completion-at-point)
         :map org-roam-dailies-map
         ("Y" . org-roam-dailies-capture-yesterday)
         ("T" . org-roam-dailies-capture-tomorrow))
  :bind-keymap
  ("C-c n d" . org-roam-dailies-map)
  :config
  (require 'org-roam-dailies) ;; Ensure the keymap is available
  (org-roam-db-autosync-mode))
;;(make-directory "~/workspace/org-roam")

;; prev, before copy paste from https://systemcrafters.net/build-a-second-brain-in-emacs/keep-a-journal/
;;(require 'org-roam)
;; only required first load
;;(make-directory (file-truename "~/workspace/org-roam"))
;;(make-directory (file-truename "~/workspace/org-roam/daily"))

;;(setq org-roam-directory (file-truename "~/workspace/org-roam"))
;;(org-roam-db-autosync-mode)
;;(org-roam-setup)
;; END org roam

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (markdown-preview-mode rustic colemak-evil exec-path-from-shell powerline lsp-ivy org-bullets counsel avy ivy helm go-projectile go-autocomplete company-shell company-ctags company-math company-go projectile flycheck yasnippet-snippets auto-complete go-mode neotree doom-themes lsp-mode evil))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


;; START golang, mostly from https://arenzana.org/2019/12/emacs-go-mode-revisited/
;; TODO do something like this for Rust (RLS).
(use-package lsp-mode
  :ensure t
  :commands (lsp lsp-deferred)
  :hook (go-mode . lsp-deferred))

;; Rust analyzer
;; for rust-mode
;; (setq lsp-rust-server 'rust-analyzer)
;; for rustic
(setq rustic-lsp-server 'rust-analyzer)
(setq rustic-format-trigger 'on-save)
;;(custom-set-faces
;; '(rustic-compilation-column ((t (:inherit compilation-column-number))))
;; '(rustic-compilation-line ((t (:foreground "LimeGreen")))))

;;Set up before-save hooks to format buffer and add/delete imports.
;;Make sure you don't have other gofmt/goimports hooks enabled.

(defun lsp-go-install-save-hooks ()
  (add-hook 'before-save-hook #'lsp-format-buffer t t)
  (add-hook 'before-save-hook #'lsp-organize-imports t t))
(add-hook 'go-mode-hook #'lsp-go-install-save-hooks)

;;Optional - provides fancier overlays.

;;(use-package lsp-ui
;;  :ensure t
;;  :commands lsp-ui-mode
;;  :init
;;)

;;Company mode is a standard completion package that works well with lsp-mode.
;;company-lsp integrates company mode completion with lsp-mode.
;;completion-at-point also works out of the box but doesn't support snippets.

(use-package company
  :ensure t
  :config
  ;; Concigure the delay between typing and autocomplete suggestions
  ;;(setq company-idle-delay 0)
  (setq company-minimum-prefix-length 3))

(use-package company-lsp
  :ensure t
  :commands company-lsp)

;;Optional - provides snippet support.

;;(use-package yasnippet
;;  :ensure t
;;  :commands yas-minor-mode
;;  :hook (go-mode . yas-minor-mode))

;;lsp-ui-doc-enable is false because I don't like the popover that shows up on the right
;;I'll change it if I want it back
(setq lsp-ui-doc-enable nil)
      ;;lsp-ui-peek-enable t
      ;;lsp-ui-sideline-enable t
      ;;lsp-ui-imenu-enable t
      ;;lsp-ui-flycheck-enable t)

(setq lsp-gopls-staticcheck t)
;;(setq lsp-eldoc-render-all t)
;;(setq lsp-gopls-complete-unimported t)

;; debugging a message which pops up:
;; "LSP :: The following servers support current file but do not have automatic installation configuration: gopls go-bingo go-ls
;; You may find the installation instructions at https://github.com/emacs-lsp/lsp-mode/#supported-languages.
;; (If you have already installed the server check *lsp-log*).
;; SOLVED - launching from menu icon didn't setup some enviroment correctly.  Instead launch from cli.
;;(setq lsp-log-io t)

;; END Golang config

;; START General config (ergonomics)
;; Show line numbers, relative
(setq display-line-numbers 'relative)
(global-display-line-numbers-mode)
(setq display-line-numbers-type 'relative)

;; Get rid of menu/toolbar at the top (not sure if one or both?)
(menu-bar-mode -1)
(tool-bar-mode -1)

;; Info bar at the bottom of the window
(require 'powerline)
(powerline-default-theme)


;; projectile config (default from project README)
(projectile-global-mode +1)
(define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)

(require 'ivy)
(require 'counsel)
(ivy-mode 1)
(setq magit-completing-read-function 'ivy-completing-read)
(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)

;; END General config (ergonomics)

;; START org-mode configs
(require 'org-bullets)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))

;; List of my org mode files.  This shouldn't change very often
(setq org-agenda-files (quote ("~/workspace/workspace.org"
                               "~/Documents/health.org"
                               "~/Documents/financial/financials.org"
                               "~/Documents/home.org"
			       "~/org/gtd.org")))

(setq org-todo-keywords
      (quote ((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d)")
              (sequence "WAITING(w@/!)" "HOLD(h@/!)" "|" "CANCELLED(c@/!)"))))
;;(setq org-todo-keyword-faces
;;      (quote (("TODO" :foreground "red" :weight bold)
;;              ("NEXT" :foreground "dark orange" :weight bold)
;;              ("DONE" :foreground "spring green" :weight bold)
;;              ("WAITING" :foreground "orange" :weight bold)
;;              ("HOLD" :foreground "magenta" :weight bold))))

;; END    org-mode configs

;; Switch to most recent buffer with M-o
(global-set-key (kbd "M-o") 'mode-line-other-buffer)

;; load theme
(load-theme 'monokai t)

;; load any saved 'desktop' on startup
;;(desktop-save-mode 1)

;; I don't like having backup files alongside my source files.
;; Put all backups into ~/.emacs-saves
;; https://stackoverflow.com/questions/151945/how-do-i-control-how-emacs-makes-backup-files
(setq backup-directory-alist `(("." . "~/.emacs-saves")))

;; safe but slowest option, make backups by copying
(setq backup-by-copying t)

;; keep some history
(setq delete-old-versions t
      kept-new-versions 6
      kept-old-versions 2
      version-control t)

;; org capture
(setq org-default-notes-file (concat org-directory "/notes.org"))

(setq org-capture-templates
      '(("r" "Reference" entry
	 (file+headline "~/workspace/workspace.org" "References")
	 "* DEMO HEADER TEXT %?")))
