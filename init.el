;;; 初期化ファイル

(setq user-full-name "Yasuo Hojo")
(setq user-email-address "yhojo@pp.iij4u.or.jp")

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

;; Common Lisp互換ライブラリの読み込み。
(require 'cl)

;; 言語を日本語にする
(set-language-environment 'Japanese)
;; 極力UTF-8とする
(prefer-coding-system 'utf-8)

;; 環境に合わせた初期化を実行する。
(cond ((eq window-system 'ns)
       ;; default screen size
       (setq default-frame-alist
	     (append (list
		      '(width . 60) ;; TODO: 何故か、Cocoa Emacsでは幅が全角ベース
		      '(height . 37)
		      '(top . 0)
		      '(left . 0))
		     default-frame-alist))
       ;; kill-ringはテキスト属性を保存しない
       (defadvice kill-new (around my-kill-ring-disable-text-property activate)
	 (let ((new (ad-get-arg 0)))
	   (set-text-properties 0 (length new) nil new)
	   ad-do-it))
       ;; MacOS Cocoa Emacs font settings
       (set-face-attribute
	'default nil
	:family "M+1VM+IPAG circle"
	:height 140)
       (set-fontset-font
	(frame-parameter nil 'font)
	'japanese-jisx0208
	'("M+1VM+IPAG circle" . "iso10646-1"))
       (set-fontset-font
	(frame-parameter nil 'font)
	'japanese-jisx0208
	'("M+1VM+IPAG circle" . "iso10646-1"))
       (set-fontset-font
	(frame-parameter nil 'font)
	'mule-unicode-0100-24ff
	'("monaco" . "iso10646-1"))
       ;; Mac用IME設定
       (mac-input-method-mode)
       ))

(add-to-load-path "site-lisp")

(load-library "pukiwiki-mode")
(setq pukiwiki-process-timeout 300)
(setq pukiwiki-site-list
      '(("MyWiki" "http://10.8.9.1/~yhojo/wiki/index.php")
      ))

 ;;
 ;; タイトル挿入スクリプト
 ;;
 (defun insert-title ()
   "Insert Pukiwiki Style log title line"
   (interactive)
   (let ((today (format-time-string "%Y-%m-%d" (current-time)))
         (title (read-string "Title: " "")))
     (insert "* " title " - " today)))
 (global-set-key "\C-x\C-^" 'insert-title)
