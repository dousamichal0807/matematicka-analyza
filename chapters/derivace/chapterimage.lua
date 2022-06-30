local tikzplots = require("tikzplots")

local transformation = tikzplots.Transformation.new(2.5, 2.5, 0, 0)

local funcPlotSettings = tikzplots.PlotSettings.new(
    "line width=\\linethick, color=graphColor, smooth",
    transformation,
    -2.5, 2.76, 0.05
)
local derivPlotSettings = tikzplots.PlotSettings.new(
    "line width=\\linethick, color=derivGraphColor, smooth",
    transformation,
    -2.35, 2.36, 0.05
)

local function funcValue(x)
    return 0.5 * x^3 - 1.5 * x + 0.5
end

local function derivValue(x)
    return 1.5 * x^2 - 1.5
end

local function graph()
    derivPlotSettings:plot(derivValue)
    funcPlotSettings:plot(funcValue)
end

return {
    graph = graph
}
