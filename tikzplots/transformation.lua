local Point = require("tikzplots.point")

local Transformation = {}
Transformation.meta = { __index = Transformation }

function Transformation.new(xscale, yscale, xshift, yshift)
    local self = setmetatable({}, Transformation.meta)
    self:set_x_scale(xscale)
    self:set_y_scale(yscale)
    self:set_x_shift(xshift)
    self:set_y_shift(yshift)
    return self
end

function Transformation:get_x_scale()
    return self.__x_scale
end

function Transformation:set_x_scale(xscale)
    assert(type(xscale) == "number", "x-scale must be non-zero number, passed " .. type(xscale) .. " instead")
    assert(xscale ~= 0, "x-scale must be non-zero number, zero was passed")
    self.__x_scale = xscale
end

function Transformation:get_y_scale()
    return self.__y_scale
end

function Transformation:set_y_scale(yscale)
    assert(type(yscale) == "number", "y-scale must be non-zero number, passed " .. type(yscale) .. " instead")
    assert(yscale ~= 0, "y-scale must be non-zero number, zero was passed")
    self.__y_scale = yscale
end

function Transformation:get_x_shift()
    return self.__x_shift
end

function Transformation:set_x_shift(xshift)
    assert(type(xshift) == "number", "x-scale must be number")
    self.__x_shift = xshift
end

function Transformation:get_y_shift()
    return self.__y_shift
end

function Transformation:set_y_shift(yshift)
    assert(type(yshift) == "number", "x-scale must be number")
    self.__y_shift = yshift
end

function Transformation:transform(point)
    assert(point ~= nil, "cannot pass null as argument")
    assert(type(point) == "table", "illegal argument type")
    local new_x = point:get_x() * self.__x_scale + self.__x_shift
    local new_y = point:get_y() * self.__y_scale + self.__y_shift
    return Point.new(new_x, new_y)
end

return Transformation