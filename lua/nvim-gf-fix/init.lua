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
    line = line:sub(l, r);
    print(line)
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
