local GlobalAddonName, ns = ...
local E = OctoToDo_ToDO_E
local LibSFDropDown = LibStub("LibSFDropDown-1.5")
----------------------------------------------------------------
local function TriStateCheckbox_SetState(checked, checkButton)
	local checkedTexture = checkButton.CheckedTexture;
	if ( not checkedTexture ) then
		message("Can't find checked texture");
	end
	if ( not checked or checked == Enum.AddOnEnableState.None ) then
		-- nil or Enum.AddOnEnableState.None means not checked
		checkButton:SetChecked(false);
	elseif ( checked == Enum.AddOnEnableState.All ) then
		-- Enum.AddOnEnableState.All is a normal check
		checkButton:SetChecked(true);
		checkedTexture:SetVertexColor(1, 1, 1);
		checkedTexture:SetDesaturated(false);
	else
		-- Enum.AddOnEnableState.Some is a gray check
		checkButton:SetChecked(true);
		checkedTexture:SetDesaturated(true);
	end
	checkButton.state = checked or Enum.AddOnEnableState.None;
end


function AddonList_InitAddon(entry, treeNode)
	local addonIndex = treeNode:GetData().addonIndex;
	local name, title, notes, _, _, security = C_AddOns.GetAddOnInfo(addonIndex);

	-- Get the character from the current list (nil is all characters)
	local character = GetAddonCharacter();

	-- Get loadable state for the selected character, rather than all characters which GetAddOnInfo checks
	local loadable, reason = C_AddOns.IsAddOnLoadable(addonIndex, character);

	local checkboxState = C_AddOns.GetAddOnEnableState(addonIndex, character);
	local enabled;
	enabled = (C_AddOns.GetAddOnEnableState(addonIndex, UnitName("player")) > Enum.AddOnEnableState.None);


	TriStateCheckbox_SetState(checkboxState, entry.Enabled);
	if (checkboxState == Enum.AddOnEnableState.Some ) then
		entry.Enabled.tooltip = ENABLED_FOR_SOME;
	else
		entry.Enabled.tooltip = nil;
	end

	if ( loadable or ( enabled and (reason == "DEP_DEMAND_LOADED" or reason == "DEMAND_LOADED") ) ) then
		entry.Title:SetTextColor(1.0, 0.78, 0.0);
	elseif ( enabled and reason ~= "DEP_DISABLED" ) then
		entry.Title:SetTextColor(1.0, 0.1, 0.1);
	else
		entry.Title:SetTextColor(0.5, 0.5, 0.5);
	end

	local titleText = title or name;

	local iconTexture = C_AddOns.GetAddOnMetadata(addonIndex, "IconTexture");
	local iconAtlas = C_AddOns.GetAddOnMetadata(addonIndex, "IconAtlas");

	if not iconTexture and not iconAtlas then
		iconTexture = [[Interface\ICONS\INV_Misc_QuestionMark]];
	end

	if iconTexture then
		titleText = CreateSimpleTextureMarkup(iconTexture, 20, 20) .. " " .. titleText;
	elseif iconAtlas then
		titleText = CreateAtlasMarkup(iconAtlas, 20, 20) .. " " .. titleText;
	end

	if ADDON_ACTIONS_BLOCKED[name] or (AddOnPerformance and AddOnPerformance:AddOnHasPerformanceWarning(name)) then
		titleText = titleText .. CreateSimpleTextureMarkup([[Interface\DialogFrame\DialogIcon-AlertNew-16]], 16, 16);
	end
	entry.Title:SetText(titleText);

	if ( not loadable and reason ) then
		entry.Status:SetText(_G["ADDON_"..reason]);
	else
		entry.Status:SetText("");
	end

	if ( enabled ~= AddonList.startStatus[addonIndex] and reason ~= "DEP_DISABLED" or
		(reason ~= "INTERFACE_VERSION" and tContains(AddonList.outOfDateIndexes, addonIndex)) or
		(reason == "INTERFACE_VERSION" and not tContains(AddonList.outOfDateIndexes, addonIndex))) then
		if ( enabled ) then
			-- special case for loadable on demand addons
			if ( AddonList_IsAddOnLoadOnDemand(addonIndex) ) then
				AddonList_SetStatus(entry, true, false, false)
			else
				AddonList_SetStatus(entry, false, false, true)
			end
		else
			AddonList_SetStatus(entry, false, false, true)
		end
	else
		AddonList_SetStatus(entry, false, true, false)
	end

	entry:SetID(addonIndex);
	entry.title = title;
	entry.treeNode = treeNode;
end