function()
	----------------------------------------------------------------
	Horizontal gradient:
	function Gradient(x, y, w, h, r1, g1, b1, t1, r2, g2, b2, t2)
	    for i = 0, w, 1 do
	        screen.setColor(r1 + i*((r2-r1)/w), g1 + i*((g2-g1)/w), b1 + i*((b2-b1)/w), t1 + i*((t2-t1)/w))
	        screen.drawRectF(x+i, y, 1, h)
	    end
	end
	----------------------------------------------------------------
	Vertical gradient:
	function GradV(x, y, w, h, r1, g1, b1, o1, r2, g2, b2, o2)
	    for i = 0, h, 1 do
	        screen.setColor(r1 + i*((r2-r1)/h), g1 + i*((g2-g1)/h), b1 + i*((b2-b1)/h), o1 + i*((o2-o1)/h))
	        screen.drawRectF(x, y+i, w, 1)
	    end
	end
	----------------------------------------------------------------
	function rainbow(text)
	    local rtext = ""
	    local xcolor = 1
	    local sbyte = 1
	    for i = 1, #text do
	        math.randomseed(os.time() * xcolor * sbyte)
	        sbyte = string.byte(i)
	        xcolor = math.random(1, 255)
	        rtext = rtext .. "@x" .. string.rep("0", 3 - string.len(xcolor)) .. xcolor .. text:sub(i,i)
	    end
	    return rtext
	end

	----------------------------------------------------------------
	function()
	    function rainbow(text)
	        local vivod = ""
	        local byte = 1
	        for i = 1, #text do
	            local color = math.random(1, 255)
	            if color < 100 then
	                color = color + 100
	            end
	            vivod = vivod.."|cff"..color..color..text:sub(i,i).."\n"
	        end
	        return vivod
	    end
	    local pizdalishe = "WWWWWWWWWWWWWWWWWWWWWW"
	    return rainbow(pizdalishe)
	end

	----------------------------------------------------------------
	local function gradient(text, r1, g1, b1, r2, g2, b2)
	    for i = 1, #text do
	    end
	end
	return gradient("Octopussytest", 0.00,0.65,1.00,1.00,0.30,0.31)

	----------------------------------------------------------------
	local function ColorGradient(perc, ...)
	    if perc >= 1 then
	        local r, g, b = select(select('#', ...) - 2, ...)
	        return r, g, b
	    elseif perc <= 0 then
	        local r, g, b = ...
	        return r, g, b
	    end

	    local num = select('#', ...) / 3

	    local segment, relperc = math.modf(perc*(num-1))
	    local r1, g1, b1, r2, g2, b2 = select((segment*3)+1, ...)
	    return r1 + (r2-r1)*relperc, g1 + (g2-g1)*relperc, b1 + (b2-b1)*relperc
	end

	local r,g,b = ColorGradient(0.75, 1,0,0, 1,1,0, 0,1,0)
	return r..g..b
	----------------------------------------------------------------
	local function colorsAndPercent(a, b, ...)
	    if(a <= 0 or b == 0) then
	        return nil, ...
	    elseif(a >= b) then
	        return nil, select(-3, ...)
	    end

	    local num = select('#', ...) / 3
	    local segment, relperc = math.modf((a / b) * (num - 1))
	    return relperc, select((segment * 3) + 1, ...)
	end

	local function RGBColorGradient(...)
	    local relperc, r1, g1, b1, r2, g2, b2 = colorsAndPercent(...)
	    if(relperc) then
	        return r1 + (r2 - r1) * relperc, g1 + (g2 - g1) * relperc, b1 + (b2 - b1) * relperc
	    else
	        return r1, g1, b1
	    end
	end
	return RGBColorGradient(1,1,1,0,0,0)
	----------------------------------------------------------------


end

