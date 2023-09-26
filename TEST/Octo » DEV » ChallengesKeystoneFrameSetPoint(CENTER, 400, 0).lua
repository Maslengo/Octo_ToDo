function()
    --GarrisonLandingPageMinimapButton.LoopingGlow:Hide()
    --LibDBIcon10_BigWigs:Hide()
    --UIErrorsFrame:SetAlpha(0.7)
    --UIErrorsFrame:ClearAllPoints()
    --UIErrorsFrame:SetPoint("TOP", 0, -54)
    --[[if not IsAddOnLoaded("Blizzard_ChallengesUI") then
        LoadAddOn("Blizzard_ChallengesUI")
    end]]
    ChallengesKeystoneFrame:SetPoint("CENTER", 400, 0)
    --print "qwe"
    --local _,_,_,tocversion=GetBuildInfo()
    --if tocversion<90500 then return end
    --if tocversion>=90500 then
    --    PTR_IssueReporter:Hide()
    --end

    return
end

