(add-to-list 'load-path (concat user-emacs-directory "config"))
(add-to-list 'load-path (concat user-emacs-directory "config" "/languages"))

;; packages
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("org" . "http://orgmode.org/elpa/")
                         ;; ("marmalade" . "http://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")))

(byte-recompile-directory "~/.emacs.d")
(require 'package)
(package-initialize)

(setq package-enable-at-startup nil)
(unless (package-installed-p 'use-package)
	(package-refresh-contents)
	(package-install 'use-package))

(require 'use-package)

(require 'my-core)
(require 'auto-complete)
(require 'go-mode)

(require 'my-dired)
(require 'my-buffers)
(require 'my-magit)
(require 'my-package-list)

(require 'my-evil)

(load-theme 'misterioso t)

;; save bookmarks
(setq bookmark-default-file "~/.emacs.d/bookmarks"
      bookmark-save-flag 1) ;; save after every change

(require 'smooth-scrolling)
(setq smooth-scroll-margin 5)
(setq scroll-conservatively 9999
      scroll-preserve-screen-position t)

(require 'powerline)
(powerline-evil-vim-color-theme)
(display-time-mode t)


;; flycheck
(require 'flycheck)
(add-hook 'after-init-hook #'global-flycheck-mode)

(setq flycheck-check-syntax-automatically '(save mode-enabled))
(setq flycheck-checkers (delq 'emacs-lisp-checkdoc flycheck-checkers))
(setq flycheck-checkers (delq 'html-tidy flycheck-checkers))
(setq flycheck-standard-error-navigation nil)

(global-flycheck-mode t)

;; flycheck errors on a tooltip (doesnt work on console)
(when (display-graphic-p (selected-frame))
  (eval-after-load 'flycheck
    '(custom-set-variables
      '(flycheck-display-errors-function #'flycheck-pos-tip-error-messages))))


(define-key global-map (kbd "RET") 'newline-and-indent)
(setq make-backup-files nil)

(setq save-place-file "~/.emacs.d/saveplace")
(setq-default save-place t)
(require 'saveplace)

(add-hook 'text-mode-hook (lambda ()
                            (turn-on-auto-fill)
                            (fci-mode)
                            (set-fill-column 78)))
(add-hook 'markdown-mode-hook (lambda ()
                            (turn-on-auto-fill)
                            (fci-mode)
                            (set-fill-column 78)))

(add-hook 'python-mode-hook (lambda ()
                              (fci-mode)
                              (set-fill-column 78)))

(add-hook 'go-mode-hook (lambda ()
                         (fci-mode)
			 (setq indent-tabs-mode t)
			 (setq tab-width 4)
                         (set-fill-column 78)))


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(create-lockfiles nil)
 '(tab-width 4))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(evil-mode 1)
