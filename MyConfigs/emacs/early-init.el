;;; early-init.el --- minimal pre-init setup -*- lexical-binding: t; -*-
;;; Commentary:

;;; Code:

;; ------------------------
;; Disable package.el
;; ------------------------
(setq package-enable-at-startup nil)

;; ----------------------------
;; Garbage Collection
;; ---------------------------
(let (file-name-handler-alist)
  (if noninteractive ; in CLI sessions
      (setq gc-cons-threshold 134217728  ; 128mb
            ;; Backported from 29 (see emacs-mirror/emacs@73a384a98698)
            gc-cons-percentage 1.0)
    (setq gc-cons-threshold most-positive-fixnum))

  (setq load-prefer-newer noninteractive)

  (let ((debug (getenv-internal "DEBUG")))
    (when (stringp debug)
      (if (string-empty-p debug)
	  (setenv "DEBUG" nil)
	(setq init-file-debug t
	      debug-on-error t)))))

;; --------------------------
;; Configure UI early
;; ---------------------------
(add-to-list 'default-frame-alist '(internal-border-width . 20))
(add-to-list 'default-frame-alist '(alpha-background . 90)) ;; Transparency

;; Disable toolbar/menu/scrollbar before they're drawn
(menu-bar-mode -1)                  ;; Disable the menu bar
(tool-bar-mode -1)                  ;; Disable visible scrollbar
(tooltip-mode -1)                   ;; Disable the toolbar
(scroll-bar-mode -1)                ;; Disable tooltips
(set-fringe-mode -1)                ;; Breathing room
(blink-cursor-mode 0)               ;; No blinking
(global-hl-line-mode)               ;; Highlight current line
(global-subword-mode 1)             ;; camelCase and PascalCase
(global-visual-line-mode 1)         ;; Wrap long lines
(global-auto-revert-mode 1)         ;; Auto revert

;; Display line numbers
(global-display-line-numbers-mode 1)
(add-hook 'prog-mode-hook #'display-line-numbers-mode) ;; Prefer only in programming buffers
(add-hook 'org-mode-hook (lambda () (display-line-numbers-mode 0))) ;; Avoid in org-mode

;; Make ESC quit prompts
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

;; Org mode scratch buffers
(setq initial-major-mode 'org-mode)

;; Truncate lines
(setq truncate-lines t)
(setq truncate-partial-width-windows nil)

;; Backup files
(setq backup-directory-alist '("~/.config/emacs/.cache/backups/"))
(setq backup-by-copying t)
(setq delete-old-versions t)
(setq version-control t)

;; Auto save files
;;(setq tramp-auto-save-directoy "/dev/null")
(setq auto-save-file-name-transforms '(("~/.config/emacs/.cache/auto-save/" t)))

;;; early-init.el ends here

