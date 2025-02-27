local M = {}

function M.go_to_file()
    print("hola")
end


---@param opts {noremap:boolean}
function M.setup(opts)
    opts = opts or {noremap = false};

    if(opts.noremap) then
        return
    end
end

return M
