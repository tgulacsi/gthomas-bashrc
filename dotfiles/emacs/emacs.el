(server-mode 1)
(add-to-list 'load-path "~/.emacs.d/evil")
(require 'evil)
(evil-mode 1)
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(evil-mode t)
 '(font-use-system-font t)
 '(global-hl-line-mode t)
 '(global-linum-mode t)
 '(global-whitespace-mode t)
 '(inhibit-startup-screen t)
 '(major-mode (quote evil-local-mode))
 '(menu-bar-mode t)
 '(python-check-command "flake8")
 '(server-mode t)
 '(show-paren-mode t)
 '(whitespace-action nil)
 '(whitespace-global-modes (quote (not))))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )
