
--function SetJuliaEnvironment()
--    -- Switch to buffer named 'zepl: julia'
--    local repl_bufnr = vim.fn.bufnr("zepl : julia")
----    vim.cmd("buffer zepl: julia")
--    -- Send commands to the channel
--    vim.fn.chansend(vim.api.nvim_get_option("channel"), "print('Setting environment')\\n")
--    vim.fn.chansend(vim.api.nvim_get_option("channel"), "using Pkg\\n")
--    vim.fn.chansend(vim.api.nvim_get_option("channel"), "Pkg.activate(\".\")\\n")
--
--    -- Switch back to the previous buffer
--    vim.cmd("buffer #")
--end
--
function SetJuliaRepl()
    -- Switch to buffer named 'Repl julia' and keep it
    vim.cmd("keep Repl julia")

    -- Write the buffer
--   vim.cmd("write")
--
--    -- Move to the previous window
--   vim.cmd("normal! \\<C-w>\\<C-r>")

    -- Check if Manifest.toml and Project.toml exist, if not, set Julia environment
--    if not (vim.fn.filereadable("Manifest.toml") and vim.fn.filereadable("Project.toml")) then
--        SetJuliaEnvironment()
 --   end
end

vim.api.nvim_command("autocmd BufRead,BufNewFile *.jl lua SetJuliaRepl()")

