do
	if not WarmupSV then
		local addons = {
			"!BugGrabber",
			"BugSack",
			"HidingBar",
			"HidingBar_Options",
			"SpeedyAutoLoot",
			"AddonMrgl",
			"SilverDragon",
			"SilverDragon_History",
			"SilverDragon_Overlay",
			"SilverDragon_RangeExtender",
			"GreatVaultList",
			"MountsJournal",
			"MacroManager",
			"MacroManagerData",
			"AdvancedInterfaceOptions",
		}
		for _, name in ipairs(addons) do
			E:func_LoadAddOnFORCED(name)
		end
		C_AddOns.SaveAddOns()
	end
end