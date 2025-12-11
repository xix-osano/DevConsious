;;; config.el --- EMO configuration -*- lexical-binding: t; -*-
;;; Commentary:

;;; Code:

(add-to-list 'load-path "~/.config/emacs/scripts/")

(require 'elpaca-setup)  ;; The Elpaca Package Manager

(use-package nerd-icons
  :ensure t
  :commands (nerd-icons-octicon
             nerd-icons-faicon
             nerd-icons-flicon
             nerd-icons-wicon
             nerd-icons-mdicon
             nerd-icons-codicon
             nerd-icons-devicon
             nerd-icons-ipsicon
             nerd-icons-pomicon
             nerd-icons-powerline))

(use-package dashboard
  :ensure t
  :init
  (setq initial-buffer-choice 'dashboard-open)
  (setq dashboard-set-heading-icons t)
  (setq dashboard-set-file-icons t)
  (setq dashboard-banner-logo-title "Emacs Is More Than A Text Editor!")
  ;;(setq dashboard-startup-banner 'logo) ;; use standard emacs logo as banner
  (setq dashboard-startup-banner "~/.config/emacs/images/emacs-dash.txt")  ;; use custom image as banner
  (setq dashboard-center-content t) ;; set to 'nil' for Left-margin content
  (setq dashboard-set-navigator t)
  (setq dashboard-items '((recents . 5)
                          (agenda . 5 )
                          (bookmarks . 3)
                          (projects . 3)
                          (registers . 3)))
  ;;(setq dashboard-icon-type 'nerd-icons)) ;; use `nerd-icons' package
  :custom
  (dashboard-modify-heading-icons '((recents . "file-text")
				      (bookmarks . "book")))
  :config
  (dashboard-setup-startup-hook))

(add-to-list 'custom-theme-load-path "~/.config/emacs/themes/")
(load-theme 'mistletoe t)

;;(use-package doom-themes
;;   :ensure t
;;   :config
;;   (setq doom-themes-enable-bold t
;;	 doom-themes-enable-italic t
;;	 custom-theme-directory "~/.config/emacs/themes/")
;;   (load-theme 'doom-one t))

(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1)
  :custom ((doom-modeline-width 5)))

(set-face-attribute 'default nil
                    :family "Intel One Mono"
                    :height 120
                    :weight 'normal
                    :width 'normal)

(use-package mini-frame
  :ensure t
  :config
  (mini-frame-mode 1)
  (setq mini-frame-show-parameters
        '((top . 100)
          (left . 0.5)
          (width . 0.75)
          (height . 10)
          (background-color . "#1c1f24")
          (internal-border-width . 12)
          (child-frame-border-width . 2))))

(use-package evil
  :ensure t
  :init
  (setq evil-want-keybinding nil
        evil-respect-visual-line-mode t
        evil-undo-system 'undo-fu
        evil-vsplit-window-right t
        evil-split-window-below t
        evil-want-C-u-scroll t
        evil-want-C-i-jump nil)
  :config
  (setq evil-respect-visual-line-mode t)
  (setq evil-undo-system 'undo-fu)
  (setq evil-redo-function 'undo-fu-only-redo)
  (evil-mode 1))

(use-package evil-collection
  :ensure t
  :after evil
  :config
  (add-to-list 'evil-collection-mode-list 'help) ;; evilify help mode
  (evil-collection-init))

(use-package evil-tutor
  :ensure t)

(use-package general
  :ensure t
  :config
  (general-evil-setup)
  ;; Set 'SPC' as the leader key
  (general-create-definer emo/leader-key
    :states '(normal visual emacs)
    :keymaps 'override
    :prefix "SPC")

  ;; Optional: create a local-leader for mode-specific bindings
  ;;(general-create-definer emo/local-leader
  ;;  :prefix "SPC m")

  ;; --- Global bindings ---
  (emo/leader-key
    "f"  '(:ignore t :which-key "files")
    "f f" '(find-file :which-key "find file")
    "f s" '(save-buffer :which-key "save file")

    "b"  '(:ignore t :which-key "buffers")
    "b b" '(switch-to-buffer :which-key "switch buffer")
    "b d" '(kill-buffer :which-key "kill buffer")

    "w"  '(:ignore t :which-key "windows")
    "w s" '(split-window-below :which-key "split below")
    "w v" '(split-window-right :which-key "split right")
    "w d" '(delete-window :which-key "delete window")))


;; Which keymaps
(use-package which-key
  :init
    (which-key-mode 1)
  :diminish
  :config
  (setq which-key-side-window-location 'bottom
	  which-key-allow-imprecise-window-fit nil
	  which-key-sort-uppercase-first nil
	  which-key-add-column-padding 1
	  which-key-max-display-columns nil
	  which-key-min-display-lines 6
	  which-key-side-window-slot -10
	  which-key-side-window-max-height 0.25
	  which-key-idle-delay 0.8
	  which-key-max-description-length 25
	  which-key-allow-imprecise-window-fit nil
	  which-key-separator " → " ))

(use-package projectile
  :ensure t)

(use-package magit
  :ensure t)

(use-package transient
  :ensure t)

(use-package company
  :ensure t
  :defer 2
  :diminish
  :custom
  (company-begin-commands '(self-insert-command))
  (company-idle-delay .1)
  (company-minimum-prefix-length 2)
  (company-show-numbers t)
  (company-tooltip-align-annotations 't)
  (global-company-mode t))

(use-package company-box
  :ensure t
  :after company
  :diminish
  :hook (company-mode . company-box-mode))

(use-package vertico
  :ensure t
  :custom
  (vertico-scroll-margin 0) ;; Different scroll margin
  (vertico-count 20) ;; Show more candidates
  (vertico-resize nil) ;; Grow and shrink the Vertico minibuffer
  (vertico-cycle t) ;; Enable cycling for `vertico-next/previous'
  :init
  (vertico-mode 1))

(defvar +treemacs-git-mode 'simple
 "This must be set before `treemacs' has loaded.")

(use-package treemacs
  :ensure t
  :init
  (setq treemacs-follow-after-init t
	treemacs-is-never-other-window t
	treemacs-sorting 'alphabetic-case-insensitive-asc)
  :config
  (treemacs-follow-mode 1) ;; Follow cursor

  (when +treemacs-git-mode
    (setq +treemacs-git-mode 'simple))
  (treemacs-git-mode +treemacs-git-mode))

(use-package treemacs-nerd-icons
  :ensure t
  :config (treemacs-load-theme "nerd-icons")) ;; uses Nerd icons automatically

(use-package treemacs-evil
  :ensure t)

(use-package treemacs-projectile
  :ensure t)

(use-package treemacs-magit
  :ensure t
  :after treemacs magit)

(use-package treemacs-persp
  :ensure t
  :after treemacs
  :config (treemacs-set-scope-type 'Perspectives))

(use-package lua-mode
  :ensure t)

(use-package nix-mode
  :ensure t)

(use-package go-mode
  :ensure t)

(use-package qml-mode
  :ensure t)

(use-package undo-fu
  :ensure t)

(use-package undo-fu-session
  :ensure t)

;;; config.el ends here
