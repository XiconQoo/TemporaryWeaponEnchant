local _, addonTable = ...

local IsAddOnLoaded = IsAddOnLoaded
local unpack = unpack
local hooksecurefunc = hooksecurefunc
local GetWeaponEnchantInfo = GetWeaponEnchantInfo
local textures = {}

local function createTexture(name)
    local icon = _G[name .. "Icon"]
    local layer, level = icon:GetDrawLayer()
    local texture = _G[name]:CreateTexture(nil, layer or "BACKGROUND", nil, (level + 1) or 3)
    texture:SetSize(icon:GetSize())
    for i = 1, icon:GetNumPoints() do
        texture:SetPoint(icon:GetPoint(i))
    end
    texture:SetMask("Interface\\AddOns\\TemporaryWeaponEnchant\\images\\mask")

    local fontString = _G[name]:CreateFontString(nil, "OVERLAY", nil)
    fontString:SetFontObject("SystemFont_Outline_Small")
    if IsAddOnLoaded("Lorti-UI-Classic") or (IsAddOnLoaded("RougeUI") and RougeUI.Lorti) then
        fontString:SetPoint("TOPRIGHT", _G[name], "TOPRIGHT", 0, 0)
    else
        fontString:SetPoint("BOTTOMRIGHT", _G[name], "BOTTOMRIGHT", 0, 0)
    end
    fontString:SetText("")
    texture.fontString = fontString

    return texture
end

textures["mainhand"] = createTexture("TempEnchant2")
textures["offhand"] = createTexture("TempEnchant1")

local function resetTexture(texture)
    texture:SetTexture(nil)
    texture.textureActive = nil
    texture.id = nil
    texture.fontString:SetText("")
end

------------------------------
--- Blizzard
------------------------------

local function UpdateTempEnchant(...)
    local hasMainHandEnchant, _, mhCharges, mainHandEnchantID, hasOffHandEnchant, _, ohCharges, offHandEnchantID = ...
    local mhTexture = hasOffHandEnchant and textures["mainhand"] or textures["offhand"]

    if hasMainHandEnchant then
        if addonTable.spells[mainHandEnchantID] and (not mhTexture.id or mhTexture.id ~= mainHandEnchantID) then
            mhTexture:SetTexture(addonTable.spells[mainHandEnchantID])
            mhTexture.id = mainHandEnchantID
            mhTexture.textureActive = true
            if (mhCharges and mhCharges > 0) then
                mhTexture.fontString:SetText(mhCharges or "")
            end
        elseif not addonTable.spells[mainHandEnchantID] and mhTexture.textureActive then
            resetTexture(mhTexture)
        end
        if mhCharges and (mhTexture.remainingCharges ~= mhCharges) then
            mhTexture.fontString:SetText(mhCharges > 0 and mhCharges or "")
            mhTexture.remainingCharges = mhCharges
        end
    elseif not hasMainHandEnchant and mhTexture.textureActive then
        resetTexture(mhTexture)
    end

    if hasOffHandEnchant then
        if addonTable.spells[offHandEnchantID] and (not textures["offhand"].id or textures["offhand"].id ~= offHandEnchantID) then
            textures["offhand"]:SetTexture(addonTable.spells[offHandEnchantID])
            textures["offhand"].textureActive = true
            textures["offhand"].id = offHandEnchantID
            if (ohCharges and ohCharges > 0) then
                textures["offhand"].fontString:SetText(ohCharges or "")
            end
        elseif not addonTable.spells[offHandEnchantID] and textures["offhand"].textureActive then
            resetTexture(textures["offhand"])
        end
        if ohCharges and (textures["offhand"].remainingCharges ~= ohCharges) then
            textures["offhand"].fontString:SetText(ohCharges > 0 and ohCharges or "")
            textures["offhand"].remainingCharges = ohCharges
        end
    elseif not hasOffHandEnchant and mhTexture ~= textures["offhand"] and textures["offhand"].textureActive then
        resetTexture(textures["offhand"])
    end
end

------------------------------
--- Elv- and TukUI
------------------------------

if (IsAddOnLoaded("ElvUI")) then
    local E = unpack(ElvUI):GetModule('Auras')
    local oldFunc = E.UpdateTempEnchant
    E.UpdateTempEnchant = function(self, button, index, expiration)
        oldFunc(self, button, index, expiration)
        local is2 = string.match(button:GetName(), '2$')
        local is1 = string.match(button:GetName(), '1$')
        local hasMainHandEnchant, _, _, mainHandEnchantID, hasOffHandEnchant, _, _, offHandEnchantID = GetWeaponEnchantInfo()
        if is1 and hasMainHandEnchant and addonTable.spells[mainHandEnchantID] then
            button.texture:SetTexture(addonTable.spells[mainHandEnchantID])
        end
        if is2 and hasOffHandEnchant and addonTable.spells[offHandEnchantID] then
            button.texture:SetTexture(addonTable.spells[offHandEnchantID])
        end
    end
elseif IsAddOnLoaded("TukUI") then
    local T = Tukui:unpack()
    local oldFunc = T.Auras.UpdateTempEnchant
    T.Auras.UpdateTempEnchant = function(self, slot)
        oldFunc(self, slot)
        local hasMainHandEnchant, _, _, mainHandEnchantID, hasOffHandEnchant, _, _, offHandEnchantID = GetWeaponEnchantInfo()
        if slot == 16 and hasMainHandEnchant and addonTable.spells[mainHandEnchantID] then
            self.Icon:SetTexture(addonTable.spells[mainHandEnchantID])
        elseif slot ~= 16 and hasOffHandEnchant and addonTable.spells[offHandEnchantID] then
            self.Icon:SetTexture(addonTable.spells[offHandEnchantID])
        end
    end
else
    hooksecurefunc("TemporaryEnchantFrame_Update", UpdateTempEnchant)
end
