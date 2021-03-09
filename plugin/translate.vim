if exists('g:loaded_translate') | finish | endif " prevent loading file twice

let s:save_cpo = &cpo " save user coptions
set cpo&vim " reset them to defaults

function! translate#show(arglead, cmdline, cursorPos)
    echom arglead
endfunction

" command to run our plugin
command! -range TransToPT lua require'translate'.toPT()
command! -range TransToEN lua require'translate'.toEN()

let &cpo = s:save_cpo " and restore after
unlet s:save_cpo

let g:loaded_translate = 1
