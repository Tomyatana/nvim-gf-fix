local M = {}

function M.go_to_file()
    ---@type string
    local line = vim.api.nvim_get_current_line()
    ---@type string
    local line_cpy = line
    local cursor_col = vim.api.nvim_win_get_cursor(0)[2]
    local l = 0
    local r = 0
    repeat
        l = line_cpy:find("(", 1, true) or -1
        r = line_cpy:find(")", 1, true) or -1
        line_cpy = line_cpy:sub(r+1)
    until cursor_col < r or r == -1
    if cursor_col < l or line:len() < 5 then
        return
    end
    line = line:sub(l+1, r-1);
    if(line:sub(0, 7) == "file://") then
        line = line:sub(8)
    end
    local line_idx = line:find("#L", 1, true) or -1
    if line_idx > -1 then
        local index_str = line:sub(line_idx+2)
        line = line:sub(0, line_idx-1)
        line_idx = tonumber(index_str) or 1
    end
    print('edit '.. line)
    local current_win = vim.api.nvim_get_current_win()
    local winfo = vim.api.nvim_win_get_config(current_win)
    if winfo.relative ~= "" then
        vim.api.nvim_win_close(current_win, false)
    end

    vim.cmd('edit '.. line)
    vim.api.nvim_win_set_cursor(0, {line_idx, 0})
end


---@param opts {noremap:boolean}
function M.setup(opts)
    opts = opts or {noremap = false};

    if(opts.noremap) then
        return
    end
    vim.keymap.set("n", "gf", M.go_to_file)
end

return M
