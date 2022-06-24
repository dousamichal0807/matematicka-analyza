local Point = require("tikzplots.point")
local Transformation = require("tikzplots.transformation")
local print_line = require("luatexprint")

local PlotSettings = {}
PlotSettings.meta = { __index = PlotSettings }

function PlotSettings.new(tikzdrawargs, transformation, xfrom, xto, xstep)
    local self = setmetatable({}, PlotSettings.meta)
    self:set_tikz_draw_args(tikzdrawargs)
    self:set_transformation(transformation)
    self:set_x_range(xfrom, xto)
    self:set_x_step(xstep)
    return self
end

function PlotSettings:get_tikz_draw_args()
    return self.__tikz_draw_args
end

function PlotSettings:set_tikz_draw_args(args)
    args = args or ""
    assert(type(args) == "string", "TikZ \\draw command args must be a string")
    self.__tikz_draw_args = args
end

function PlotSettings:get_trasformation()
    return self.__transformation
end

function PlotSettings:set_transformation(transformation)
    transformation = transformation or Transformation.new()
    assert(type(transformation) == "table", type(transformation) .. " is illegal argument type")
    self.__transformation = transformation
end

function PlotSettings:set_x_range(xfrom, xto)
    assert(xfrom ~= nil, "cannot pass nil as parameter")
    assert(xto ~= nil, "cannot pass nil as parameter")
    assert(type(xfrom) == "number", "x-from must be a number")
    assert(type(xto) == "number", "x-to must be a number")
    assert(xfrom < xto, "x-from must be smaller than x-to")
    self.__x_from = xfrom
    self.__x_to = xto
end

function PlotSettings:get_x_from()
    return self.__x_from
end

function PlotSettings:set_x_from(xfrom)
    assert(xfrom ~= nil, "cannot pass nil as parameter")
    assert(type(xfrom) == "number", "x-from must be a number")
    assert(xfrom < self.__x_to, "x-from must be smaller than x-to")
    self.__x_from = xfrom
end

function PlotSettings:get_x_to()
    return self.__x_to
end

function PlotSettings:set_x_to(xto)
    assert(xto ~= nil, "cannot pass nil as parameter")
    assert(type(xto) == "number", "x-to must be a number")
    assert(xto > self.__x_from, "x-to must be larger than x-from")
    self.__x_to = xto
end

function PlotSettings:get_x_step()
    return self.__x_to
end

function PlotSettings:set_x_step(xstep)
    assert(xstep ~= nil, "cannot pass nil as parameter")
    assert(type(xstep) == "number", "x-step must be a number")
    assert(xstep > 0, "x-step must be greater than zero")
    self.__x_step = xstep
end

function PlotSettings:plot(func)
    print_line("Test: type(func) = " .. type(func))
    assert(func ~= nil, "cannot pass nil as parameter")
    assert(type(func) == "function", "function was expected")

    local result = "\\draw[" .. self.__tikz_draw_args .. "] "
    local x = self.__x_from
    local first = true
    
    while x <= self.__x_to do
        local y = func(x)
        assert(type(y) == "number", "function output must be a number")
        y = math.floor(1000 * y + 0.5) / 1000
        
        local point = Point.new(x, y)
        local transformed = self.__transformation:transform(point)
        
        if first then
            first = false
        else
            result = result .. " -- "
        end

        result = result .. transformed:to_string()
        x = x + self.__x_step
    end

    result = result .. ";"
    print(result)
    if tex then
        tex.sprint(result)
    end
end

return PlotSettings
