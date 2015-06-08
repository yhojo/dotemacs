(load-library "pukiwiki-mode")
(setq pukiwiki-process-timeout 300)
(setq pukiwiki-site-list
      '(("MyWiki" "http://10.0.1.91/~yhojo/wiki/index.php")
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
