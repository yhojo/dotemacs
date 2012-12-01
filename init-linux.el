(cond ((eq system-type 'gnu/linux)
       ;; ツールバーはいらないので消す。
       (tool-bar-mode -1)
       (menu-bar-mode -1)
       ))
