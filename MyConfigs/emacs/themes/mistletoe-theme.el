;;; mistletoe-theme.el --- Mistletoe theme for Emacs -*- lexical-binding: t; -*-

;; Copyright 2025-present Mistletoe, All rights reserved
;;
;; Permission is hereby granted, free of charge, to any person obtaining
;; a copy of this software and associated documentation files (the
;; "Software"), to deal in the Software without restriction, including
;; without limitation the rights to use, copy, modify, merge, publish,
;; distribute, sublicense, and/or sell copies of the Software, and to
;; permit persons to whom the Software is furnished to do so, subject to
;; the following conditions:
;;
;; The above copyright notice and this permission notice shall be included
;; in all copies or substantial portions of the Software.
;;
;; THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
;; EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
;; MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
;; IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
;; CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
;; TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
;; SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

;; Maintainer: Enosh Osano Misonge
;; Author: Enosh Misonge Osano <https://github.com/xix-osano>
;; Version: 1.0.0
;; Package-Requires: ((emacs "29.1"))
;; URL: https://github.com/xix-osano/emacs-mistletoe-theme.git

;;; Commentary:
;; mistletoe-theme.el provides the theme `mistletoe', a port of the
;; Mistletoe colors to Emacs.  To select a palette and enable the theme,
;; evaluate:
;; Place mistletoe-theme.el in ~/.emacs.d/themes/mistletoe-theme.el
;;
;; Add to your emacs config.el:
;;
;;     (add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
;;     (load-theme 'mistletoe t)
;;

;;; Code:

(deftheme mistletoe "A Mistletoe theme.")

;; Define the palette
(defconst mistletoe-colors
  '((rosewater . "#f5e0dc")
    (flamingo  . "#f2cdcd")
    (pink      . "#f5c2e7")
    (magenta   . "#c678dd")
    (mauve     . "#cba6f7")
    (red       . "#f38ba8")
    (maroon    . "#eba0ac")
    (peach     . "#fab387")
    (yellow    . "#f9e2af")
    (green     . "#a6e3a1")
    (orange    . "#f18400")
    (teal      . "#04f8ff")
    (sky       . "#89dceb")
    (sapphire  . "#74c7ec")
    (blue      . "#41b2ea")
    (lavender  . "#b4befe")
    (text      . "#cdd6f4")
    (const     . "#96defa")
    (var       . "#ff6ba9")
    (subtext1  . "#bac2de")
    (subtext0  . "#a6adc8")
    (overlay2  . "#9399b2")
    (overlay1  . "#7f849c")
    (overlay0  . "#6c7086")
    (comment   . "#7a95a0")
    (surface2  . "#585b70")
    (surface1  . "#45475a")
    (surface0  . "#313244")
    (base      . "#1e1e2e")
    (base1     . "#1a1a2a")
    (warning   . "#e81050")
    (mantle    . "#181825")
    (crust     . "#11111b"))
  "Mistletoe palette.")

;; Helper for palette lookup
(defun mistletoe-color (name)
  (cdr (assoc name mistletoe-colors)))

;; Define faces
(custom-theme-set-faces
 'mistletoe
 `(default ((t (:background ,(mistletoe-color 'base)
                :foreground ,(mistletoe-color 'text)))))
 `(cursor ((t (:background ,(mistletoe-color 'teal)))))
 `(mode-line ((t (:background ,(mistletoe-color 'mantle)
                  :foreground ,(mistletoe-color 'text)))))
 `(mode-line-inactive ((t (:background ,(mistletoe-color 'crust)
				       :foreground ,(mistletoe-color 'overlay0)))))
 `(mode-line-buffer-id ((t (:foreground ,(mistletoe-color 'orange)))))
 `(fringe ((t (:background ,(mistletoe-color 'base)
			   :foreground ,(mistletoe-color 'surface1)))))
 `(vertical-border ((t (:foreground ,(mistletoe-color 'teal)))))
 `(minibuffer-prompt ((t (:foreground ,(mistletoe-color 'teal)))))
 `(link ((t (:foreground ,(mistletoe-color 'teal)))))
 `(line-number ((t (:foreground ,(mistletoe-color 'surface1)))))
 `(line-number-current-line ((t (:foreground ,(mistletoe-color 'teal)))))

 ;; Dashboard
 `(dashboard-startup-banner ((t (:foreground ,(mistletoe-color 'teal)))))
 `(dashboard-banner-logo-title ((t (:foreground ,(mistletoe-color 'teal)))))
 `(dashboard-heading ((t (:foreground ,(mistletoe-color 'magenta)))))
 `(dashboard-footer ((t (:foreground ,(mistletoe-color 'teal)))))
 
 ;; Highlight faces
 `(region ((t (:background ,(mistletoe-color 'surface1)))))
 `(highlight ((t (:background ,(mistletoe-color 'surface0)))))
 `(hl-line ((t (:background ,(mistletoe-color 'surface0)))))
 `(isearch ((t (:background ,(mistletoe-color 'peach)
                   :foreground ,(mistletoe-color 'crust)))))
 `(lazy-highlight ((t (:background ,(mistletoe-color 'surface2)
                         :foreground ,(mistletoe-color 'text)))))

 ;; Font faces
 `(font-lock-builtin-face ((t (:foreground ,(mistletoe-color 'magenta)))))
 `(font-lock-negation-char-face ((t (:foreground ,(mistletoe-color 'const)))))
 `(font-reference-face ((t (:foreground ,(mistletoe-color 'const)))))
 `(font-lock-constant-face ((t (:foreground ,(mistletoe-color 'const)))))
 `(font-lock-doc-face ((t (:foreground ,(mistletoe-color 'const)))))
 `(font-lock-function-name-face ((t (:foreground ,(mistletoe-color 'teal)))))
 `(font-lock-keyword-face ((t (:foreground ,(mistletoe-color 'magenta)))))
 `(font-lock-string-face ((t (:foreground ,(mistletoe-color 'green)))))
 `(font-lock-type-face ((t (:foreground ,(mistletoe-color 'teal)))))
 `(font-lock-variable-name-face ((t (:foreground ,(mistletoe-color 'var)))))
 `(font-lock-warning-face ((t (:foreground ,(mistletoe-color 'warning)))))
 `(font-lock-comment-face ((t (:foreground ,(mistletoe-color 'comment)
			       :slant italic))))
 `(font-lock-comment-delimiter-face ((t (:foreground ,(mistletoe-color 'comment)
                                         :slant italic))))

 ;; Org Fonts
 `(org-code ((t (:foreground ,(mistletoe-color 'lavender)))))
 `(org-level-1 ((t (:foreground ,(mistletoe-color 'blue)
                     :weight bold :height 1.7))))
 `(org-level-2 ((t (:foreground ,(mistletoe-color 'green)
                     :weight bold :height 1.6))))
 `(org-level-3 ((t (:foreground ,(mistletoe-color 'var)
                     :weight bold :height 1.5))))
 `(org-level-4 ((t (:foreground ,(mistletoe-color 'teal)
                     :weight bold :height 1.4))))
 `(org-level-5 ((t (:foreground ,(mistletoe-color 'yellow)
		     :weight bold :height 1.3))))
 `(org-level-6 ((t (:foreground ,(mistletoe-color 'peach)
		     :weight bold :height 1.2))))
 `(org-level-7 ((t (:foreground ,(mistletoe-color 'mauve)
		     :weight bold :height 1.1))))
 `(org-level-8 ((t (:foreground ,(mistletoe-color 'flamingo)
				:weight bold :height 1.0))))
 `(org-date ((t (:foreground ,(mistletoe-color 'green) :underline t))))

  ;; Org Blocks
 `(org-block ((t (:background ,(mistletoe-color 'base1)
		  :foreground ,(mistletoe-color 'lavender)
		  :extend t))))
   `(org-block-begin-line
   ((t (:background ,(mistletoe-color 'base1)
        :foreground ,(mistletoe-color 'overlay1)
        :height 0.9 :extend t))))
 `(org-block-end-line
   ((t (:background ,(mistletoe-color 'base1)
        :foreground ,(mistletoe-color 'overlay1)
        :height 0.9 :extend t))))
 
 ;; Org Todo
 `(org-todo ((t (:foreground ,(mistletoe-color 'peach)
                 :weight bold))))
 `(org-done ((t (:foreground ,(mistletoe-color 'green)
                 :weight bold))))

 ;; Org Links
 `(org-link ((t (:foreground ,(mistletoe-color 'sapphire)
                  :underline t))))
 `(org-tag ((t (:foreground ,(mistletoe-color 'overlay1)
                 :weight light))))
 
 ;; Org Tables
 `(org-table ((t (:foreground ,(mistletoe-color 'blue)))))
 `(org-quote ((t (:foreground ,(mistletoe-color 'subtext0)
                  :background ,(mistletoe-color 'surface0)
                  :slant italic
                  :extend t))))
 `(org-verbatim ((t (:foreground ,(mistletoe-color 'yellow))))))


;;;###autoload
(when load-file-name
  (add-to-list 'custom-theme-load-path
               (file-name-as-directory
                (file-name-directory load-file-name))))

(provide-theme 'mistletoe)

;;; mistletoe-theme.el ends here

