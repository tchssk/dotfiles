if exists("did_load_filetypes")
  finish
endif
augroup filetypedetect
  " Tag file for Riot.js
  au! BufRead,BufNewFile *.tag		setfiletype html

  " Tera Term Language (TTL)
  au! BufRead,BufNewFile *.ttl			setfiletype ttl

  " Vimperator
  au! BufRead,BufNewFile *.vimperatorrc		setfiletype vimperator
augroup END
