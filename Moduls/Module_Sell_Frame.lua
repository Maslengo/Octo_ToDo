local GlobalAddonName, E = ...
local AddonTitle = C_AddOns.GetAddOnMetadata(GlobalAddonName, "Title")
----------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------
--SellFrame
tinsert(E.Octo_Globals.modules, function()
		if Octo_ToDoVars.config.SellFrame then
			local size = 32
			local bgCr, bgCg, bgCb, bgCa = 14/255, 14/255, 14/255, 0.8
			local OctoFrame_Events = nil
			local OctoFrame_SellALLGRAY = nil
			local OctoFrame_SellOther = nil
			local OctoFrame_SellOtherFiolet = nil
			local OctoFrame_SellConsumable = nil
			local OctoFrame_foundLevelTooltip = nil
			local OctoFrame_FROMBANK = nil
			local OctoFrame_TOBANK = nil
			local ignore_list = {
				[49888] = true,
				[49908] = true,
				[49040] = true,
				[77530] = true,
				[81055] = true,
				[109076] = true,
				[111820] = true,
				[154172] = true,
				[154173] = true,
				[154174] = true,
				[154175] = true,
				[154176] = true,
				[154177] = true,
				[166751] = true,
				[167555] = true,
				[180653] = true,
				[188152] = true,
				[191251] = true,
				[193201] = true,
				[203703] = true,
				[204075] = true,
				[204076] = true,
				[204077] = true,
				[204078] = true,
				[204193] = true,
				[204194] = true,
				[204195] = true,
				[204196] = true,
				[204985] = true,
				[205982] = true,
				[207002] = true,
				[208153] = true,




			}
			local avgItemLevel, avgItemLevelEquipped = GetAverageItemLevel()
			local ilvlStr = avgItemLevelEquipped or 0
			function Octo_Trade_OnLoad()
				if not OctoFrame_Events then
					OctoFrame_Events = CreateFrame("Frame", AddonTitle..E.Octo_Func.GenerateUniqueID())
					OctoFrame_Events:Hide()
				end
				OctoFrame_Events:RegisterEvent("Trade_SHOW")
				OctoFrame_Events:RegisterEvent("SECURE_TRANSFER_CANCEL")
				OctoFrame_Events:RegisterEvent("MERCHANT_SHOW")
				OctoFrame_Events:RegisterEvent("MERCHANT_CLOSED")
				OctoFrame_Events:RegisterEvent("BANKFRAME_OPENED")
				OctoFrame_Events:RegisterEvent("BANKFRAME_CLOSED")
				OctoFrame_Events:RegisterEvent("PLAYER_STARTED_MOVING")
				OctoFrame_Events:RegisterEvent("MAIL_SHOW")
				OctoFrame_Events:SetScript("OnEvent", Octo_Trade_OnEvent)
			end
			function MASLENGO_Trade()
				local function SetQAButtonGameTooltip(button, text)
					button:SetScript("OnEnter", function(self)
						GameTooltip:SetOwner(self, "ANCHOR_RIGHT", 20, -30)
						GameTooltip:ClearLines()
						GameTooltip:SetText(text)
						GameTooltip:Show()
					end)
					button:SetScript("OnLeave", function()
						GameTooltip:Hide()
					end)
				end
				----------------------------------------------------------------------------------------------------------------------------------
				----------------------------------------------------------------------------------------------------------------------------------
				if not OctoFrame_SellALLGRAY then
					OctoFrame_SellALLGRAY = CreateFrame("BUTTON", AddonTitle..E.Octo_Func.GenerateUniqueID(), UIParent, "BackdropTemplate")
					OctoFrame_SellALLGRAY:Hide()
					SetQAButtonGameTooltip(OctoFrame_SellALLGRAY, "Gray items")
				end
				OctoFrame_SellALLGRAY:SetSize(size*E.Octo_Globals.scale, size*E.Octo_Globals.scale)
				OctoFrame_SellALLGRAY:SetFrameStrata("LOW")
				OctoFrame_SellALLGRAY:EnableMouse(true)
				OctoFrame_SellALLGRAY:SetMovable(true)
				OctoFrame_SellALLGRAY:RegisterForDrag("RightButton")
				OctoFrame_SellALLGRAY:SetScript("OnDragStart", OctoFrame_SellALLGRAY.StartMoving)
				OctoFrame_SellALLGRAY:SetScript("OnDragStop", function() OctoFrame_SellALLGRAY:StopMovingOrSizing() end)
				OctoFrame_SellALLGRAY:SetPoint("CENTER", -551, 130)
				OctoFrame_SellALLGRAY:SetBackdrop({
						bgFile = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\border\\01 Octo.tga",
						edgeFile = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\border\\01 Octo.tga",
						edgeSize = 1,
				})
				OctoFrame_SellALLGRAY:SetBackdropColor(bgCr, bgCg, bgCb, bgCa)
				OctoFrame_SellALLGRAY:SetBackdropBorderColor(0, 0, 0, 1)
				OctoFrame_SellALLGRAY:RegisterForClicks("LeftButtonUp")
				OctoFrame_SellALLGRAY:SetScript("OnClick", function()
						for bag=BACKPACK_CONTAINER, NUM_TOTAL_EQUIPPED_BAG_SLOTS do
							for slot=1, C_Container.GetContainerNumSlots(bag) do
								local containerInfo = C_Container.GetContainerItemInfo(bag, slot)
								if containerInfo then
									local itemID = containerInfo.itemID
									local itemLink = C_Container.GetContainerItemLink(bag, slot)
									local _, _, itemRarity, _, _, _, _, _, _, _, itemSellPrice, classID, subclassID = GetItemInfo(itemID)
									--if itemRarity == 0 and itemSellPrice ~= 0 and classID ~= 2 and classID ~= 4 then
									if itemRarity == 0 and itemSellPrice ~= 0 then
										C_Container.UseContainerItem(bag, slot)
									end
								end
							end
						end
					end
				)
				OctoFrame_SellALLGRAY.icon = OctoFrame_SellALLGRAY:CreateTexture(nil, "ARTWORK")
				OctoFrame_SellALLGRAY.icon:SetTexture("Interface\\AddOns\\"..GlobalAddonName.."\\Media\\Garbage.tga")
				OctoFrame_SellALLGRAY.icon:SetAllPoints(OctoFrame_SellALLGRAY)
				OctoFrame_SellALLGRAY:Show()
				----------------------------------------------------------------------------------------------------------------------------------
				if not OctoFrame_SellConsumable then
					OctoFrame_SellConsumable = CreateFrame("BUTTON", AddonTitle..E.Octo_Func.GenerateUniqueID(), UIParent, "BackdropTemplate")
					OctoFrame_SellConsumable:Hide()
					SetQAButtonGameTooltip(OctoFrame_SellConsumable, "Consumable")
				end
				OctoFrame_SellConsumable:SetSize(size*E.Octo_Globals.scale, size*E.Octo_Globals.scale)
				OctoFrame_SellConsumable:SetFrameStrata("LOW")
				OctoFrame_SellConsumable:EnableMouse(true)
				OctoFrame_SellConsumable:SetMovable(true)
				OctoFrame_SellConsumable:RegisterForDrag("RightButton")
				OctoFrame_SellConsumable:SetScript("OnDragStart", OctoFrame_SellConsumable.StartMoving)
				OctoFrame_SellConsumable:SetScript("OnDragStop", function() OctoFrame_SellConsumable:StopMovingOrSizing() end)
				OctoFrame_SellConsumable:SetPoint("CENTER", -551, 65)
				OctoFrame_SellConsumable:SetBackdrop({
						bgFile = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\border\\01 Octo.tga",
						edgeFile = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\border\\01 Octo.tga",
						edgeSize = 1,
				})
				OctoFrame_SellConsumable:SetBackdropColor(bgCr, bgCg, bgCb, bgCa)
				OctoFrame_SellConsumable:SetBackdropBorderColor(0, 0, 0, 1)
				OctoFrame_SellConsumable:RegisterForClicks("LeftButtonUp")
				OctoFrame_SellConsumable:SetScript("OnClick", function()
						for bag=BACKPACK_CONTAINER, NUM_TOTAL_EQUIPPED_BAG_SLOTS do
							for slot=1, C_Container.GetContainerNumSlots(bag) do
								local containerInfo = C_Container.GetContainerItemInfo(bag, slot)
								if containerInfo then
									local itemID = containerInfo.itemID
									local itemLink = C_Container.GetContainerItemLink(bag, slot)
									-- local _, _, _, _, _, _, classID = select(6, GetItemInfo(itemID))
									local classID = select(12, GetItemInfo(itemID))
									if itemID and classID == 0 then
										C_Container.UseContainerItem(bag, slot)
									end
								end
							end
						end
					end
				)
				OctoFrame_SellConsumable.icon = OctoFrame_SellConsumable:CreateTexture(nil, "ARTWORK")
				OctoFrame_SellConsumable.icon:SetTexture("Interface\\AddOns\\"..GlobalAddonName.."\\Media\\Trade_Alchemy_DPotion_A28.tga")
				OctoFrame_SellConsumable.icon:SetAllPoints(OctoFrame_SellConsumable)
				OctoFrame_SellConsumable:Show()
				----------------------------------------------------------------------------------------------------------------------------------
				if not OctoFrame_SellOther then
					OctoFrame_SellOther = CreateFrame("BUTTON", AddonTitle..E.Octo_Func.GenerateUniqueID(), UIParent, "BackdropTemplate")
					OctoFrame_SellOther:Hide()
					-- SetQAButtonGameTooltip(OctoFrame_SellOther, "itemQuality < фиолет")
				end
				OctoFrame_SellOther:SetScript("OnEnter", function(self)
						GameTooltip:SetOwner(self, "ANCHOR_RIGHT", 20, -30)
						GameTooltip:ClearLines()
						GameTooltip:AddLine("itemQuality < фиолет")
						GameTooltip:AddLine(" ")
						GameTooltip:AddLine("ignore_list: ")
						for k, v in pairs(ignore_list) do
							if GetItemInfo(k) then
								GameTooltip:AddDoubleLine(E.Octo_Func.func_itemTexture(k)..E.Octo_Func.func_itemName(k), k)
							end
						end
						GameTooltip:Show()
				end)
				OctoFrame_SellOther:SetScript("OnLeave", function(self)
					GameTooltip:ClearLines()
					GameTooltip:Hide()
				end)
				OctoFrame_SellOther:SetSize(size*E.Octo_Globals.scale, size*E.Octo_Globals.scale)
				OctoFrame_SellOther:SetFrameStrata("LOW")
				OctoFrame_SellOther:EnableMouse(true)
				OctoFrame_SellOther:SetMovable(true)
				OctoFrame_SellOther:RegisterForDrag("RightButton")
				OctoFrame_SellOther:SetScript("OnDragStart", OctoFrame_SellOther.StartMoving)
				OctoFrame_SellOther:SetScript("OnDragStop", function() OctoFrame_SellOther:StopMovingOrSizing() end)
				OctoFrame_SellOther:SetPoint("CENTER", -551, 0)
				OctoFrame_SellOther:SetBackdrop({
						bgFile = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\border\\01 Octo.tga",
						edgeFile = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\border\\01 Octo.tga",
						edgeSize = 1,
				})
				OctoFrame_SellOther:SetBackdropColor(bgCr, bgCg, bgCb, bgCa)
				OctoFrame_SellOther:SetBackdropBorderColor(0, 0, 0, 1)
				OctoFrame_SellOther:RegisterForClicks("LeftButtonUp")
				OctoFrame_SellOther:SetScript("OnClick", function()
						for bag=BACKPACK_CONTAINER, NUM_TOTAL_EQUIPPED_BAG_SLOTS do
							for slot=1, C_Container.GetContainerNumSlots(bag) do
								local containerInfo = C_Container.GetContainerItemInfo(bag, slot)
								if containerInfo then
									local itemID = containerInfo.itemID
									local itemLink = C_Container.GetContainerItemLink(bag, slot)
									local name, _, itemQuality, itemLevel, _, _, _, _, _, _, sellPrice = GetItemInfo(itemLink)
									local effectiveILvl = GetDetailedItemLevelInfo(itemID) or 0
									local baseILvl = tonumber(select(3, GetDetailedItemLevelInfo(itemID))) or 0
									local ItemTooltip = _G["OctoScanningTooltip"] or
									CreateFrame("GameTooltip", "OctoScanningTooltip", WorldFrame, "GameTooltipTemplate")
									ItemTooltip:SetOwner(WorldFrame, "ANCHOR_NONE");
									ItemTooltip:ClearLines()
									ItemTooltip:SetHyperlink(itemLink)
									local enchant = ""
									local emptySockets = 0
									for i = 1, ItemTooltip:NumLines() do
										if not OctoFrame_foundLevelTooltip then
											OctoFrame_foundLevelTooltip = _G["OctoScanningTooltipTextLeft" .. i]:GetText():match(ITEM_LEVEL:gsub("%%d", "(%%d+)"))
										end
										if OctoFrame_foundLevelTooltip then
											itemLevel = tonumber(OctoFrame_foundLevelTooltip) or 0
										end
									end
									if sellPrice and itemQuality then
										if not ignore_list[itemID] and sellPrice ~= 0 and itemQuality < 4 --[[and itemLevel < 150 and itemLevel ~= 0]] then --4 фиолет
											C_Container.UseContainerItem(bag, slot)
										end
									end
								end
							end
						end
					end
				)
				OctoFrame_SellOther.icon = OctoFrame_SellOther:CreateTexture(nil, "ARTWORK")
				OctoFrame_SellOther.icon:SetTexture("Interface\\AddOns\\"..GlobalAddonName.."\\Media\\Sell.tga")
				OctoFrame_SellOther.icon:SetAllPoints(OctoFrame_SellOther)
				OctoFrame_SellOther:Show()
				----------------------------------------------------------------------------------------------------------------------------------
				if not OctoFrame_SellOtherFiolet then
					OctoFrame_SellOtherFiolet = CreateFrame("BUTTON", AddonTitle..E.Octo_Func.GenerateUniqueID(), UIParent, "BackdropTemplate")
					OctoFrame_SellOtherFiolet:Hide()
					-- SetQAButtonGameTooltip(OctoFrame_SellOtherFiolet, "itemQuality = фиолет")
				end
				OctoFrame_SellOtherFiolet:SetScript("OnEnter", function(self)
						GameTooltip:SetOwner(self, "ANCHOR_RIGHT", 20, -30)
						GameTooltip:ClearLines()
						GameTooltip:AddLine("itemQuality = фиолет")
						GameTooltip:AddLine(" ")
						GameTooltip:AddLine("ignore_list: ")
						for k, v in pairs(ignore_list) do
							if GetItemInfo(k) then
								GameTooltip:AddDoubleLine(E.Octo_Func.func_itemTexture(k)..E.Octo_Func.func_itemName(k), k)
							end
						end
						GameTooltip:Show()
				end)
				OctoFrame_SellOtherFiolet:SetScript("OnLeave", function(self)
					GameTooltip:ClearLines()
					GameTooltip:Hide()
				end)
				OctoFrame_SellOtherFiolet:SetSize(size*E.Octo_Globals.scale, size*E.Octo_Globals.scale)
				OctoFrame_SellOtherFiolet:SetFrameStrata("LOW")
				OctoFrame_SellOtherFiolet:EnableMouse(true)
				OctoFrame_SellOtherFiolet:SetMovable(true)
				OctoFrame_SellOtherFiolet:RegisterForDrag("RightButton")
				OctoFrame_SellOtherFiolet:SetScript("OnDragStart", OctoFrame_SellOtherFiolet.StartMoving)
				OctoFrame_SellOtherFiolet:SetScript("OnDragStop", function() OctoFrame_SellOtherFiolet:StopMovingOrSizing() end)
				OctoFrame_SellOtherFiolet:SetPoint("CENTER", -551, -30)
				OctoFrame_SellOtherFiolet:SetBackdrop({
						bgFile = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\border\\01 Octo.tga",
						edgeFile = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\border\\01 Octo.tga",
						edgeSize = 1,
				})
				OctoFrame_SellOtherFiolet:SetBackdropColor(bgCr, bgCg, bgCb, bgCa)
				OctoFrame_SellOtherFiolet:SetBackdropBorderColor(0, 0, 0, 1)
				OctoFrame_SellOtherFiolet:RegisterForClicks("LeftButtonUp")
				OctoFrame_SellOtherFiolet:SetScript("OnClick", function()
						for bag=BACKPACK_CONTAINER, NUM_TOTAL_EQUIPPED_BAG_SLOTS do
							for slot=1, C_Container.GetContainerNumSlots(bag) do
								local containerInfo = C_Container.GetContainerItemInfo(bag, slot)
								if containerInfo then
									local itemID = containerInfo.itemID
									local itemLink = C_Container.GetContainerItemLink(bag, slot)
									local name, _, itemQuality, itemLevel, _, _, _, _, _, _, sellPrice = GetItemInfo(itemLink)
									local effectiveILvl = GetDetailedItemLevelInfo(itemID) or 0
									local baseILvl = tonumber(select(3, GetDetailedItemLevelInfo(itemID))) or 0
									local ItemTooltip = _G["OctoScanningTooltip"] or
									CreateFrame("GameTooltip", "OctoScanningTooltip", WorldFrame, "GameTooltipTemplate")
									ItemTooltip:SetOwner(WorldFrame, "ANCHOR_NONE");
									ItemTooltip:ClearLines()
									ItemTooltip:SetHyperlink(itemLink)
									local enchant = ""
									local emptySockets = 0
									for i = 1, ItemTooltip:NumLines() do
										if not OctoFrame_foundLevelTooltip then
											OctoFrame_foundLevelTooltip = _G["OctoScanningTooltipTextLeft" .. i]:GetText():match(ITEM_LEVEL:gsub("%%d", "(%%d+)"))
										end
										if OctoFrame_foundLevelTooltip then
											itemLevel = tonumber(OctoFrame_foundLevelTooltip) or 0
										end
									end
									if sellPrice and itemQuality then
										if not ignore_list[itemID] and sellPrice ~= 0 and itemQuality <= 4 --[[and itemLevel < 150 and itemLevel ~= 0]] then --4 фиолет
											C_Container.UseContainerItem(bag, slot)
										end
									end
								end
							end
						end
					end
				)
				OctoFrame_SellOtherFiolet.icon = OctoFrame_SellOtherFiolet:CreateTexture(nil, "ARTWORK")
				OctoFrame_SellOtherFiolet.icon:SetTexture("Interface\\AddOns\\"..GlobalAddonName.."\\Media\\Sell.tga")
				OctoFrame_SellOtherFiolet.icon:SetAllPoints(OctoFrame_SellOtherFiolet)
				OctoFrame_SellOtherFiolet:Show()
				----------------------------------------------------------------------------------------------------------------------------------
				if not OctoFrame_SellAll then
					OctoFrame_SellAll = CreateFrame("BUTTON", AddonTitle..E.Octo_Func.GenerateUniqueID(), UIParent, "BackdropTemplate")
					OctoFrame_SellAll:Hide()
					SetQAButtonGameTooltip(OctoFrame_SellAll, "Sell All")
				end
				OctoFrame_SellAll:SetSize(size*E.Octo_Globals.scale, size*E.Octo_Globals.scale)
				OctoFrame_SellAll:SetFrameStrata("LOW")
				OctoFrame_SellAll:EnableMouse(true)
				OctoFrame_SellAll:SetMovable(true)
				OctoFrame_SellAll:RegisterForDrag("RightButton")
				OctoFrame_SellAll:SetScript("OnDragStart", OctoFrame_SellAll.StartMoving)
				OctoFrame_SellAll:SetScript("OnDragStop", function() OctoFrame_SellAll:StopMovingOrSizing() end)
				OctoFrame_SellAll:SetPoint("CENTER", -551, -65)
				OctoFrame_SellAll:SetBackdrop({
						bgFile = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\border\\01 Octo.tga",
						edgeFile = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\border\\01 Octo.tga",
						edgeSize = 1,
				})
				OctoFrame_SellAll:SetBackdropColor(bgCr, bgCg, bgCb, bgCa)
				OctoFrame_SellAll:SetBackdropBorderColor(0, 0, 0, 1)
				OctoFrame_SellAll:RegisterForClicks("LeftButtonUp")
				OctoFrame_SellAll:SetScript("OnClick", function()
						for bag=BACKPACK_CONTAINER, NUM_TOTAL_EQUIPPED_BAG_SLOTS do
							for slot=1, C_Container.GetContainerNumSlots(bag) do
								local containerInfo = C_Container.GetContainerItemInfo(bag, slot)
								if containerInfo then
									local itemID = containerInfo.itemID
									if itemID then
										if not ignore_list[itemID] then
											C_Container.UseContainerItem(bag, slot)
										end
									end
								end
							end
						end
					end
				)
				OctoFrame_SellAll.icon = OctoFrame_SellAll:CreateTexture(nil, "ARTWORK")
				OctoFrame_SellAll.icon:SetTexture("Interface\\AddOns\\"..GlobalAddonName.."\\Media\\SellAll.tga")
				OctoFrame_SellAll.icon:SetAllPoints(OctoFrame_SellAll)
				OctoFrame_SellAll:Show()
				----------------------------------------------------------------------------------------------------------------------------------
			end
			local function MASLENGO_BANK()
				if not OctoFrame_FROMBANK then
					OctoFrame_FROMBANK = CreateFrame("BUTTON", AddonTitle..E.Octo_Func.GenerateUniqueID(), UIParent, "BackdropTemplate")
					OctoFrame_FROMBANK:Hide()
				end
				OctoFrame_FROMBANK:SetSize(size*E.Octo_Globals.scale, size*E.Octo_Globals.scale)
				OctoFrame_FROMBANK:SetFrameStrata("LOW")
				OctoFrame_FROMBANK:SetPoint("CENTER", -500, 32)
				OctoFrame_FROMBANK:SetBackdrop({
						bgFile = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\border\\01 Octo.tga",
						edgeFile = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\border\\01 Octo.tga",
						edgeSize = 1,
				})
				OctoFrame_FROMBANK:SetBackdropColor(bgCr, bgCg, bgCb, bgCa)
				OctoFrame_FROMBANK:SetBackdropBorderColor(0, 0, 0, 1)
				OctoFrame_FROMBANK:RegisterForClicks("LeftButtonUp")
				OctoFrame_FROMBANK:SetScript("OnClick", function()
						for bag=REAGENTBANK_CONTAINER, BANK_CONTAINER do
							for slot=1, C_Container.GetContainerNumSlots(bag) do
								local n = C_Container.GetContainerItemLink(bag, slot)
								if n then
									C_Container.UseContainerItem(bag, slot)
								end
							end
						end
						for bag=NUM_TOTAL_EQUIPPED_BAG_SLOTS+1, NUM_TOTAL_EQUIPPED_BAG_SLOTS+NUM_BANKBAGSLOTS do
							for slot=1, C_Container.GetContainerNumSlots(bag) do
								local n = C_Container.GetContainerItemLink(bag, slot)
								if n then
									C_Container.UseContainerItem(bag, slot)
								end
							end
						end
					end
				)
				OctoFrame_FROMBANK.RightEdge:SetVertexColor(0, 1, 0)
				OctoFrame_FROMBANK.icon = OctoFrame_FROMBANK:CreateTexture(nil, "ARTWORK")
				OctoFrame_FROMBANK.icon:SetTexture("Interface\\AddOns\\"..GlobalAddonName.."\\Media\\Arrow_RIGHT.tga")
				OctoFrame_FROMBANK.icon:SetAllPoints(OctoFrame_FROMBANK)
				OctoFrame_FROMBANK:Show()
				----------------------------------------------------------------------------------------------------------------------------------
				if not OctoFrame_TOBANK then
					OctoFrame_TOBANK = CreateFrame("BUTTON", AddonTitle..E.Octo_Func.GenerateUniqueID(), UIParent, "BackdropTemplate")
					OctoFrame_TOBANK:Hide()
				end
				OctoFrame_TOBANK:SetSize(size*E.Octo_Globals.scale, size*E.Octo_Globals.scale)
				OctoFrame_TOBANK:SetFrameStrata("LOW")
				OctoFrame_TOBANK:SetPoint("CENTER", -500, -32)
				OctoFrame_TOBANK:SetBackdrop({
						bgFile = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\border\\01 Octo.tga",
						edgeFile = "Interface\\Addons\\"..GlobalAddonName.."\\Media\\border\\01 Octo.tga",
						edgeSize = 1,
				})
				OctoFrame_TOBANK:SetBackdropColor(bgCr, bgCg, bgCb, bgCa)
				OctoFrame_TOBANK:SetBackdropBorderColor(0, 0, 0, 1)
				OctoFrame_TOBANK:RegisterForClicks("LeftButtonUp")
				OctoFrame_TOBANK:RegisterForClicks("LeftButtonUp")
				OctoFrame_TOBANK:SetScript("OnClick", function()
						for bag=BACKPACK_CONTAINER, NUM_TOTAL_EQUIPPED_BAG_SLOTS do
							for slot=1, C_Container.GetContainerNumSlots(bag) do
								local itemLink = C_Container.GetContainerItemLink(bag, slot)
								if itemLink then
									C_Container.UseContainerItem(bag, slot)
								end
							end
						end
					end
				)
				OctoFrame_TOBANK.LeftEdge:SetVertexColor(0, 1, 0)
				OctoFrame_TOBANK.icon = OctoFrame_TOBANK:CreateTexture(nil, "ARTWORK")
				OctoFrame_TOBANK.icon:SetTexture("Interface\\AddOns\\"..GlobalAddonName.."\\Media\\Arrow_LEFT.tga")
				OctoFrame_TOBANK.icon:SetAllPoints(OctoFrame_TOBANK)
				OctoFrame_TOBANK:Show()
				----------------------------------------------------------------------------------------------------------------------------------
			end
			function Octo_Trade_OnEvent(self, event, ...)
				if event == "MERCHANT_SHOW" and not InCombatLockdown() then
					MASLENGO_Trade()
				elseif event == "Trade_SHOW" and not InCombatLockdown() then
					MASLENGO_Trade()
				elseif event == "SECURE_TRANSFER_CANCEL" or event == "MERCHANT_CLOSED" or event == "PLAYER_STARTED_MOVING" then
					if OctoFrame_SellALLGRAY then
						OctoFrame_SellALLGRAY:Hide()
					end
					if OctoFrame_SellConsumable then
						OctoFrame_SellConsumable:Hide()
					end
					if OctoFrame_SellOther then
						OctoFrame_SellOther:Hide()
					end
					if OctoFrame_SellOtherFiolet then
						OctoFrame_SellOtherFiolet:Hide()
					end
					if OctoFrame_SellAll then
						OctoFrame_SellAll:Hide()
					end
				elseif event == "BANKFRAME_OPENED" and not InCombatLockdown() then
					MASLENGO_BANK()
				elseif event == "BANKFRAME_CLOSED" or event == "PLAYER_STARTED_MOVING" then
					if OctoFrame_FROMBANK then
						OctoFrame_FROMBANK:Hide()
					end
					if OctoFrame_TOBANK then
						OctoFrame_TOBANK:Hide()
					end
				elseif event == "MAIL_SHOW" then
					MASLENGO_Trade()
				end
			end
			Octo_Trade_OnLoad()
		end
end)