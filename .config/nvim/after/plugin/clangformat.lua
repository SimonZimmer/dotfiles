--function clangFormat()
--  vim.cmd('silent! ClangFormat')
--end

--vim.cmd([[
--  augroup AutoClangFormat
--    autocmd!
--    autocmd BufWritePost *.c,*.cpp,*.h lua clangFormat()
-- augroup END
--]])
