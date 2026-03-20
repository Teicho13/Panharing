local DefaultConfig = {
    raid = true,
    challenge = true,
    always = false
}

-- Config variables
PanharingDB = PanharingDB or {}

-- Make sure to set defaults correctly if they are empty
for key, value in pairs(DefaultConfig) do
    if PanharingDB[key] == nil then
        PanharingDB[key] = value
    end
end

-- Create simple launcher panel
local panel = CreateFrame("Frame", "PanharingConfigPanel", UIParent)
panel.name = "Panharing"

-- Title
local title = panel:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
title:SetPoint("TOPLEFT", 16, -16)
title:SetText("Panharing")

-- Create settings checkboxes
local cb1 = CreateFrame("CheckButton", nil, panel, "InterfaceOptionsCheckButtonTemplate")
cb1:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -10)
cb1.Text:SetText("Enable in Raid")


local cb2 = CreateFrame("CheckButton", nil, panel, "InterfaceOptionsCheckButtonTemplate")
cb2:SetPoint("TOPLEFT", cb1, "BOTTOMLEFT", 0, -10)
cb2.Text:SetText("Enable in ChallengeMode (M+)")


local cb3 = CreateFrame("CheckButton", nil, panel, "InterfaceOptionsCheckButtonTemplate")
cb3:SetPoint("TOPLEFT", cb2, "BOTTOMLEFT", 0, -10)
cb3.Text:SetText("Enable always |cFFFF0000(overwrite)|r")


-- Load saved values when we open config
panel:SetScript("OnShow", function()
    cb1:SetChecked(PanharingDB.raid)
    cb2:SetChecked(PanharingDB.challenge)
    cb3:SetChecked(PanharingDB.always)
end)

-- Register on click events for checkboxes
cb1:SetScript("OnClick", function(self) PanharingDB.raid = self:GetChecked() end)
cb2:SetScript("OnClick", function(self) PanharingDB.challenge = self:GetChecked() end)
cb3:SetScript("OnClick", function(self) PanharingDB.always = self:GetChecked() end)


-- Register the panel
local category
if Settings and Settings.RegisterCanvasLayoutCategory then
    category = Settings.RegisterCanvasLayoutCategory(panel, panel.name)
    Settings.RegisterAddOnCategory(category)
else
    InterfaceOptions_AddCategory(panel)
end

-- Add slash command to open config settings
SLASH_PANHARING1 = "/panharing"
SlashCmdList["PANHARING"] = function()
    if Settings and category then
        Settings.OpenToCategory(category:GetID())
    else
        InterfaceOptionsFrame_OpenToCategory("Panharing")
    end
end