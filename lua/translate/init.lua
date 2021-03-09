local vim = vim

local cmd = require("translate.cmd")
local ui = require("translate.ui")

local translate = {}

function translate.Show(text)
    print(vim.inspect(text))
end

function translate.toPT(text, bang)
    local coordinates = ui.motion(0)
    local lines = cmd.extract_lines(coordinates, vim.api.nvim_get_mode().mode)
    local text = ""
    local target = "en:pt-br"

    for _, line in pairs(lines) do
        text = text .. line .. "\n"
    end

    local result = cmd.exec_trans(text, target)

    ui.show_win()

    ui.redraw(result)

end

function translate.toEN()
    local coordinates = ui.motion(0)
    local lines = cmd.extract_lines(coordinates)
    local text = ""
    local target = "pt-br:en"

    for _, line in pairs(lines) do
        text = text .. line .. "\n"
    end

    local result = cmd.exec_trans(text, target)

    ui.show_win()

    ui.redraw(result)
end

return translate
