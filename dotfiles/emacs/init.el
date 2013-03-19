;; disable lockfile
(setq create-lockfiles nil)

(setq viper-mode t)
(require 'viper)
(line-number-mode t)
(column-number-mode t)

;;; Auto-save
;;; Load the auto-save.el package, which lets you put all of your autosave
;;; files in one place, instead of scattering them around the file system.
;;; M-x recover-all-files or M-x recover-file to get them back
(defvar temp-dir (concat "/tmp/" (user-login-name)))
(make-directory temp-dir t)

; One of the main issues for me is that my home directory is
; NFS mounted.  By setting all the autosave directories in /tmp,
; things run much quicker
(defvar auto-save-dir (concat temp-dir "/autosaves"))
(make-directory auto-save-dir t)

(setq auto-save-hash-directory (concat temp-dir "/autosave-hash"))
(setq auto-save-directory-fallback "/tmp/")
(setq auto-save-list-file-prefix auto-save-dir)
(setq auto-save-file-name-transforms `((".*" ,auto-save-dir t)))
(setq auto-save-hash-p nil)
(setq auto-save-timeout 100)
(setq auto-save-interval 300)
;(require 'auto-save)

;;; Put backups in another directory.  With the directory-info
;;; variable, you can control which files get backed up where.
;(require 'backup-dir)
;; Don't clutter up directories with files~
(defvar backup-dir (concat temp-dir "/backups"))
(make-directory backup-dir t)
(setq backup-directory-alist (list (cons "." backup-dir)))

;; Don't clutter with #files either
(setq auto-save-file-name-transforms 
	  `((".*" ,(expand-file-name auto-save-dir))))

(setq make-backup-files nil
	  backup-by-copying t
	  backup-by-copying-when-mismatch t
	  backup-by-copying-when-linked t
	  version-control t)
(setq-default delete-old-versions t)
(add-to-list 'backup-directory-alist '(".*" . backup-directory))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes (quote ("d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" default)))
 '(make-backup-files nil)
 '(python-mode-hook (quote ((lambda nil (flycheck-mode t)) (lambda nil (indent-tabs-mode nil)))))
 '(tab-width 4)
 '(vc-suppress-confirm t))
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

(add-hook 'after-init-hook #'(lambda() (golden-ratio-enable)))

(add-hook 'python-mode-hook #'(lambda() (flycheck-mode t) (indent-tabs-mode nil)))
(add-hook 'go-mode-hook #'(lambda() (flycheck-mode t) (indent-tabs-mode t)))

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

