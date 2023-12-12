" NerdTree config

" default: ['\/$', '*', '\.swp$',  '\.bak$', '\~$']
let g:NERDTreeSortOrder=['*', '\.swp$',  '\.bak$', '\~$']


function! UpdateNerdTreeDir ()
  if exists("t:NERDTreeBufName") && bufwinnr(t:NERDTreeBufName) != -1
    exec 'NERDTreeCWD'
  endif
endfunction

function! SmartToggleNerdTree ()
  if exists("t:NERDTreeBufName") && bufwinnr(t:NERDTreeBufName) != -1
    exec 'NERDTreeClose'
  else
    exec 'NERDTreeFind'
  endif
  call UpdateNerdTreeDir()
endfunction
