local FACTION_STRINGS = { [0] = FACTION_HORDE, [1] = FACTION_ALLIANCE};
local allianceIcon = "Interface\\PVPFrame\\PVP-Currency-Alliance"
local hordeIcon = "Interface\\PVPFrame\\PVP-Currency-Horde"

aura_env.PvPSearchEntryUpdate = function (entry, ...)
    if (not LFGListFrame.SearchPanel:IsShown()) then return; end

    local resultID = entry.resultID;
    local searchResultInfo = C_LFGList.GetSearchResultInfo(resultID);
    local activityID = searchResultInfo.activityID;
    local activityName = C_LFGList.GetActivityFullName(activityID, nil, searchResultInfo.isWarMode)

    if searchResultInfo.leaderPvpRatingInfo then
        local leadRating = searchResultInfo.leaderPvpRatingInfo.rating

        local returnString = string.format(leadRating >= 3000 and "%.0f%s" or "%.0f%s", leadRating >= 3000 and leadRating / 3000 or leadRating, leadRating >= 3000 and "" or "") or returnString
        local factionString = FACTION_STRINGS[searchResultInfo.leaderFactionGroup];
        local factionIcon = hordeIcon

        if searchResultInfo.isDelisted then
            local activityColor = LFG_LIST_DELISTED_FONT_COLOR
            entry.Name:SetTextColor(activityColor.r, activityColor.g, activityColor.b)
            entry.ActivityName:SetTextColor(activityColor.r, activityColor.g, activityColor.b)
            entry.ActivityName:SetVertexColor(1,1,1,0.4)
        else
            returnString = C_ChallengeMode.GetDungeonScoreRarityColor(leadRating or 0):WrapTextInColorCode(returnString)


            if (factionString == "Alliance") then
                factionIcon =  allianceIcon
            end

        end
        entry.Name:SetText("["..returnString.."] "..entry.Name:GetText())
        entry.ActivityName:SetText("|T"..factionIcon..":20|t "..activityName)
    end
end

hooksecurefunc("LFGListSearchEntry_Update", aura_env.PvPSearchEntryUpdate);

aura_env.UpdateApplicantMember = function(member, appID, memberIdx, ...)
    local applicantInfo = C_LFGList.GetApplicantInfo(appID);
    local textName = member.Name:GetText();
    local appStatus = applicantInfo.applicationStatus
    local pendingStatus = applicantInfo.pendingApplicationStatus
    local fullName, Name, _, _, _, _, _, _, _, _, _, _, factionGroup = C_LFGList.GetApplicantMemberInfo(appID, memberIdx);
    local factionIcon = hordeIcon

    if factionGroup == 1 then
        factionIcon = allianceIcon
    end
    member.Name:SetText("|T"..factionIcon..":20|t "..textName);
    if ( pendingStatus == "cancelled" or appStatus == "timedout" or appStatus == "cancelled" or appStatus == "failed" or appStatus == "declined" or appStatus == "declined_full" or appStatus == "declined_delisted" ) then
        member.Name:SetVertexColor(1,1,1,0.4)
    end

end


hooksecurefunc("LFGListApplicationViewer_UpdateApplicantMember", aura_env.UpdateApplicantMember);

