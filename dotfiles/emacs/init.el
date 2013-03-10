;(setq viper-mode t)
;(require 'viper)
(line-number-mode t)
(column-number-mode t)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(tab-width 4))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(add-to-list 'load-path "/usr/local/go/misc/emacs/" t)
  (require 'go-mode-load)

(add-to-list 'auto-mode-alist '("\\.go" . go-mode))
(add-to-list 'auto-mode-alist '("\\.py" . python-mode))

(add-hook 'after-init-hook #'(lambda() (flycheck-mode t)
			       (golden-ratio-enable)))

;; packages
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                           ("marmalade" . "http://marmalade-repo.org/packages/")
                           ("melpa" . "http://melpa.milkbox.net/packages/")))

(defun package-update-load-path ()
  "Update the load path for newly installed packages."
  (interactive)
  (let ((package-dir (expand-file-name package-user-dir)))
    (mapc (lambda (pkg)
            (let ((stem (symbol-name (car pkg)))
		    (version "")
		      (first t)
		        path)
	            (mapc (lambda (num)
			          (if first
				        (setq first nil)
				      (setq version (format "%s." version)))
				        (setq version (format "%s%s" version num)))
			      (aref (cdr pkg) 0))
              (setq path (format "%s/%s-%s" package-dir stem version))
              (add-to-list 'load-path path)))
          package-alist)))

