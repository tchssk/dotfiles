if exists("did_load_filetypes")
  finish
endif
augroup filetypedetect
  " Tera Term Language (TTL)
  au! BufRead,BufNewFile *.ttl			setfiletype ttl

  " Vimperator
  au! BufRead,BufNewFile *.vimperatorrc		setfiletype vimperator
augroup END
