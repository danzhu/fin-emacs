(defconst fin-mode-keywords
  '("import"
    "struct" "enum" "def" "extern" "as"
    "let"
    "match" "which" "of"
    "if" "then" "elif" "else"
    "while" "do" "break" "continue" "redo"
    "return"
    "and" "or" "not"))

(defconst fin-mode-re-type
  (rx symbol-start
      (group upper (0+ (any word nonascii digit "_")))
      symbol-end))

(defconst fin-mode-re-call
  (rx "def"
      (1+ blank)
      (group (any word nonascii) (0+ (any word nonascii digit "_")))
      symbol-end))

(defconst fin-mode-re-bind
  (rx "let"
      (1+ blank)
      (group (any word nonascii) (0+ (any word nonascii digit "_")))
      symbol-end))

(defconst fin-mode-re-module
  (rx (group (0+ (any word nonascii digit "_")))
      ":"))

(defvar fin-mode-syntax-table
  (let ((st (make-syntax-table)))
    (modify-syntax-entry ?& "." st)
    (modify-syntax-entry ?# "<" st)
    (modify-syntax-entry ?\n ">" st)
    st)
  "Syntax table for `fin-mode'.")

(defvar fin-font-lock-defaults
  `((,(regexp-opt fin-mode-keywords 'symbols) . font-lock-keyword-face)
    (,fin-mode-re-type 1 font-lock-type-face)
    (,fin-mode-re-call 1 font-lock-function-name-face)
    (,fin-mode-re-bind 1 font-lock-variable-name-face)
    (,fin-mode-re-module 1 font-lock-constant-face)
    )
  "Keyword highlighting specification for `fin-mode'.")

;;;###autoload
(define-derived-mode fin-mode prog-mode "Fin"
  "Major mode for editing Fin files."
  :syntax-table fin-mode-syntax-table
  (setq-local comment-start "# ")
  (setq-local comment-start-skip "#+\\s-*")
  (setq-local font-lock-defaults '(fin-font-lock-defaults)))

;;;###autoload
(add-to-list 'auto-mode-alist '("\\.fin\\'" . fin-mode))

(provide 'fin-mode)
