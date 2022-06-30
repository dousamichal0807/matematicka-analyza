local Point = require("tikzplots.point")

local Rectangle = {}
Rectangle.meta = { __index = Rectangle }

function Rectangle.new(ptfrom, ptto)
    local self = setmetatable({}, Rectangle.meta)
    self:set_point_from(ptfrom)
    self:set_point_to(ptto)
    return self
end

function Rectangle:get_point_from()
    return Point.new(self.__x1, self.__y1)
end

function Rectangle:set_point_from(ptfrom)
    assert(ptfrom ~= nil, "cannot pass nil value as coordinate")
    assert(type(ptfrom) == "table", "tikzplots.Point was expected, a " .. type(ptfrom) .. " was given instead")
    self.__x1 = ptfrom:get_x()
    self.__y1 = ptfrom:get_y()
end

function Rectangle:get_point_to()
    return Point.new(self.__x2, self.__y2)
end

function Rectangle:set_point_to(ptto)
    assert(ptto ~= nil, "cannot pass nil value as coordinate")
    assert(type(ptto) == "table", "tikzplots.Point was expected, a " .. type(ptto) .. " was given instead")
    self.__x2 = ptto:get_x()
    self.__y2 = ptto:get_y()
end

function Rectangle:transform(transformation)
    assert(transformation ~= nil, "cannot pas nil value as transformation")
    assert(type(transformation) == "table", "tikzplots.Transformation was expected, a " .. type(transformation) .. " was given instead")
    local new_from = transformation:transform(self:get_point_from())
    local new_to = transformation:transform(self:get_point_to())
    return Rectangle.new(new_from, new_to)
end

function Rectangle:__tikz_command(tikzcmd, tikzsettings)
    tex.sprint("\\")
    tex.sprint(tikzcmd)
    tex.sprint("[")
    tex.sprint(tikzsettings)
    tex.sprint("] ")
    tex.sprint(Point.new(self.__x1, self.__y1):to_string())
    tex.sprint(" -- ")
    tex.sprint(Point.new(self.__x2, self.__y1):to_string())
    tex.sprint(" -- ")
    tex.sprint(Point.new(self.__x2, self.__y2):to_string())
    tex.sprint(" -- ")
    tex.sprint(Point.new(self.__x1, self.__y2):to_string())
    tex.sprint(" -- cycle;")
end

function Rectangle:draw(tikzsettings)
    self:__tikz_command("draw", tikzsettings)
end

function Rectangle:fill(tikzsettings)
    self:__tikz_command("fill", tikzsettings)
end

function Rectangle:fill_draw(tikzsettings)
    self.__tikz_command("filldraw", tikzsettings)
end