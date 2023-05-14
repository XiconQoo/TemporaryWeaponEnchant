local _, addonTable = ...

local IsAddOnLoaded = IsAddOnLoaded
local TempEnchant1Icon = _G["TempEnchant1Icon"]
local TempEnchant2Icon = _G["TempEnchant2Icon"]
local unpack = unpack
local hooksecurefunc = hooksecurefunc
local GetWeaponEnchantInfo = GetWeaponEnchantInfo

if (not IsAddOnLoaded("Lorti-UI-Classic")) then
    TempEnchant1Icon:SetMask("Interface\\AddOns\\TemporaryWeaponEnchant\\images\\mask")
    TempEnchant2Icon:SetMask("Interface\\AddOns\\TemporaryWeaponEnchant\\images\\mask")
end

if (IsAddOnLoaded("ElvUI")) then
    local E = unpack(ElvUI):GetModule('Auras')
    local oldFunc = E.UpdateTempEnchant
    E.UpdateTempEnchant = function(self, button, index, expiration)
        oldFunc(self, button, index, expiration)
        local is2 = string.match(button:GetName(), '2$')
        local is1 = string.match(button:GetName(), '1$')
        local hasMainHandEnchant,_,_,mainHandEnchantID,hasOffHandEnchant,_,_, offHandEnchantID = GetWeaponEnchantInfo()
        if is1 and hasMainHandEnchant and addonTable.spells[mainHandEnchantID] then
            button.texture:SetTexture(addonTable.spells[mainHandEnchantID])
        end
        if is2 and hasOffHandEnchant and addonTable.spells[offHandEnchantID] then
            button.texture:SetTexture(addonTable.spells[offHandEnchantID])
        end
    end
end

if IsAddOnLoaded("TukUI") then
    local T = Tukui:unpack()
    local oldFunc = T.Auras.UpdateTempEnchant
    T.Auras.UpdateTempEnchant = function(self, slot)
        oldFunc(self, slot)
        local hasMainHandEnchant,_,_,mainHandEnchantID,hasOffHandEnchant,_,_, offHandEnchantID = GetWeaponEnchantInfo()
        if slot == 16 and hasMainHandEnchant and addonTable.spells[mainHandEnchantID] then
            self.Icon:SetTexture(addonTable.spells[mainHandEnchantID])
        elseif slot ~= 16 and hasOffHandEnchant and addonTable.spells[offHandEnchantID] then
            self.Icon:SetTexture(addonTable.spells[offHandEnchantID])
        end
    end
end

local MHTex, OHTex
if not MHTex then
    MHTex = TempEnchant2:CreateTexture(nil, "ARTWORK")
    MHTex:SetSize(TempEnchant2Icon:GetSize())
    for i=1, TempEnchant2Icon:GetNumPoints() do
        MHTex:SetPoint(TempEnchant2Icon:GetPoint(i))
    end
    MHTex:SetMask("Interface\\AddOns\\TemporaryWeaponEnchant\\images\\mask")
end

if not OHTex then
    OHTex = TempEnchant1:CreateTexture(nil, "ARTWORK")
    OHTex:SetSize(TempEnchant1Icon:GetSize())
    for i=1, TempEnchant1Icon:GetNumPoints() do
        OHTex:SetPoint(TempEnchant1Icon:GetPoint(i))
    end
    OHTex:SetMask("Interface\\AddOns\\TemporaryWeaponEnchant\\images\\mask")
end

local function reset(texture)
    texture:SetTexture(nil)
    texture.textureActive = nil
    texture.id = nil
end
local function TemporaryEnchantFrame_Update_Hook(...)
    local hasMainHandEnchant,_,_,mainHandEnchantID,hasOffHandEnchant,_,_, offHandEnchantID = ...

    local mhTexture = hasOffHandEnchant and MHTex or OHTex

    if hasMainHandEnchant then
        if addonTable.spells[mainHandEnchantID] and (not mhTexture.id or mhTexture.id ~= mainHandEnchantID) then
            mhTexture:SetTexture(addonTable.spells[mainHandEnchantID])
            mhTexture.id = mainHandEnchantID
            mhTexture.textureActive = true
        elseif not addonTable.spells[mainHandEnchantID] and mhTexture.textureActive then
            reset(mhTexture)
        end
    elseif not hasMainHandEnchant and mhTexture.textureActive then
        reset(mhTexture)
    end
    if hasOffHandEnchant then
        if addonTable.spells[offHandEnchantID] and (not OHTex.id or OHTex.id ~= offHandEnchantID) then
            OHTex:SetTexture(addonTable.spells[offHandEnchantID])
            OHTex.textureActive = true
            OHTex.id = offHandEnchantID
        elseif not addonTable.spells[offHandEnchantID] and OHTex.textureActive then
            reset(OHTex)
        end
    elseif not hasOffHandEnchant and mhTexture ~= OHTex and OHTex.textureActive then
        reset(OHTex)
    end
end
_G["TemporaryEnchantFrame_Update_Hook"] = TemporaryEnchantFrame_Update_Hook
hooksecurefunc("TemporaryEnchantFrame_Update", _G["TemporaryEnchantFrame_Update_Hook"])