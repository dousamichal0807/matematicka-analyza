local tikzplots = require("tikzplots")

local transformation = tikzplots.Transformation.new(3.5, 3.5, 0, 0)
local funcPlotSettings = tikzplots.PlotSettings.new("graphStyle", transformation, 0, 0.5, 0.05)

local function funcValue(x)
    return (3 * x^3 - 3) / (3^x - 3)
end

local function graph()
    funcPlotSettings:set_x_range(-1.53, 0.99)
    funcPlotSettings:plot(funcValue)
    funcPlotSettings:set_x_range(1.02, 3.58)
    funcPlotSettings:plot(funcValue)
end

return { graph = graph }