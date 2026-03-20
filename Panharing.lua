local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_DEAD")
frame:RegisterEvent("PLAYER_ALIVE")
frame:RegisterEvent("PLAYER_UNGHOST")

-- Create text display
local textFrame = CreateFrame("Frame", nil, UIParent)
textFrame:SetSize(400, 100)
textFrame:SetPoint("CENTER")

-- Text message and styling

local text = textFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalHuge")
text:SetPoint("CENTER")
text:SetText("Niet releasen Panharing !")
text:SetTextColor(1,0,0);
text:SetFont("Fonts\\FRIZQT__.TTF", 60, "THICKOUTLINE")
text:SetShadowOffset(3, -3)

-- Create animation group for fade animation
local AnimationGroup = textFrame:CreateAnimationGroup()

-- Fade out
local fadeIn = AnimationGroup:CreateAnimation("Alpha")
fadeIn:SetFromAlpha(1)
fadeIn:SetToAlpha(.3)
fadeIn:SetDuration(0.8)

-- Fade in
local fadeOut = AnimationGroup:CreateAnimation("Alpha")
fadeOut:SetFromAlpha(0.3)
fadeOut:SetToAlpha(1)
fadeOut:SetDuration(0.8)
fadeOut:SetOrder(2)

AnimationGroup:SetLooping("REPEAT")

-- Check wether the player is dead or not
local function UpdateDisplay()
    if UnitIsDeadOrGhost("player") then
        local shouldDisplay = PanharingDB.always or (IsInRaid() and PanharingDB.raid) or (C_ChallengeMode.IsChallengeModeActive() and PanharingDB.challenge)

        if shouldDisplay then
            textFrame:Show()
            AnimationGroup:Play()
            return
        else
            AnimationGroup:Stop()
            textFrame:Hide()
            return
        end
    else
        AnimationGroup:Stop()
        textFrame:Hide()
        return
    end
end

-- Set Event to call Display Update and then call it manually at start.
frame:SetScript("OnEvent", function(self, event)
    UpdateDisplay()
end)

UpdateDisplay()