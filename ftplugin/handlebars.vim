if exists("b:did_ftplugin")
  finish
endif

"xnoremap ih :<c-u>execute "normal! ?{{#\r%v/{{\/"<cr>
onoremap ih :<c-u>execute "normal! ?{{#\r%v/{{\/"<cr>

