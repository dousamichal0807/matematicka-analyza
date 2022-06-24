local Point = {}
Point.meta = { __index = Point }

function Point.new(x, y)
    local self = setmetatable({}, Point.meta)
    self:set_x(x)
    self:set_y(y)
    return self
end

function Point:get_x()
    return self.__x
end

function Point:set_x(x)
    assert(type(x) == "number", "x-coordinate must be a number")
    self.__x = x
end

function Point:get_y()
    return self.__y
end

function Point:set_y(y)
    assert(type(y) == "number", "y-coordinate must be a number")
    self.__y = y
end

function Point:dist_from_origin()
    return math.sqrt(self.__x^2 + self.__y^2)
end

function Point:to_string()
    assert(type(self) == "table", "a point must be passed to Point:tostring")
    return "(" .. self.__x .. ", " .. self.__y .. ")"
end

return Point
