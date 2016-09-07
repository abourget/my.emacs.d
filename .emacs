;;; package -- My own .emacs file - @bourgetalexndre

(add-to-list 'load-path (expand-file-name "~/.emacs.d/lisp"))


;; From: http://stable.melpa.org/#/getting-started
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://stable.melpa.org/packages/"))
(package-initialize) ;; You might already have this line

;; Bookmarks remapping
;;(define-key global-map (kbd "C-x r j") 'jump-to-register)  this is the default
(define-key global-map (kbd "M-g m") 'bookmark-set)
(define-key global-map (kbd "M-g j") 'bookmark-jump)
(define-key global-map (kbd "M-g l") 'bookmark-bmenu-list)


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

;; Take out the toolbar
(tool-bar-mode -1)

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

;  buffer-mode from http://www.emacswiki.org/cgi-bin/wiki/buffer-move.el
(require 'buffer-move)
(require 'windmove)
(windmove-default-keybindings 'meta)



;;--------- .emacs -----------
;; adds ~/.elisp/lyqi in the load path
;(setq load-path (cons (expand-file-name "~/.emacs.d/lyqi") load-path))

;; when loading LilyPond-mode, lyqi-mode library will also be loaded.
;; type `C-c q' in LilyPond-mode to switch to lyqi-mode.
;(eval-after-load "lilypond-mode"
;  '(progn
;     (load-library "lyqi-mode")
;     (define-key LilyPond-mode-map "\C-cq" 'lyqi-mode)))


;(autoload 'php-mode "php-mode" "Major mode for editing php code." t)
;(add-to-list 'auto-mode-alist '("\\.php$" . php-mode))
;(add-to-list 'auto-mode-alist '("\\.inc$" . php-mode))
;(add-to-list 'auto-mode-alist '("\\.module$" . php-mode))
;(add-to-list 'auto-mode-alist '("\\.mako$" . mako-html-mumamo-mode))
;(add-to-list 'auto-mode-alist '("\\.html$" . mako-html-mumamo-mode))

(load "~/.emacs.d/web-mode/web-mode.el")
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))

(setq-default web-mode-enable-auto-quoting nil)

;;  Helper to close tags
(add-hook 'web-mode-hook
 (lambda ()
  (local-set-key (kbd "C-c é") 'web-mode-element-close)
  (local-set-key (kbd "C-c C-l") 'font-lock-fontify-buffer)
 )
)


;; Load less-css-mode
;(load-file "~/.emacs.d/less-css-mode/less-css-mode.el")



;; I hate tabs!
;(setq tab-width 8)
;(setq indent-tabs-mode t)
(setq-default indent-tabs-mode nil)


;; Don't open a new window for debugging Emacs stuff..
(setq debug-on-error nil)

;; WHEN DOING PRESENTATIONS:
;; (set-face-attribute 'default nil :height 220)  ;; At 1080
;; (set-face-attribute 'default nil :height 150)  ;; 1024x768
;; (set-face-attribute 'default nil :height 120)  ;; Standard
;; (invert-face 'default)
;; END PRESENTATIONS


(defcustom mytitle "abourget" "My own titlebar tag")
;; To allow time tracking
(setq mytitle "bob")
;;
(add-hook 'window-configuration-change-hook
	  (lambda ()
	    (setq frame-title-format
		  (concat
		   mytitle "@" system-name ": "
		   (replace-regexp-in-string
		    (concat "/home/" user-login-name) "~"
		    (or buffer-file-name "%b"))))))


;; http://stackoverflow.com/questions/4177929/how-to-change-the-indentation-width-in-emacs-javascript-mode
;(setq js-indent-level 2)

;; Of my own discovery!
;(setq css-indent-offset 2)


;; PowerShell stuff
(autoload 'powershell "powershell" "Start an interactive shell of Powershell." t)
(add-to-list 'auto-mode-alist '("\\.ps1\\'" . powershell-mode)) ; PowerShell script


;; Load Zencoding, from https://github.com/rooney/zencoding
;(add-to-list 'load-path "~/.emacs.d/zencoding")
;(require 'zencoding-mode)
;(add-hook 'sgml-mode-hook 'zencoding-mode) ;; Auto start on any markup modes
;(setq-default zencoding-indentation 2)

;; Load desktop menu
(load "~/.emacs.d/lisp/desktop-menu.el")
(require 'desktop-menu)

;; Ctrl+PageUp and Down, to move inside
(put 'scroll-left 'disabled nil)

;; Takeout tailing whitespaces upon save
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;;
;; NOTE: FLYCHECK was INSTALLED WITH "package-install" "flycheck"
;;
;; Enable FlyCheck throughout
(add-hook 'after-init-hook (lambda()
  (global-flycheck-mode)
  (global-set-key (kbd "M-g M-l") 'flycheck-list-errors)
  (global-set-key (kbd "M-g l") 'flycheck-list-errors)
))


;; Hide/Show mode
(add-hook 'js-mode-hook
 (lambda ()
   (local-set-key (kbd "C-c <right>") 'hs-show-block)
   (local-set-key (kbd "C-c <left>") 'hs-hide-block)
   (local-set-key (kbd "C-c <up>") 'hs-hide-all)
   (local-set-key (kbd "C-c <down>") 'hs-show-all)
   (local-set-key (kbd "C-c <") 'hs-toggle-hiding)
   (hs-minor-mode t)
   (flycheck-select-checker 'javascript-jshint)
 )
)

;; Load dart-mode stuff
;(autoload 'dart-mode "dart-mode" "Edit Dart code." t)
;(add-to-list 'auto-mode-alist '("\\.dart$" . dart-mode))
; Dart mode
;(add-to-list 'load-path "~/.emacs.d/dart-mode")
;(require 'dart-mode)
;(add-to-list 'auto-mode-alist '("\\.dart\\'" . dart-mode))


;(load-file "~/.emacs.d/lisp/pycoverage.el/pycov2.el")
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
;(setq coffee-tab-width 2)
;(add-to-list 'load-path "~/.emacs.d/coffee-mode")
;(require 'coffee-mode)
;(add-to-list 'auto-mode-alist '("\\.coffee$" . coffee-mode))
;(add-to-list 'auto-mode-alist '("Cakefile" . coffee-mode))


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

;; Use Jedi for python jumping around
(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:complete-on-dot t)
(add-hook 'python-mode-hook
          (lambda ()
            (local-set-key (kbd "M-.") 'jedi:goto-definition)))
(add-hook 'python-mode-hook
  (lambda ()
    (local-set-key (kbd "C-c C-j")
      (lambda()
        (jedi:goto-definition 1)
      )
    )
  )
)

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
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ledger-reports (quote (("bal" "ledger -f %(ledger-file) bal") ("reg" "ledger -f %(ledger-file) reg") ("payee" "ledger -f %(ledger-file) reg -- %(payee)") ("account" "ledger -f %(ledger-file) reg %(account)") ("epargne" "ledger -f main.ledger bal assets:savings"))))
 '(safe-local-variable-values (quote ((web-mode-code-indent-offset . 2) (web-mode-css-indent-offset . 2) (web-mode-markup-indent-offset . 2) (web-mode-indent-style . 2) (web-mode-script-padding . 0) (web-mode-style-padding . 0) (sgml-basic-offset . 4)))))


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

;; use `sift` for now, installed with `package-install sift`
;; (define-key global-map (kbd "C-f") 'sift-regexp)

; remember M-g (M-)n and M-g (M-)p for previous and next errors. which skips
; from one ack-outputted filename to the next.. highlighting, etc.. awesome!
; This is to keep an Ack window open, to do Nested searches.
;(define-key global-map (kbd "C-x r") 'rename-uniquely)



;; SCSS support
;(add-to-list 'load-path (expand-file-name "~/.emacs.d/scss-mode"))
;(autoload 'scss-mode "scss-mode")
;(add-to-list 'auto-mode-alist '("\\.scss\\'" . scss-mode))
;(add-to-list 'auto-mode-alist '("\\.sass\\'" . scss-mode))
;(set-variable 'scss-compile-at-save 'nil)

;; YAML mode
(add-to-list 'load-path (expand-file-name "~/.emacs.d/yaml-mode"))
(autoload 'yaml-mode "yaml-mode")
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))

;; Fixup accents, as per: https://bugs.launchpad.net/emacs-snapshot/+bug/1251176
(require 'iso-transl)


;; Quick rename! http://emacsredux.com/blog/2013/05/04/rename-file-and-buffer/
(defun rename-file-and-buffer ()
  "Rename the current buffer and file it is visiting."
  (interactive)
  (let ((filename (buffer-file-name)))
    (if (not (and filename (file-exists-p filename)))
        (message "Buffer is not visiting a file!")
      (let ((new-name (read-file-name "New name: " filename)))
        (cond
         ((vc-backend filename) (vc-rename-file filename new-name))
         (t
          (rename-file filename new-name t)
          (set-visited-file-name new-name t t)))))))
(global-set-key (kbd "C-c r")  'rename-file-and-buffer)

(load "/home/abourget/go/src/golang.org/x/tools/cmd/guru/go-guru.el")

(add-to-list 'load-path "~/.emacs.d/lisp/go-mode.el")

(require 'go-mode)

(require 'go-mode-autoloads)
;; From: http://dominik.honnef.co/posts/2013/03/writing_go_in_emacs/
(add-hook 'go-mode-hook (lambda ()
                          (local-set-key (kbd "M-.") 'godef-jump)))
(add-hook 'go-mode-hook (lambda ()
                          (local-set-key (kbd "C-c C-j") 'godef-jump-other-window)))
(add-hook 'go-mode-hook (lambda ()
                          (local-set-key (kbd "C-c C-f") 'gofmt)))
(add-hook 'go-mode-hook (lambda ()
                          (local-set-key (kbd "C-c C-r") 'go-remove-unused-imports)))
(add-hook 'go-mode-hook (lambda ()
                          (setq tab-width 4)))
(add-hook 'go-mode-hook (lambda ()
                          (local-set-key (kbd "C-c C-c") 'compile)))
(add-hook 'go-mode-hook 'go-eldoc-setup)
(setq gofmt-command "goimports")
;;(add-hook 'before-save-hook #'gofmt-before-save)
;;(remove-hook 'before-save-hook #'gofmt-before-save)
(add-to-list 'load-path (expand-file-name "~/.emacs.d/go-autocomplete"))
(require 'go-autocomplete)
(require 'auto-complete-config)

(add-hook go-mode-hook #'rats-mode)

(load "/home/abourget/go/src/golang.org/x/tools/refactor/rename/go-rename.el")

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


(add-to-list 'load-path (expand-file-name "~/.emacs.d/markdown-mode"))
(autoload 'markdown-mode "markdown-mode"
   "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))
(add-hook 'markdown-mode-hook
 (lambda ()
  (local-set-key (kbd "M-<left>") 'windmove-left)
  (local-set-key (kbd "M-<right>") 'windmove-right)
 )
)


;; Load Magit
(add-to-list 'load-path (expand-file-name "~/.emacs.d/git-modes"))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/magit"))
(eval-after-load 'info
  '(progn (info-initialize)
          (add-to-list 'Info-directory-list (expand-file-name "~/.emacs.d/magit"))))
(require 'magit)
(define-key global-map (kbd "C-x g") 'magit-status)


;; Easier comment/uncomment. I never compose mails with Emacs
(define-key global-map (kbd "C-x m") 'comment-or-uncomment-region)

;; Disabled narrow-to-region, see http://www.gnu.org/software/emacs/manual/html_node/emacs/Narrowing.html
;; It's just weird..
(put 'narrow-to-region 'disabled nil)

(provide '.emacs)
;;; .emacs ends here


;; Multiple cursors https://github.com/emacsmirror/multiple-cursors
;; http://emacsrocks.com/e13.html
(require 'multiple-cursors)
(global-set-key (kbd "C-S-<mouse-1>") 'mc/add-cursor-on-click)

(require 'region-bindings-mode)
(region-bindings-mode-enable)

(define-key region-bindings-mode-map "a" 'mc/mark-all-like-this)
(define-key region-bindings-mode-map "p" 'mc/mark-previous-like-this)
(define-key region-bindings-mode-map "n" 'mc/mark-next-like-this)
(define-key region-bindings-mode-map "m" 'mc/mark-more-like-this-extended)
(define-key region-bindings-mode-map "l" 'mc/edit-lines)

;; Expand region, see https://github.com/magnars/expand-region.el
;; http://emacsrocks.com/e09.html
(require 'expand-region)
(global-set-key (kbd "C-=") 'er/expand-region)

;; http://emacsredux.com/blog/2013/05/09/keep-backup-and-auto-save-files-out-of-the-way/
;; store all backup and autosave files in the tmp dir
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))
