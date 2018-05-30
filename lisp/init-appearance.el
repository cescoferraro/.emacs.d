;;; init-appearance.el --- theme,fonts and menu      -*- lexical-binding: t; -*-
;; disable toolbar 
(tool-bar-mode -1)
(column-number-mode t)
(menu-bar-mode -1)

(scroll-bar-mode -1)

(defun disable-all-themes ()
  "disable all custom enabled themes"
  (dolist (i custom-enabled-themes)
    (disable-theme i)))

(defadvice load-theme (before disable-themes-first activate)
  (disable-all-themes))

(use-package white-sand-theme
  :ensure t)

(load-theme 'white-sand)
(load-theme 'Beachy)

(global-hl-line-mode t)
(set-frame-font "Source Code Pro 13")


(provide 'init-appearance)

;;; init-appearance.el ends here
