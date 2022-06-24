local tikzplots = require("tikzplots")
local print_line = require("luatexprint")

local transformation = tikzplots.Transformation.new(1, 1, 0, 0)
local funcPlotSettings = tikzplots.PlotSettings.new("thick, color=point, smooth", transformation, -2.355, 2.195, 0.05)

local function funcValue(x)
    return 0.5 * x^3 - 1.5 * x + 0.5
end

local function graph()
    print_line("Test: type(funcValue) = " .. type(funcValue))
    funcPlotSettings:plot(funcValue)
end

return { graph = graph }
