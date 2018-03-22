"include guard
if exists("did_load_filetypes")
  finish
endif

augroup filetypedetect
    au! BufNewFile,BufRead *.agda setf agda
augroup END
