;;; ~/.doom.d/packages.el -*- lexical-binding: t; -*-

;; To install a package with Doom you must declare them here and run 'doom sync'
;; on the command line, then restart Emacs for the changes to take effect -- or
;; use 'doom refresh' and then the 'refresh' keybinding.

;; All of Doom's packages are pinned to a specific version and updated with
;; 'doom sync'. To unpin and track a Git branch of a package, use M-x
;; `doom/packages/unpin'. You can also use `doom/packages/update' to pull
;; the latest updates without syncing.

;; Additional packages that aren't in the Doom core
(package! catppuccin-theme)
(package! nerd-icons)

;; To install FROM-SOURCE a package that isn't on MELSA, use:
;; (package! some-package :recipe (:fetcher github :repo "username/repo"))

;; To install a package directly from a specific Git repo, you can do:
;; (package! some-package :recipe (:host github :repo "username/repo"))