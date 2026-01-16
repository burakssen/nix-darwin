;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-

;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional
(setq user-full-name "burakssen"
      user-mail-address "burakssen@example.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font where appropriate
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `serif' variable pitch font
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'catppuccin)
(setq catppuccin-flavor 'mocha)

;; Configure icons for catppuccin theme
(after! nerd-icons
  (setq nerd-icons-color-icons t)
  ;; Use catppuccin colors for icons
  (setq nerd-icons-scale-factor 1.0))

;; Custom catppuccin icon colors
(custom-set-faces
 '(nerd-icons-blue ((t (:foreground "#89b4fa"))))
 '(nerd-icons-cyan ((t (:foreground "#94e2d5"))))
 '(nerd-icons-green ((t (:foreground "#a6e3a1"))))
 '(nerd-icons-orange ((t (:foreground "#fab387"))))
 '(nerd-icons-pink ((t (:foreground "#f5c2e7"))))
 '(nerd-icons-purple ((t (:foreground "#cba6f7"))))
 '(nerd-icons-red ((t (:foreground "#f38ba8"))))
 '(nerd-icons-yellow ((t (:foreground "#f9e2af"))))

 ;; Mode line icons
 '(mode-line ((t (:background "#1e1e2e" :foreground "#cdd6f4"))))
 '(mode-line-inactive ((t (:background "#1e1e2e" :foreground "#9399b2"))))

;; Basic treemacs configuration
(setq treemacs-width 30
      treemacs-position 'left)

;; Keybindings for treemacs navigation
(map! :leader
      :desc "Toggle treemacs" "t" #'treemacs
      :desc "Find file in treemacs" "f t" #'treemacs-find-file
      :desc "Open treemacs in current project" "p t" #'treemacs-projectile
      :desc "Go to treemacs" "e" #'treemacs-select-window
      :desc "Go to editor" "f" (lambda () (interactive) (other-window 1)))

;; Global shortcuts for quick switching
(map! :n "C-t" #'treemacs-toggle
      :n "C-w" #'other-window
      :n "<tab>" #'other-window)

;; Alternative single-key leader bindings
(map! :leader
      :desc "Go to treemacs" "0" #'treemacs-select-window
      :desc "Go to editor" "1" (lambda () (interactive) (other-window 1)))

;; Smart window switching functions
(defun goto-treemacs-or-toggle ()
  "Go to treemacs if open, otherwise toggle it open."
  (interactive)
  (if (treemacs-get-local-buffer)
      (if (eq (current-buffer) (treemacs-get-local-buffer))
          (other-window 1)
        (treemacs-select-window))
    (treemacs)))

(defun smart-window-switch ()
  "Smart switch between treemacs and editor windows."
  (interactive)
  (let ((treemacs-buf (treemacs-get-local-buffer)))
    (if (and treemacs-buf (eq (current-buffer) treemacs-buf))
        (other-window 1)
      (treemacs-select-window))))

;; Debounced window switching functions
(defun debounced-smart-window-switch ()
  "Debounced smart window switch to prevent repeat issues."
  (interactive)
  (my-debounce #'smart-window-switch 0.2))

(defun debounced-goto-treemacs-or-toggle ()
  "Debounced treemacs toggle to prevent repeat issues."
  (interactive)
  (my-debounce #'goto-treemacs-or-toggle 0.2))

;; Even easier keybindings
(map! :leader
      :desc "Smart window switch" "w" #'debounced-smart-window-switch
      :desc "Quick treemacs toggle" "q" #'debounced-goto-treemacs-or-toggle)

;; Vim-style window navigation with debouncing
(defun debounced-windmove (direction)
  "Debounced windmove in DIRECTION to prevent repeat issues."
  (interactive)
  (my-debounce (lambda () (windmove direction)) 0.15))

(map! :n "C-w h" (lambda () (interactive) (debounced-windmove 'left))
      :n "C-w l" (lambda () (interactive) (debounced-windmove 'right))
      :n "C-w j" (lambda () (interactive) (debounced-windmove 'down))
      :n "C-w k" (lambda () (interactive) (debounced-windmove 'up))
      :n "C-w w" #'debounced-smart-window-switch)

;; Prevent accidental repeats
(setq echo-keystrokes 0.01
      idle-update-delay 0.5
      fast-but-imprecise-scrolling t)

;; Use Command key as leader on macOS
(when (eq system-type 'darwin)
  (setq mac-command-modifier 'super
        mac-option-modifier 'meta
        mac-control-modifier 'control)

  ;; Set Command key as leader for treemacs operations
  (setq doom-localleader-key "s-"
        doom-leader-key "s-")

  ;; Configure Command key bindings for treemacs
  (map! :map 'global
        :desc "Smart window switch" "s-w" #'debounced-smart-window-switch
        :desc "Toggle treemacs" "s-t" #'debounced-goto-treemacs-or-toggle
        :desc "Go to treemacs" "s-e" #'treemacs-select-window
        :desc "Find file in treemacs" "s-f" #'treemacs-find-file)

  ;; Additional Command key shortcuts for macOS
  (map! :map 'global
        :desc "Go to treemacs" "s-0" #'treemacs-select-window
        :desc "Go to editor" "s-1" (lambda () (interactive) (other-window 1))
        :desc "Other window" "s-[" #'other-window
        :desc "Toggle treemacs focus" "s-p" #'debounced-goto-treemacs-or-toggle)

  ;; Keep SPC as fallback option
  (map! :leader
        :desc "Smart window switch" "w" #'debounced-smart-window-switch
        :desc "Toggle treemacs" "t" #'debounced-goto-treemacs-or-toggle
        :desc "Go to treemacs" "e" #'treemacs-select-window
        :desc "Find file in treemacs" "f" #'treemacs-find-file))

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative`.
(setq display-line-numbers-type 'relative)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; Keybindings
(map! :leader
      :desc "Find file" "f f" #'find-file
      :desc "Recent files" "f r" #'recentf-open-files)

;; Dashboard
(setq +doom-dashboard-banner-file "doom-emacs-color.png")

;; Performance optimizations
(setq gc-cons-threshold 100000000) ; 100MB
      read-process-output-max (* 1024 1024) ; 1MB
      confirm-kill-emacs nil
      org-startup-indented t
      org-pretty-entities t)

;; Prevent key repeat issues
(setq auto-repeat-mode nil
      key-repeat-mode nil
      repeat-mode nil)

;; Disable auto repeat for navigation keys
(defun disable-key-repeat ()
  "Disable key repeat to prevent broken flow."
  (setq auto-repeat-mode -1))
(add-hook 'after-init-hook #'disable-key-repeat)

;; Debounce functions to prevent rapid execution
(defvar my-debounce-timer nil)

(defun my-debounce (func delay)
  "Debounce FUNC to only run once within DELAY seconds."
  (when my-debounce-timer
    (cancel-timer my-debounce-timer))
  (setq my-debounce-timer
        (run-with-timer delay nil func)))

;; Mouse scrolling
(global-set-key (kbd "<mouse-4>") 'scroll-down-line)
(global-set-key (kbd "<mouse-5>") 'scroll-up-line)