local vim = vim

local cmd = {}

--- extract
cmd.extract_lines = function(coordinates, mode)
    local lines = vim.api.nvim_buf_get_lines(coordinates.bufnr, coordinates.from[1] - 1, coordinates.to[1], false)

    if mode == 'v' then
        if coordinates.from[2] ~= 0 then
            lines[1] = string.sub(lines[1], coordinates.from[2])
        end

        if coordinates.to[2] ~= 0 then
            if coordinates.from[1] == coordinates.to[1] then
              lines[#lines] = string.sub(lines[#lines], 1, coordinates.to[2] - coordinates.from[2])
            else
              lines[#lines] = string.sub(lines[#lines], 1, coordinates.to[2])
            end
        end
    end

    return lines
end

--- buid_command
cmd.build_command = function(text, target)
    local args = {
        target = target,
        show = '-brief',
    }

    local command = string.format("trans %s %s -no-theme -no-ansi -no-warn \"%s\"", args.target, args.show, text)
    return command
end

--- exec_text
cmd.exec_trans = function(str_text, target)
    local command = cmd.build_command(str_text, target)
    return vim.api.nvim_call_function('systemlist', {
            command
        })
end

return cmd
