;;; csharp-mode-autoloads.el --- automatically extracted autoloads
;;
;;; Code:


;;;### (autoloads (csharp-mode csharp-want-imenu csharp-mode-hook)
;;;;;;  "csharp-mode" "csharp-mode.el" (22217 15653 186312 940000))
;;; Generated autoloads from csharp-mode.el

(defvar csharp-mode-hook nil "\
*Hook called by `csharp-mode'.")

(custom-autoload 'csharp-mode-hook "csharp-mode" t)

(defvar csharp-want-imenu t "\
*Whether to generate a buffer index via imenu for C# buffers.")

(custom-autoload 'csharp-want-imenu "csharp-mode" t)

(add-to-list 'auto-mode-alist '("\\.cs$" . csharp-mode))

(autoload 'csharp-mode "csharp-mode" "\
Major mode for editing C# code.

The mode provides fontification and indent for C# syntax, as well
as some other handy features.

At mode startup, there are two interesting hooks that run:
`c-mode-common-hook' is run with no args, then `csharp-mode-hook' is run after
that, also with no args.

To run your own logic after csharp-mode starts, do this:

  (defun my-csharp-mode-fn ()
    \"my function that runs when csharp-mode is initialized for a buffer.\"
    (turn-on-font-lock)
    (turn-on-auto-revert-mode) ;; helpful when also using Visual Studio
    (setq indent-tabs-mode nil) ;; tabs are evil
    ....your own code here...
  )
  (add-hook  'csharp-mode-hook 'my-csharp-mode-fn t)


The function above is just a suggestion.


Imenu Integration
===============================

Check the menubar for menu entries for Imenu; it is labelled
\"Index\".

The Imenu index gets computed when the file is .cs first opened and loaded.
This may take a moment or two.  If you don't like this delay and don't
use Imenu, you can turn this off with the variable `csharp-want-imenu'.



Key bindings:
\\{csharp-mode-map}

\(fn)" t nil)

;;;***

;;;### (autoloads nil nil ("csharp-mode-pkg.el") (22217 15653 194441
;;;;;;  166000))

;;;***

(provide 'csharp-mode-autoloads)
;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; csharp-mode-autoloads.el ends here
