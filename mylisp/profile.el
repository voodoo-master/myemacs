;;========================================
;;set the default environment
;;========================================

;;some conflict key for system:
;;kde: system setting -> shortcuts -> global keyboard shortcuts -> kwin -> activate window demanding attention (Ctrl+Alt+a)
;;kde: Fcitx config -> addon -> clipboard -> configuration -> trigger key for clipboard history list (Ctrl+;)
;;kde: Fcitx config -> global config -> switching virtual keyboard (Ctrl+Alt+b)
;;kde: some other conflict of (Ctrl+Alt+s)

(require 'package)
(package-initialize)

(setq default-directory "~/")
(add-to-list 'load-path "~/.emacs.d/mylisp")
(setq package-archives '(("gnu" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
                         ("melpa" . "http://mirror.tuna.tsinghua.edu.cn/elpa/melpa/")
                         ("org" . "http://mirror.tuna.tsinghua.edu.cn/elpa/org/")
                         ;; ("melpa-stable" . "http://mirror.tuna.tsinghua.edu.cn/elpa/melpa-stable")
                         ;; ("marmalade" . "http://mirror.tuna.tsinghua.edu.cn/elpa/marmalade/")
                         ))

(when (string-equal system-type "windows-nt")
  (setenv "HOME" "d:/edit/emacs")
  (setq exec-path
        '("d:/edit/emacs/bin"
          "d:/develop/msys2/usr/bin"
          "d:/develop/msys2/mingw64/bin"
          "C:/Windows/system32"
          "C:/Windows"
          ))
  (setenv "PATH"
          (concat
           "d:/develop/msys2/usr/bin" ";"
           (getenv "PATH")
           )))

