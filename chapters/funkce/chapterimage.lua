local tikzplots = require("tikzplots")

local transformation = tikzplots.Transformation.new(2.5, 2.5, 0, 0)

local funcPlotSettings = tikzplots.PlotSettings.new(
    "line width=2pt, color=graphColor, smooth",
    transformation,
    -3.6, 3.61, 0.05
)

local function funcValue(x)
    return (x + 4) * math.sin(x)
end

local function graph()
    funcPlotSettings:plot(funcValue)
end

return {
    graph = graph
}
