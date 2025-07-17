function()  
	local vivod = ""
	local rosterCurrencyData = C_CurrencyInfo.FetchCurrencyDataFromAccountCharacters(3309)
	if rosterCurrencyData then
		for CharIndex, v in ipairs(rosterCurrencyData) do
			local characterName = v.characterName
			local quantity = v.quantity
			local characterGUID = v.characterGUID
			local fullCharacterName = v.fullCharacterName
			local currencyID = v.currencyID
			vivod = vivod ..
			"|cffFF00FFCharIndex:|r "..CharIndex.."|n"..
			"|cffFF00FFcharacterName:|r "..characterName.."|n"..
			"|cffFF00FFquantity:|r "..quantity.."|n"..
			"|cffFF00FFcharacterGUID:|r "..characterGUID.."|n"..
			"|cffFF00FFfullCharacterName:|r "..fullCharacterName.."|n"..
			"|cffFF00FFcurrencyID:|r "..currencyID.."|n|n"
		end
	end
	return vivod
end