;;enable server mode
(require 'server)
;;suppress error "directory ~/.emacs.d/server is unsafe" on windows
(when (and ;;(= emacs-major-version 24)
           ;;(= emacs-minor-version 2)
           (equal window-system 'w32))
  (defun server-ensure-safe-dir (dir) "Noop" t))
(server-start)
(server-mode 1)

;;use this command to run emacs in windows:
;;"$HOME\bin\emacsclientw.exe" -n -f "$HOME\.emacs.d\server\server" -a "$HOME\bin\runemacs.exe" "%1"

(setq auto-mode-alist
      (append '(
                ("\\.launch" . nxml-mode)
                ;;("\\.yaml" . nxml-mode)
               )
              auto-mode-alist))

;;========================================
;;config editor
;;========================================
;;config english font
(if (string-equal system-type "windows-nt")
    (set-face-attribute 'default nil :font "Consolas 11")
  (set-face-attribute 'default nil :font "DejaVu Sans Mono 11"))

;;config other font
(dolist (charset '(kana han symbol cjk-misc bopomofo))
 (set-fontset-font
  (frame-parameter nil 'font)
  charset
  (if (string-equal system-type "windows-nt")
      (font-spec :family "宋体" :size 12)
    (font-spec :family "Noto Sans Mono CJK SC" :size 12))
  ))

;;config file name coding system
(prefer-coding-system 'utf-8)
(setq file-name-coding-system 'utf-8)
(setq save-buffer-coding-system 'utf-8)
(setq coding-system-for-write 'utf-8)
(setq file-name-coding-system 'utf-8)

;;config file eol format
(set-buffer-file-coding-system 'unix 't)

;;hidden menu-bar
;;(menu-bar-mode nil)

;;hidden tool-bar
(tool-bar-mode 0)

;;config scroll-bar
(set-scroll-bar-mode 'left)

;;disable start-up message
(setq inhibit-startup-message t)

;;Show line number
(require 'linum)
(global-linum-mode 1)

;;avoid scroll roll
(setq scroll-margin 7)
(setq scroll-conservatively 100)
(setq scroll-step 1)

;;config cursor
(mouse-avoidance-mode 'animate)
(blink-cursor-mode 0)
(setq-default cursor-type '(bar . 3))
(setq-default cursor-in-non-selected-windows 'hollow)

;;config color
;;(set-background-color "#CBE9CB")
;;(set-face-background 'region "#AEDBB4")
(add-to-list 'custom-theme-load-path "~/.emacs.d/mylisp/color-theme-solarized")
(set-frame-parameter nil 'background-mode 'light)
(load-theme 'solarized t)

;;config fill-column
(setq default-fill-column 80)

;;set emacs frame size
(setq default-frame-alist
      '(;;(top . 20)
        ;;(left . 600)
        (height . 55)
        (width . 120)
        ;;(menu-bar-lines . 20)
        ;;(toll-bar-lines . 20)
        ))

;;config status-bar
;;show time
(display-time)

;;time format
(setq display-time-24hr-format t)
(setq display-time-day-and-date t)
(setq display-time-interval 10)

;;show column number
(setq column-number-mode t)

;;config title-bar
;;%f: buffer full path
;;%p: page percent
;;%l: line number
(setq frame-title-format "%f")

;;config editor features
;;no temportary backup file
(setq make-backup-files nil)
(setq-default make-backup-files nil)
;;close auto save mode
(setq auto-save-mode nil)
;;don't generate #filename# file
(setq auto-save-default nil)

;;auto update file when changed
(setq global-auto-revert-mode t)

;;use y/n instead of yes-or-no
(fset 'yes-or-no-p 'y-or-n-p)

;;disable bell
(setq visible-bell t)

;;enable word-wrap
(setq truncate-lines nil)

;;increase kill ring
(setq kill-ring-max 100)

;;config tab and indent
(setq-default indent-tabs-mode nil)
(setq default-tab-width 4)
(setq c-basic-offset 4)
(setq c-default-style "linux")

;;show matching bracket, don't jump to another
(show-paren-mode t)
(setq show-paren-style 'parenthesis)

;;set chinese punctuation
(setq sentence-end "\\([。！？]\\|……\\|[.?!][]\"')}]*\\($\\|[ \t]\\)\\)[ \t\n]*")
(setq sentence-end-double-space nil)

;;let emacs open picture
(auto-image-file-mode)

;;syntax high light
(global-font-lock-mode t)

;;recursive minibuffer
;;(setq enable-recursive-minibuffers t)

;;enable auto completion in minibuffer
;;(icomplete-mode t)

;;display which function the cursor is in
(which-function-mode 1)

;;enable these functions default
(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)
;;(put 'scroll-left 'disabled nil)
;;(put 'scroll-right 'disabled nil)

;;enable visual bookmark
;;(enable-visual-studio-bookmarks)

;;delete space at line end
(add-hook 'before-save-hook 'delete-trailing-whitespace)
(add-hook 'before-save-hook 'whitespace-cleanup)
;;(add-hook 'before-save-hook 'delete-blank-lines)
(global-set-key [f6] 'whitespace-newline-mode)

;;========================================
;;hotkey define
;;========================================
;;hotkey for system functions
(global-set-key (kbd "C-z") 'set-mark-command)
(global-set-key (kbd "C-x C-z") 'pop-global-mark)
(global-set-key (kbd "C-c m") 'match-paren)
(global-set-key (kbd "<C-M-backspace>") 'kill-whole-line)
(global-set-key (kbd "<C-backspace>") 'kill-to-beginning-of-line)

;;hotkey for custom functions
(global-set-key [(f5)] 'refresh-file)
(global-set-key (kbd "M-;") 'smart-comment-dwim-line)
(global-set-key (kbd "C-w") 'kill-region-or-line)
(global-set-key (kbd "M-w") 'copy-region-or-line)
;;(define-key global-map (kbd "M-g t") 'go-to-char)
(global-set-key (kbd "C-c w") 'copy-to-end-of-line)
(global-set-key (kbd "C-c W") 'copy-to-beginning-of-line)
;;(global-set-key (kbd "C-c y w") 'lh-copy-word)
;;(global-set-key (kbd "C-c y s") 'lh-copy-string)
;;(global-set-key (kbd "C-c y p") 'lh-copy-parenthesis)
(global-set-key (kbd "C-c y") 'yank-after-line)
(global-set-key (kbd "C-c Y") 'yank-before-line)
;;(global-set-key (kbd "C-c d w") 'lh-kill-word)
;;(global-set-key (kbd "C-c d s") 'lh-kill-string)
;;(global-set-key (kbd "C-c d p") 'lh-kill-parenthesis)
(global-set-key (kbd "<C-return>") 'insert-line-after)
(global-set-key (kbd "<M-return>") 'insert-line-before)
(global-set-key (kbd "<M-S-up>") 'move-line-up)
(global-set-key (kbd "<M-S-down>") 'move-line-down)

;;(global-set-key (kbd "C-x <up>") 'windmove-up)
;;(global-set-key (kbd "C-x <down>") 'windmove-down)
;;(global-set-key (kbd "C-x <left>") 'windmove-left)
;;(global-set-key (kbd "C-x <right>") 'windmove-right)

;;(global-set-key (kbd "<f7>") 'ska-jump-to-register)
;;(global-set-key (kbd "<f8>") 'ska-point-to-register)

(global-set-key (kbd "C-c j") 'avy-goto-word-or-subword-1)
(global-set-key (kbd "C-c k") 'avy-goto-char)
(global-set-key (kbd "C-c l") 'avy-goto-line)

(global-set-key (kbd "<C-S-prior>") 'tabbar-backward-group)
(global-set-key (kbd "<C-S-next>") 'tabbar-forward-group)
(global-set-key (kbd "<C-prior>") 'tabbar-backward-tab)
(global-set-key (kbd "<C-next>") 'tabbar-forward-tab)
(global-set-key (kbd "<M-p>") 'tabbar-backward-tab)
(global-set-key (kbd "<M-n>") 'tabbar-forward-tab)
(if (string-equal system-type "windows-nt")
    (global-set-key (kbd "<S-tab>") 'tabbar-forward-group)
  (global-set-key (kbd "<S-iso-lefttab>") 'tabbar-forward-group))
(global-set-key (kbd "<C-tab>") 'tabbar-forward-tab)

;;(global-set-key (kbd "s-o") 'other-window)
;;(global-set-key (kbd "s-;") 'delete-other-windows)
;;(global-set-key (kbd "s-'") 'delete-window)

;;========================================
;;config other plugin
;;========================================
;;config rainbow-delimiters
(require 'rainbow-delimiters)
(global-rainbow-delimiters-mode)

;;config multi-term
(require 'multi-term)
(setq multi-term-program "/bin/bash")

;; 当处于最后一行时 "C-a" 将光标移动到 terminal开始处而不是这个行的头
(defun ab/is-at-end-line ()
  "判断是否在最后一行"
  (equal (line-number-at-pos) (count-lines (point-min) (point-max))))

(defun ab/is-term-mode ()
  "判断是否为 term 模式"
  (string= major-mode "term-mode"))

(defun ab/move-beginning-of-line ()
  "move begin"
  (interactive)
  (if (not (ab/is-term-mode))
      (beginning-of-line)
    (if (not (ab/is-at-end-line))
        (beginning-of-line)
      (term-send-raw))))

;; 只后当是term-mode并且是最后一行时才采用 (term-send-left)
(defun ab/backword-char ()
  "Custom "
  (interactive)
  (if (not (ab/is-term-mode))
      (backward-char)
    (progn (if (not (ab/is-at-end-line))
               (backward-char)
             (progn (term-send-left)
                    (message "term-send-left"))))))

;;config eww use proxy
;;(setq url-proxy-services '(("no_proxy" . "^\\(localhost\\|10.*\\|192.*\\)\\|.*\.zte\.com\.cn")
;;                           ("http" . "10.204.220.5:80")
;;                           ("https" . "10.204.220.5:80")))

;;config ggtags
;;(require 'ggtags)
;;(add-hook 'c-mode-common-hook
;;          (lambda ()
;;            (when (derived-mode-p 'c-mode 'c++-mode 'java-mode)
;;              (ggtags-mode 1))))

;;config tabbar
(require 'tabbar)
(require 'tabbar-extension)
(tabbar-mode 1)
(defun tabbar-buffer-groups ()
  "tabbar group"
  (list (cond ((or (get-buffer-process (current-buffer))
                   (tabbar-buffer-mode-derived-p major-mode '(comint-mode compilation-mode)))
               "Process")
              ((member (buffer-name) '("gtd.org" "home.org" "other.org" "study.org" "work.org"))
               "GTD")
              ((memq major-mode '(rmail-mode rmail-edit-mode vm-summary-mode vm-mode mail-mode
                                             mh-letter-mode mh-show-mode mh-folder-mode
                                             gnus-summary-mode message-mode gnus-group-mode
                                             gnus-article-mode score-mode gnus-browse-killed-mode))
               "Mail")
              ((memq major-mode '(shell-mode dired-mode))
               "Shell")
              ((memq major-mode '(c-mode c++-mode))
               "C Source")
              ((or (string-equal "*" (substring (buffer-name) 0 1))
                   (string-equal "TAGS" (buffer-name)))
               "Emacs")
              (t
               "User Buffer")
              )))
(setq tabbar-buffer-groups-function 'tabbar-buffer-groups)

;;config session
(require 'session)
(add-hook 'after-init-hook 'session-initialize)

;;config desktop
(load "desktop")
(desktop-load-default)
(desktop-read)

;;set source files to be read-only by default
(defun make-some-files-read-only ()
  "when file opened is of a certain mode, make it read only"
  (when (memq major-mode '(c-mode c++-mode java-mode tcl-mode text-mode python-mode))
    (toggle-read-only 1)))
;;(add-hook 'find-file-hooks 'make-some-files-read-only)

;;config highlight parentheses
(require 'highlight-parentheses)
(define-globalized-minor-mode global-highlight-parentheses-mode
  highlight-parentheses-mode
  (lambda ()
    (highlight-parentheses-mode t)))
(global-highlight-parentheses-mode t)

;;config code fold
(load-library "hideshow")
(add-hook 'c-mode-hook 'hs-minor-mode)
(add-hook 'c++-mode-hook 'hs-minor-mode)
(add-hook 'java-mode-hook 'hs-minor-mode)
(add-hook 'perl-mode-hook 'hs-minor-mode)
(add-hook 'php-mode-hook 'hs-minor-mode)
(add-hook 'emacs-lisp-mode-hook 'hs-minor-mode)
(add-hook 'sh-mode-hook 'hs-minor-mode)

;;config for ycmd
;;To use ycmd-mode in all supported modes
;;(require 'ycmd)
;;(add-hook 'after-init-hook 'global-ycmd-mode)
;;(add-hook 'c++-mode-hook 'company-mode)
;;(add-hook 'c++-mode-hook 'ycmd-mode)

;;specify how to run the server
;;(set-variable 'ycmd-server-command '("/usr/bin/python" "/opt/ycmd/ycmd"))

;;specify a global emacs configuration
;;(specifyset-variable 'ycmd-global-config "/opt/ycmd/examples/.ycm_extra_conf.py")

;;completion framework
;;(require 'company-ycmd)
;;(company-ycmd-setup)
(add-hook 'after-init-hook 'global-company-mode)

;;enable flycheck
;;(require 'flycheck-ycmd)
;;(flycheck-ycmd-setup)
;;(add-hook 'after-init-hook 'global-flycheck-mode)

;;set always complete immediately
(setq company-idle-delay 0)

;;expand-region config
(require 'expand-region)
(global-set-key (kbd "C-=") 'er/expand-region)

;;smartparens config
(require 'smartparens)
;;(add-hook 'prog-mode-hook 'turn-on-smartparens-strict-mode)
;;(add-hook 'markdown-mode-hook 'turn-on-smartparens-strict-mode)

;;helm config
(require 'helm-config)
(helm-mode 1)
(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action)
(define-key helm-map (kbd "C-i") 'helm-select-action)
(define-key global-map [remap find-file] 'helm-find-files)
(define-key global-map [remap occur] 'helm-occur)
(define-key global-map [remap list-buffers] 'helm-buffers-list)
(define-key global-map [remap dabbrev-expand] 'helm-dabbrev)
(define-key global-map [remap execute-extended-command] 'helm-M-x)
(unless (boundp 'completion-in-region-function)
(define-key lisp-interaction-mode-map [remap completion-at-point] 'helm-lisp-completion-at-point)
(define-key emacs-lisp-mode-map       [remap completion-at-point] 'helm-lisp-completion-at-point))

;;========================================
;;user define functions
;;========================================
(defun smart-comment-dwim-line (&optional arg)
  "replacement for the comment-dwim command.
if no region is selected and current line is not blank and we are not
 at the end of the line,then comment current line.
replaces default behaviour of comment-dwim, when it inserts comment
at the end of the line."
  (interactive "*P")
  (comment-normalize-vars)
  (if (and (not (region-active-p)) (not (looking-at "[ \t]*$")))
      (comment-or-uncomment-region (line-beginning-position) (line-end-position))
    (comment-dwim arg)))

(defun kill-region-or-line ()
  "kill region or whole line"
  (interactive)
  (if mark-active
      (kill-region (region-beginning)
   (region-end))
    (progn
     (kill-region (line-beginning-position)
  (line-end-position))
     (message "killed line"))))

(defun copy-region-or-line ()
  "copy region or whole line"
  (interactive)
  (if mark-active
      (kill-ring-save (region-beginning)
      (region-end))
    (progn
     (kill-ring-save (line-beginning-position)
     (line-end-position))
     (message "copied line"))))

(defadvice kill-line (before check-position activate)
  (if (member major-mode
              '(emacs-lisp-mode scheme-mode lisp-mode
                                c-mode c++-mode objc-mode js-mode
                                latex-mode plain-tex-mode))
      (if (and (eolp) (not (bolp)))
          (progn (forward-char 1)
                 (just-one-space 0)
                 (backward-char 1)))))

(defadvice kill-ring-save (before slick-copy activate compile)
  "when called interactively with no active region, copy a single line instead."
  (interactive (if mark-active (list (region-beginning) (region-end))
                 (message "Copied line")
                 (list (line-beginning-position) (line-end-position)))))

(defadvice kill-region (before slick-cut activate compile)
  "when called internactively with no active region, kill a single line instead."
  (interactive
   (if mark-active (list (region-beginning) (region-end))
     (list (line-beginning-position) (line-end-position)))))

(defun copy-to-end-of-line (arg)
  "copy words from current position to line-end to the kill ring"
  (interactive "p")
  (kill-ring-save (point) (line-end-position))
  (message "%d line%s copied" arg (if (= 1 arg) "" "s")))

(defun copy-to-beginning-of-line (arg)
  "copy words from current position to line-beginning to the kill ring"
  (interactive "p")
  (kill-ring-save (point) (line-beginning-position))
  (message "%d line%s copied" arg (if (= 1 arg) "" "s")))

(defun kill-to-beginning-of-line ()
  "kill backward to the beginning of line"
  (interactive)
  (kill-line 0))

(defun yank-after-line ()
  "yank lines in the kill ring after curren line"
  (interactive)
  (save-excursion
    (goto-char (point))
    (progn
      (move-end-of-line 1)
      (newline 1)
      (yank 1))))

(defun yank-before-line ()
  "yank lines in the kill ring before curren line"
  (interactive)
  (save-excursion
    (goto-char (point))
    (progn
      (move-beginning-of-line 1)
      (open-line 1)
      (yank 1))))

(defun insert-line-after ()
  "open the next line"
  (interactive)
  (progn
    (move-end-of-line 1)
    (newline 1)
    (indent-according-to-mode)))

(defun insert-line-before ()
  "open the previous line"
  (interactive)
  (progn
    (previous-line 1)
    (move-end-of-line 1)
    (newline 1)
    (indent-according-to-mode)))

(defun next-word ()
 "move to the next word, keep cursor at the beginning of the word"
 (interactive)
 (progn
   (forward-word 1)
   (forward-word 1)
   (backward-word 1)))

;;press "%" to jump between brackets
(defun match-paren (arg)
  "go to the matching parenthesis if on parenthesis otherwise insert %."
  (interactive "p")
  (cond ((looking-at "\\s\(") (forward-list 1) (backward-char 1))
        ((looking-at "\\s\)") (forward-char 1) (backward-list 1))
        (t (self-insert-command (or arg 1)))))

;;move line up or down
(defun move-line (&optional n)
  "Move current line N (1) lines up/down leaving point in place."
  (interactive "p")
  (when (null n)
    (setq n 1))
  (let ((col (current-column)))
    (beginning-of-line)
    (next-line 1)
    (transpose-lines n)
    (previous-line 1)
    (forward-char col)))
(defun move-line-up (n)
  "Moves current line N (1) lines up leaving point in place."
  (interactive "p")
  (move-line (if (null n) -1 (- n))))
(defun move-line-down (n)
  "Moves current line N (1) lines down leaving point in place."
  (interactive "p")
  (move-line (if (null n) 1 n)))

;;auto close shell buffer while shell exit
(defun shell-mode-hook-func ()
  "close the shell buffer while exit the shell"
  (set-process-sentinel (get-buffer-process (current-buffer))
                        #'shell-mode-kill-buffer-on-exit))
(defun shell-mode-kill-buffer-on-exit (process state)
  (kill-buffer (current-buffer)))
(add-hook 'shell-mode-hook 'shell-mode-hook-func)

(defun dos-to-unix () (interactive)
   (goto-char (point-min))
   (while (search-forward "\r" nil t) (replace-match "")))

(defun unix-to-dos () (interactive)
   (goto-char (point-min))
   (while (search-forward "\n" nil t) (replace-match "\r\n")))

;;highlight buffer list
(setq buffer-menu-buffer-font-lock-keywords
      '(("^....[*]Man .*Man.*"   . font-lock-variable-name-face) ; Man page
        (".*Dired.*"             . font-lock-comment-face)       ; Dired
        ("^....[*]shell.*"       . font-lock-preprocessor-face)  ; shell buff
        (".*[*]scratch[*].*"     . font-lock-function-name-face) ; scratch buffer
        ("^....[*].*"            . font-lock-string-face)        ; "*" named buffers
        ("^..[*].*"              . font-lock-constant-face)      ; Modified
        ("^.[%].*"               . font-lock-keyword-face)))     ; Read only
(defun buffer-menu-custom-font-lock  ()
  (let ((font-lock-unfontify-region-function
         (lambda (start end)
           (remove-text-properties start end '(font-lock-face nil)))))
    (font-lock-unfontify-buffer)
    (set (make-local-variable 'font-lock-defaults)
         '(buffer-menu-buffer-font-lock-keywords t))
    (font-lock-fontify-buffer)))
(add-hook 'buffer-menu-mode-hook 'buffer-menu-custom-font-lock)

;;quick bookmark set and jump
(defun ska-point-to-register()
  "store cursorposition _fast_ in a register.
Use ska-jump-to-register to jump back to the stored
position."
  (interactive)
  (setq zmacs-region-stays t)
  (point-to-register 8))
(defun ska-jump-to-register()
  "switches between current cursorposition and position
that was stored with ska-point-to-register."
  (interactive)
  (setq zmacs-region-stays t)
  (let ((tmp (point-marker)))
    (jump-to-register 8)
    (set-register 8 tmp)))

;;go to char quickly
(defun go-to-char (n char)
  "Move forward to Nth occurence of CHAR.
Typing `wy-go-to-char-key' again will move forwad to the next Nth
occurence of CHAR."
  (interactive "p\ncgo to char: ")
  (search-forward (string char) nil nil n)
  (while (char-equal (read-char) char)
    (search-forward (string char) nil nil n))
  (setq unread-command-events (list last-input-event)))

;;copy, kill, paste without selection
(defun get-point (symbol &optional arg)
  "get the point"
  (funcall symbol arg)
  (point))
(defun copy-thing (begin-of-thing end-of-thing &optional arg)
  "copy thing between beg & end into kill ring"
  (save-excursion
    (let ((beg (get-point begin-of-thing 1))
          (end (get-point end-of-thing arg)))
      (copy-region-as-kill beg end))))
(defun kill-thing (begin-of-thing end-of-thing &optional arg)
  "copy thing between beg & end into kill ring"
  (save-excursion
    (let ((beg (get-point begin-of-thing 1))
          (end (get-point end-of-thing arg)))
      (kill-region beg end))))
(defun paste-to-mark(&optional arg)
 "Paste things to mark, or to the prompt in shell-mode"
 (let ((pasteMe
        (lambda()
          (if (string= "shell-mode" major-mode)
              (progn (comint-next-prompt 25535) (yank))
            (progn (goto-char (mark)) (yank))))))
   (if arg
       (if (= arg 1)
           nil
         (funcall pasteMe))
     (funcall pasteMe))))
(defun beginning-of-string (&optional arg)
  (re-search-backward "[ \t]" (line-beginning-position) 3 1)
  (if (looking-at "[\t ]") (goto-char (+ (point) 1))))
(defun end-of-string (&optional arg)
  (re-search-forward "[ \t]" (line-end-position) 3 arg)
  (if (looking-back "[\t ]") (goto-char (- (point) 1))))
(setq dove-parenthesis-list
      '(("[" "]")
        ("(" ")")
        ("<" ">")
        ("{" "}")
        ("\"" "\"")
        ("'"  "'")))
(defun beginning-of-parenthesis(&optional arg)
  "Go to the beginning of parenthesis
and set the dove-parenthesis-begin found there"
  (re-search-backward "[[<(?\'\"]" (line-beginning-position) 3 1)
  (if (looking-at "[[<(?\'\"]")
      (progn
        (goto-char (+ (point) 1))
        (setq dove-parenthesis-begin (string (char-before (point)))))))
(defun end-of-parenthesis(&optional arg)
  "Go to the end of parenthesis.
Parenthesis character was defined by beginning-of-parenthesis"
  (setq dove-parenthesis-end
        (mapconcat (lambda (x)
                     (if (string= dove-parenthesis-begin (nth 0 x))
                         (nth 1 x)))
                   dove-parenthesis-list nil))
  (goto-char (+ (point) 1))
  (re-search-forward dove-parenthesis-end
                     (line-end-position) 3 arg)
  (if (looking-back dove-parenthesis-end)
      (goto-char (- (point) 1))))

(defun lh-copy-word (&optional arg)
  "Copy words at point into kill-ring"
  (interactive "P")
  (copy-thing 'backward-word 'forward-word arg))
(defun lh-kill-word (&optional arg)
  "Kill words at point"
  (interactive "P")
  (kill-thing 'backward-word 'forward-word arg))
(defun lh-paste-word (&optional arg)
  "Paste words at point to mark"
  (interactive "P")
  (copy-thing 'backward-word 'forward-word arg)
  (paste-to-mark arg))

(defun lh-copy-string(&optional arg)
  "Copy a string to kill-ring"
  (interactive "P")
  (copy-thing 'beginning-of-string 'end-of-string arg))
(defun lh-kill-string(&optional arg)
  "Kill a string"
  (interactive "P")
  (kill-thing 'beginning-of-string 'end-of-string arg))
(defun lh-paste-string(&optional arg)
  "Try to copy a string to kill-ring
when used in shell-mode, it will paste string on shell prompt by default"
  (interactive "P")
  (copy-thing 'beginning-of-string 'end-of-string arg)
  (paste-to-mark arg))

(defun lh-copy-parenthesis(&optional arg)
  "Copy a parenthesis to kill-ring"
  (interactive "P")
  (copy-thing 'beginning-of-parenthesis 'end-of-parenthesis arg))
(defun lh-kill-parenthesis(&optional arg)
  "Kill a parenthesis"
  (interactive "P")
  (kill-thing 'beginning-of-parenthesis 'end-of-parenthesis arg))
(defun lh-paste-parenthesis(&optional arg)
  "Try to copy a parenthesis and paste it to the mark
when used in shell-mode, it will paste parenthesis on shell prompt by default"
  (interactive "P")
  (kill-thing 'beginning-of-parenthesis 'end-of-parenthesis arg)
  (paste-to-mark arg))

;;用C+o来复制当前单词
;; (defun copy-word (&optional arg)
;; (interactive)
;; (setq onPoint (point))
;; (let (
;; ( beg (progn (re-search-backward "[^a-zA-Z0-9_]" (line-beginning-position) 3 1)
;; (if (looking-at "[^a-zA-Z0-9_]") (+ (point) 1) (point) ) )
;; )
;; ( end (progn (goto-char onPoint) (re-search-forward "[^a-zA-Z0-9_]" (line-end-position) 3 1)
;; (if (looking-back "[^a-zA-Z0-9_]") (- (point) 1) (point) ) )
;; ))
;; (copy-region-as-kill beg end)
;; )
;; )
;; ;;C+o复制某个单词
;; (global-set-key [(control o)] 'copy-word)

;;config indent style
(defun lh-config-indent-sytle ()
  "Config my own code style"
  (interactive)
  (progn (c-set-style "k&r")
         (setq c-basic-offset 4)))
(add-hook 'c-mode-hook 'lh-config-indent-sytle)
(add-hook 'c++-mode-hook 'lh-config-indent-sytle)
(add-hook 'java-mode-hook 'lh-config-indent-sytle)

(defun refresh-file ()
  (interactive)
  (revert-buffer t (not (buffer-modified-p)) t))
