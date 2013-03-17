;; disable tool and Menu bar:

(tool-bar-mode -1)
(menu-bar-mode -1)

;; disable scroll bar , load-battery. :

(scroll-bar-mode -1)
(display-battery-mode 1)

;;(add-to-list 'load-path "~/.emacs.d/evil-setup.el")

(add-to-list 'load-path "~/.emacs.d/")

;; add repos for elpa

(require 'package)

(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
			 ("marmalade" . "http://marmalade-repo.org/packages/")
			 ("melpa" . "http://melpa.milkbox.net/packages/")))

(package-initialize)

;; end of elpa setup

;; add key-chords
(require 'key-chord)
(key-chord-mode 1)

;; evil setup:
(require 'evil-setup)

;; set theme :
(load-theme 'gruber-darker t)


;; add winner-mode
(winner-mode 1)

;; add auto-complete
(require 'auto-complete-extension)
(auto-complete-mode 1)
;; end of auto-complete setup



;; use y/n instead of yes / no:
(defalias 'yes-or-no-p 'y-or-n-p)

;; flymake-mode for haskell:
(require 'flymake)

(defun flymake-Haskell-init ()
  (flymake-simple-make-init-impl
   'flymake-create-temp-with-folder-structure nil nil
   (file-name-nondirectory buffer-file-name)
   'flymake-get-Haskell-cmdline))

(defun flymake-get-Haskell-cmdline (source base-dir)
  (list "flycheck_haskell.pl"
	(list source base-dir)))

(push '(".+\\.hs$" flymake-Haskell-init flymake-simple-java-cleanup)
      flymake-allowed-file-name-masks)
(push '(".+\\.lhs$" flymake-Haskell-init flymake-simple-java-cleanup)
      flymake-allowed-file-name-masks)
(push
 '("^\\(\.+\.hs\\|\.lhs\\):\\([0-9]+\\):\\([0-9]+\\):\\(.+\\)"
   1 2 3 4) flymake-err-line-patterns)

;; optional setting
;; if you want to use flymake always, then add the following hook.
(add-hook
 'haskell-mode-hook
 '(lambda ()
    (if (not (null buffer-file-name)) (flymake-mode))))

(add-hook 'haskell-mode-hook 'flymake-hlint-load)

;; enable ido-mode:
(setq ido-enable-flex-matching t)
  (setq ido-everywhere t)
  (ido-mode 1)

;; toggle window-split:

(defun toggle-window-split ()
  (interactive)
  (if (= (count-windows) 2)
      (let* ((this-win-buffer (window-buffer))
             (next-win-buffer (window-buffer (next-window)))
             (this-win-edges (window-edges (selected-window)))
             (next-win-edges (window-edges (next-window)))
             (this-win-2nd (not (and (<= (car this-win-edges)
                                         (car next-win-edges))
                                     (<= (cadr this-win-edges)
                                         (cadr next-win-edges)))))
             (splitter
              (if (= (car this-win-edges)
                     (car (window-edges (next-window))))
                  'split-window-horizontally
                'split-window-vertically)))
        (delete-other-windows)
        (let ((first-win (selected-window)))
          (funcall splitter)
          (if this-win-2nd (other-window 1))
          (set-window-buffer (selected-window) this-win-buffer)
          (set-window-buffer (next-window) next-win-buffer)
          (select-window first-win)
          (if this-win-2nd (other-window 1))))))

