(cond ((eq system-type 'gnu/linux)
       (menu-bar-mode -1)
       (cond ((eq window-system 'x)
	      ;; ツールバーはいらないので消す。
	      (tool-bar-mode -1)))))

