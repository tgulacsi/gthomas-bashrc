;(add-to-list 'package-archives
;            '("elpa" . "http://tromey.com/elpa/"))
;(add-to-list 'package-archives
;             '("marmalade" . "http://marmalade-repo.org/
(require 'package)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
;; eVil
(add-to-list 'load-path "~/.emacs.d/external/evil")
(require 'evil)
(evil-mode 1)
;; solarized
;(add-to-list 'load-path "~/.emacs.d/external/solarized")
;(add-to-list 'custom-theme-load-path "~/.emacs.d/external/solarized")
;(require 'solarized-dark-theme)
;(require 'solarized-light-theme)
;; py pep8
(defun pyprep ()
  (when (and (stringp buffer-file-name)
             (string-match "\\.py\\'" buffer-file-name)
	     (functionp 'pep8))
    (pep8)))

(autoload 'lua-mode "lua-mode" "Lua editing mode." t)
    (add-to-list 'auto-mode-alist '("\\.lua$" . lua-mode))
    (add-to-list 'interpreter-mode-alist '("lua" . lua-mode))

(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector ["#2e3436" "#a40000" "#4e9a06" "#c4a000" "#204a87" "#5c3566" "#729fcf" "#eeeeec"])
 '(before-save-hook (quote (delete-trailing-whitespace)))
 '(after-save-hook (quote (pyprep)))
 '(blink-matching-delay 2)
 '(column-number-mode t)
 '(custom-enabled-themes (quote (adwaita)))
 '(font-use-system-font t)
 '(visible-bell t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(paren-blink-off ((t nil)) t)
 '(paren-mismatch-face ((t nil)) t))
