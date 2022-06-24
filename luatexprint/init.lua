local function print_line(str)
    print(str)
    if tex then
        tex.print(str .. "\\par")
    end
end

return print_line
