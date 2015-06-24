;;; 初期化ファイル

;;
;; MacOS Xの場合、カレントディレクトリを変更しないとつらい。
;;
(cond ((eq window-system 'ns)
       (cd "~")))

(setq user-full-name "Yasuo Hojo")
(setq user-email-address "yhojo@pp.iij4u.or.jp")

;;; バックアップファイルを作らない
(setq backup-inhibited t)

;;; 終了時にオートセーブファイルを消す
(setq delete-auto-save-files t)

;;; 行移動がおかしいのを直す。
(setq line-move-visual nil)

;; Emacs 設定ディレクトリを設定。Emacs 22以下用
;; Emacs 23.1 以上では user-emacs-directory 変数が用意されているのでそれを利用
(unless (boundp 'user-emacs-directory)
  (defvar user-emacs-directory (expand-file-name "~/.emacs.d/")))

;; 引数を load-path へ追加
;; normal-top-level-add-subdirs-to-load-path はディレクトリ中の中で
;; [A-Za-z] で開始する物だけ追加するので、追加したくない物は . や _ を先頭に付与しておけばロードしない
;; dolist は Emacs 21 から標準関数なので積極的に利用して良い
(defun add-to-load-path (&rest paths)
  (let (path)
    (dolist (path paths paths)
      (let ((default-directory (expand-file-name (concat user-emacs-directory path))))
        (add-to-list 'load-path default-directory)
        (if (fboundp 'normal-top-level-add-subdirs-to-load-path)
            (normal-top-level-add-subdirs-to-load-path))))))

;; 指定ディレクトリで正規表現に合致するファイルをロードする。
(defun load-directory-files (dir &optional regex)
  (let*
      ((regex (or regex ".+"))
       (files (and
               (file-accessible-directory-p dir)
               (directory-files dir 'full regex))))
    (mapc (lambda (file)
            (when (load file nil t)
              (message "`%s' loaded." file))) files)))

;; Common Lisp互換ライブラリの読み込み。
(require 'cl)

;; 言語を日本語にする
(set-language-environment 'Japanese)
;; 極力UTF-8とする
(prefer-coding-system 'utf-8)

;; lispディレクトリにパスを通す。
(add-to-load-path "lisp")

;;
;; C言語のインデント設定
;;
(add-hook 'c-mode-common-hook
      (lambda ()
        ;;(setq tab-width 8)
        (setq indent-tabs-mode nil) ; インデントは空白文字で行う（TABコードを空白に変換）
        (setq c-basic-offset 2))
      t)
;;
;; コンパイル時に*compile*バッファをスクロールする。
;; 
(setq compilation-scroll-output t)

;; Emacs23の時はパッケージシステムをロードする。
(when (= emacs-major-version 23)
  (require 'package)
  (add-to-list 'package-archives
			   '("melpa" . "http://melpa.org/packages/") t)
  (when (< emacs-major-version 24)
	;; For important compatibility libraries like cl-lib
	(add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/"))
	(add-to-list 'package-archives
				 '("melpa-stable" . "http://stable.melpa.org/packages/") t))
  (package-initialize))


;;
;; cpputils-cmake
;; https://github.com/redguardtoo/cpputils-cmake
;;
;(require 'cpputils-cmake) ;; package.elで組み込んだときはrequireはいらない
(add-hook 'c-mode-common-hook
          (lambda ()
            (if (derived-mode-p 'c-mode 'c++-mode)
                (cppcm-reload-all)
              )))
;; OPTIONAL, somebody reported that they can use this package with Fortran
;(add-hook 'c90-mode-hook (lambda () (cppcm-reload-all)))
;; OPTIONAL, avoid typing full path when starting gdb
;(global-set-key (kbd "C-c C-g")
;				'(lambda ()(interactive) (gud-gdb (concat "gdb --fullname " (cppcm-get-exe-path-current-buffer)))))
(global-set-key "\C-xc" 'compile)
;; OPTIONAL, some users need specify extra flags forwarded to compiler
;;(setq cppcm-extra-preprocss-flags-from-user '("-I/usr/src/linux/include" "-DNDEBUG"))

;;
;; verilog-modeの設定
;;
(add-hook 'verilog-mode-hook
	  (lambda ()
	    (setq tab-width 4)))
(setq verilog-indent-level             2
      verilog-indent-level-module      2
      verilog-indent-level-declaration 2
      verilog-indent-level-behavioral  2
      verilog-indent-level-directive   1
      verilog-case-indent              2
      verilog-auto-newline             nil
      verilog-auto-indent-on-newline   nil
      verilog-tab-always-indent        t
      verilog-auto-endcomments         t
      verilog-minimum-comment-distance 40
      verilog-indent-begin-after-if    t
      verilog-auto-lineup              '(all))

;; 各種初期化スクリプトを片っ端っから実行する。
(load-directory-files user-emacs-directory "^init-.+el$")
