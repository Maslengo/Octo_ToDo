function()
	MajorFactionRenownFrame
	----------------------------------------------------------------
	-- Horizontal gradient:
	function Gradient(x, y, w, h, r1, g1, b1, t1, r2, g2, b2, t2)
		for i = 0, w, 1 do
			screen.setColor(r1 + i*((r2-r1)/w), g1 + i*((g2-g1)/w), b1 + i*((b2-b1)/w), t1 + i*((t2-t1)/w))
			screen.drawRectF(x+i, y, 1, h)
		end
	end
	----------------------------------------------------------------
	-- Vertical gradient:
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
	local function rgbToHex(rgb)
		local hexadecimal = "0X"
		for key, value in pairs(rgb) do
			local hex = ""
			while(value > 0)do
				local index = math.fmod(value, 16) + 1
				value = math.floor(value / 16)
				hex = string.sub("0123456789ABCDEF", index, index) .. hex
			end
			if(string.len(hex) == 0)then
				hex = "00"
			elseif(string.len(hex) == 1)then
				hex = "0" .. hex
			end
			hexadecimal = hexadecimal .. hex
		end
		return hexadecimal
	end
	----------------------------------------------------------------
	function()
		local Kyri_Color = "|cff6fa8dc"
		local Necr_Color = "|cff93c47d"
		local NFae_Color = "|cffb4a7d6"
		local Vent_Color = "|cffea9999"
		local Cyan_Color = "|cff00ccff"
		local Rift_Color = "|cffbf9eff"
		local Gray_Color = "|cff404040"
		local Addon_Color = "|cff4FFF79"
		local White_Color = "|cffFFF7D7"
		local Blue_Color = "|cff00A3FF"
		local Red_Color = "|cffFF4C4F"
		local Green_Color = "|cff4FFF79"
		local Yellow_Color = "|cffFFF371"
		local Purple_Color = "|cffAF61FF"
		local Orange_Color = "|cffFF661A"

		local function func_hex2rgb(self)
			self = self:gsub("|cff","")
			return tonumber("0x"..self:sub(1,2)), tonumber("0x"..self:sub(3,4)), tonumber("0x"..self:sub(5,6))
		end

		local function func_Gradient(text, r1, g1, b1, r2, g2, b2)
			local octo = ""
			local maslengo = ""
			for i = 1, #text do
				local r3 = (r1 + i*((r2-r1)/#text))
				local g3 = (g1 + i*((g2-g1)/#text))
				local b3 = (b1 + i*((b2-b1)/#text))
				local color = CreateColor(r3/255, g3/255, b3/255)
				maslengo = maslengo..color:WrapTextInColorCode(text:sub(i,i))
			end
			octo = maslengo
			return octo
		end
		local r1, g1, b1 = func_hex2rgb("|cffFF0000")
		local r2, g2, b2 = func_hex2rgb("|cffFFFFFF")
		----------------------------------------------------------------
		return func_Gradient("Hey guys, just wondering how to create gradients using LUA", r1, g1, b1, r2, g2, b2)
	end
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
	----------------------------------------------------------------
----------------------------------------------------------------
function E.Octo_Func.Gradient(text, firstColor, secondColor)
	local vivod, maslengo, total = "", "", utf8len(text)
	local r1, g1, b1 = E.Octo_Func.func_hex2rgb(firstColor)
	local r2, g2, b2 = E.Octo_Func.func_hex2rgb(secondColor)
	local TESTr, TESTg, TESTb = (r2-r1)/total, (g2-g1)/total, (b2-b1)/total
	local r3 = r1
	local g3 = g1
	local b3 = b1
	for i = 1, total-1 do
		maslengo = maslengo..("|cff%02x%02x%02x%s|r"):format(math.floor(r3)+.5, math.floor(g3)+.5, math.floor(b3)+.5, utf8sub(text, i, i))
		r3 = r3 + TESTr
		g3 = g3 + TESTg
		b3 = b3 + TESTb
		print ("|cffFF00FF"..i.."|r",r3, g3, b3)
	end
	vivod = maslengo
	return vivod
end
local Gradient = E.Octo_Func.Gradient
----------------------------------------------------------------
function E.Octo_Func.Gradient(text, firstColor, secondColor)
	local vivod, maslengo, total = "", "", utf8len(text)
	local r1, g1, b1 = E.Octo_Func.func_hex2rgb(firstColor)
	local r2, g2, b2 = E.Octo_Func.func_hex2rgb(secondColor)
	local r3 = r1+r2
	print (r3)
	local g3 = g1+g2
	local b3 = b1+b2




	for i = 1, total do
		r3 = r3*(i/total)
		g3 = g3*(i/total)
		b3 = b3*(i/total)
		print ("|cffFF00FF"..i.."|r", math.floor(r3+.5), math.floor(g3+.5), math.floor(b3+.5))
		-- print ("|cffFF00FF"..i.."|r", r3,g3,b3)
		maslengo = maslengo..("|cff%02x%02x%02x%s|r"):format(math.floor(r3+.5), math.floor(g3+.5), math.floor(b3+.5), utf8sub(text, i, i))
		--print ("|cffFF00FF"..i.."|r", r3, g3, b3)
	end
	vivod = maslengo
	return vivod
end
local Gradient = E.Octo_Func.Gradient
----------------------------------------------------------------
function E.Octo_Func.Gradient(text, firstColor, secondColor)
	local vivod, maslengo, total = "", "", utf8len(text)
	local r1, g1, b1 = E.Octo_Func.func_hex2rgb(firstColor)
	local r2, g2, b2 = E.Octo_Func.func_hex2rgb(secondColor)

	for i = 1, total do
		local numPercent = (i/total)*100
		local hyi = (((r1+r2))*numPercent)/100


		local r3 = math.floor((((r1+r2))*numPercent)/100+.5) -- (r1+r2)*((i-1)/total)
		local g3 = math.floor((((g1+g2))*numPercent)/100+.5) -- (g1+g2)*((i-1)/total)
		local b3 = math.floor((((b1+b2))*numPercent)/100+.5) -- (b1+b2)*((i-1)/total)
		print ("|cffFF00FF"..i.."|r", numPercent, hyi)
		maslengo = maslengo..("|cff%02x%02x%02x%s|r"):format(r3, g3, b3, utf8sub(text, i, i))
	end
	vivod = maslengo
	return vivod
end
local Gradient = E.Octo_Func.Gradient
----------------------------------------------------------------