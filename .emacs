;; Frame size and font color
(defun frame2 ()
   (interactive "")
   (set-frame-width (selected-frame) 174) ;; 164 originally
 )
(defun frame80 ()
   (interactive "")
   (set-frame-width (selected-frame) 85) ;; 80 originally
 )

(when (display-graphic-p)
  (invert-face 'default)
  (frame80)
)

;;
(setq column-number-mode t)

(add-to-list 'load-path "~/.emacs.d/plugins/yasnippet-0.6.1c")
(require 'yasnippet)
(yas/initialize)
(yas/load-directory "~/.emacs.d/snippets")


(add-to-list 'auto-coding-regexp-alist '("coding: UTF-8" . utf-8) t)
;(add-to-list 'auto-coding-regexp-alist '("coding: utf8" . utf-8) t)

(setq inhibit-splash-screen t)

;(add-to-list 'load-path "/usr/share/emacs/23.1/site-lisp/geben") ; Geben directory
;(require 'geben)


;;----------- html5-el mode from https://github.com/hober/html5-el
;;
;(add-to-list 'load-path "~/.emacs.d/html5-el/")
;(eval-after-load "rng-loc"
;  '(add-to-list 'rng-schema-locating-files "~/.emacs.d/html5-el/schemas.xml"))
;(require 'whattf-dt)


;;--------- .emacs -----------
;; adds ~/.elisp/lyqi in the load path
(setq load-path (cons (expand-file-name "~/.emacs.d/lyqi") load-path))

;; when loading LilyPond-mode, lyqi-mode library will also be loaded.
;; type `C-c q' in LilyPond-mode to switch to lyqi-mode.
(eval-after-load "lilypond-mode"
  '(progn
     (load-library "lyqi-mode")
     (define-key LilyPond-mode-map "\C-cq" 'lyqi-mode)))


;; PHP modes

;(add-to-list 'load-path "~/.emacs.d") ; Geben directory
;(load "~/.emacs.d/nxhtml/autostart.el")
;(autoload 'php-mode "php-mode" "Major mode for editing php code." t)
(add-to-list 'auto-mode-alist '("\\.php$" . php-mode))
(add-to-list 'auto-mode-alist '("\\.inc$" . php-mode))
(add-to-list 'auto-mode-alist '("\\.module$" . php-mode))
(add-to-list 'auto-mode-alist '("\\.mako$" . mako-html-mumamo-mode))
;(add-to-list 'auto-mode-alist '("\\.html$" . mako-html-mumamo-mode))

;;  Bind "Ctrl+C é" to sgml-close-tag
(add-hook 'html-mode-hook
 (lambda ()
  (local-set-key (kbd "C-c é") 'sgml-close-tag)
 )
)

;; Load less-css-mode
(load-file "~/.emacs.d/less-css-mode/less-css-mode.el")



;; I hate tabs!
;(setq tab-width 8)
;(setq indent-tabs-mode t)
(setq-default indent-tabs-mode nil)


;; Don't open a new window for debugging Emacs stuff..
(setq debug-on-error nil)

;; When doing a presentation:
;;(set-face-attribute 'default nil :height 150)



;; To allow time tracking
;;
(add-hook 'window-configuration-change-hook
	  (lambda ()
	    (setq frame-title-format
		  (concat
		   invocation-name "@" system-name ": "
		   (replace-regexp-in-string
		    (concat "/home/" user-login-name) "~"
		    (or buffer-file-name "%b"))))))


;; http://stackoverflow.com/questions/4177929/how-to-change-the-indentation-width-in-emacs-javascript-mode
(setq js-indent-level 2)

;; Of my own discovery!
(setq css-indent-offset 2)





;; Load Zencoding, from https://github.com/rooney/zencoding
(add-to-list 'load-path "~/.emacs.d/zencoding")
(require 'zencoding-mode)
(add-hook 'sgml-mode-hook 'zencoding-mode) ;; Auto start on any markup modes
(setq-default zencoding-indentation 2)

;; Load desktop menu
(load "~/.emacs.d/desktop-menu.el")
(require 'desktop-menu)

;; Load dart-mode stuff
(autoload 'dart-mode "dart-mode" "Edit Dart code." t)
(add-to-list 'auto-mode-alist '("\\.dart$" . dart-mode))

;; Ctrl+PageUp and Down, to move inside
(put 'scroll-left 'disabled nil)

;; Takeout tailing whitespaces upon save
(add-hook 'before-save-hook 'delete-trailing-whitespace)

; From: https://github.com/daleharvey/jshint-mode
(add-to-list 'load-path "~/.emacs.d/jshint-mode")
(require 'flymake-jshint)
(add-hook 'javascript-mode-hook
    (lambda () (flymake-mode t)))


; Dart mode
(add-to-list 'load-path "~/.emacs.d/dart-mode")
(require 'dart-mode)
(add-to-list 'auto-mode-alist '("\\.dart\\'" . dart-mode))


(load-file "~/.emacs.d/pycoverage.el/pycov2.el")
;(require 'linum)
;(require 'pycov2)
;(add-hook 'python-mode-hook
;	  (function (lambda ()
;		      (pycov2-mode)
;		      (linum-mode))))


;
; Coffee stuff, from: https://github.com/jonathanchu/emacs/tree/master/vendor/coffee-mode
;
; watch out.. does this affect the whole world ?
(setq coffee-tab-width 2)
(add-to-list 'load-path "~/.emacs.d/coffee-mode")
(require 'coffee-mode)

(add-to-list 'auto-mode-alist '("\\.coffee$" . coffee-mode))
(add-to-list 'auto-mode-alist '("Cakefile" . coffee-mode))


;;
;; Auto-load Ido
(ido-mode 1)

;;
;; From http://www.deeplearning.net/software/theano/dev_start_guide.html#emacs
;;
;; Mandatory
(load-file "~/.emacs.d/emacs-for-python/epy-init.el")
(add-to-list 'load-path "~/.emacs.d/emacs-for-python/") ;; tell where to load the various files

;; Each of them enables different parts of the system.
;; Only the first two are needed for pep8, syntax check.
(require 'epy-setup) ;; It will setup other loads, it is required!
(require 'epy-python) ;; If you want the python facilities [optional]
(require 'epy-completion) ;; If you want the autocompletion settings [optional]
(require 'epy-editing) ;; For configurations related to editing [optional]

;; Define f10 to previous error
;; Define f11 to next error
(require 'epy-bindings) ;; For my suggested keybindings [optional]

;; Some shortcut that do not collide with gnome-terminal,
;; otherwise, "epy-bindings" define f10 and f11 for them.
(global-set-key [f2] 'flymake-goto-prev-error)
(global-set-key [f3] 'flymake-goto-next-error)

;; Next two lines are the checks to do. You can add more if you wish.
;(epy-setup-checker "pyflakes %f") ;; For python syntax check
;(epy-setup-checker "pep8 -r %f") ;; For pep8 check

;; Disable auto-pairing, from https://github.com/gabrielelanaro/emacs-for-python
(setq skeleton-pair nil)

;; Ledger stuff
(add-to-list 'load-path "/home/abourget/build/ledger/lisp")
(require 'ledger-mode)
(add-to-list 'auto-mode-alist '("\\.ledger$" . ledger-mode))
(set-variable 'ledger-highlight-xact-under-point 'nil)
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
'(ledger-reports (quote (("bal" "ledger -f %(ledger-file) bal") ("reg" "ledger -f %(ledger-file) reg") ("payee" "ledger -f %(ledger-file) reg -- %(payee)") ("account" "ledger -f %(ledger-file) reg %(account)") ("epargne" "ledger -f main.ledger bal assets:savings")))))


;; Tweaks for tmux's support for Ctrl+arrows
;; http://marc-abramowitz.com/archives/2006/10/05/ctrl-left-and-ctrl-right-in-bash-and-emacs/
(global-set-key "\M-[1;5C"    'forward-word)      ; Ctrl+right   => forward word
(global-set-key "\M-[1;5D"    'backward-word)     ; Ctrl+left    => backward word

;
; Cycle through windows backwards with C-x p
(defun prev-window ()
  (interactive)
  (other-window -1))

(define-key global-map (kbd "C-x p") 'prev-window)

;
; Duplicate current line when indenting comments
;  From: http://stackoverflow.com/questions/88399/how-do-i-duplicate-a-whole-line-in-emacs/88440
;
(defun duplicate-line (arg)
  "Duplicate current line, leaving point in lower line."
  (interactive "*p")

  ;; save the point for undo
  (setq buffer-undo-list (cons (point) buffer-undo-list))

  ;; local variables for start and end of line
  (let ((bol (save-excursion (beginning-of-line) (point)))
        eol)
    (save-excursion

      ;; don't use forward-line for this, because you would have
      ;; to check whether you are at the end of the buffer
      (end-of-line)
      (setq eol (point))

      ;; store the line and disable the recording of undo information
      (let ((line (buffer-substring bol eol))
            (buffer-undo-list t)
            (count arg))
        ;; insert the line arg times
        (while (> count 0)
          (newline)         ;; because there is no newline in 'line'
          (insert line)
          (setq count (1- count)))
        )

      ;; create the undo information
      (setq buffer-undo-list (cons (cons eol (point)) buffer-undo-list)))
    ) ; end-of-let

  ;; put the point in the lowest line and return
  (next-line arg))
(global-set-key (kbd "C-d") 'duplicate-line)


;; ack-and-a-half search
(add-to-list 'load-path (expand-file-name "~/.emacs.d/ack-and-a-half"))
(require 'ack-and-a-half)
(define-key global-map (kbd "C-F") 'ack-and-a-half)
; remember M-g (M-)n and M-g (M-)p for previous and next errors. which skips
; from one ack-outputted filename to the next.. highlighting, etc.. awesome!



;; SCSS support
(add-to-list 'load-path (expand-file-name "~/.emacs.d/scss-mode"))
(autoload 'scss-mode "scss-mode")
(add-to-list 'auto-mode-alist '("\\.scss\\'" . scss-mode))
(add-to-list 'auto-mode-alist '("\\.sass\\'" . scss-mode))
(set-variable 'scss-compile-at-save 'nil)

;; YAML mode
(add-to-list 'load-path (expand-file-name "~/.emacs.d/yaml-mode"))
(autoload 'yaml-mode "yaml-mode")
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))

;; Fixup accents, as per: https://bugs.launchpad.net/emacs-snapshot/+bug/1251176
(require 'iso-transl)


;; Add go-mode.el
(add-to-list 'load-path (expand-file-name "~/.emacs.d/go-mode"))
(require 'go-mode-load)
;; From: http://dominik.honnef.co/posts/2013/03/writing_go_in_emacs/
(add-hook 'go-mode-hook (lambda ()
                          (local-set-key (kbd "M-.") 'godef-jump)))
(add-hook 'go-mode-hook (lambda ()
                          (local-set-key (kbd "C-c C-f") 'gofmt)))
(add-hook 'go-mode-hook (lambda ()
                          (local-set-key (kbd "C-c C-r") 'go-remove-unused-imports)))
(add-hook 'go-mode-hook (lambda ()
                          (setq tab-width 4)))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/go-autocomplete"))
(require 'go-autocomplete)
(require 'auto-complete-config)
