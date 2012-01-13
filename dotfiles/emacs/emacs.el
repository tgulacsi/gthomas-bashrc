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
             (string-match "\\.py\\'" buffer-file-name))
    (pep8)))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(before-save-hook (quote (delete-trailing-whitespace)))
 '(after-save-hook (quote (pyprep)))
 '(column-number-mode t)
 '(custom-enabled-themes (quote (wombat)))
 '(font-use-system-font t)
 '(visible-bell t))
