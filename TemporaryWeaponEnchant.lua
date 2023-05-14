local _, addonTable = ...

local IsAddOnLoaded = IsAddOnLoaded
local unpack = unpack
local hooksecurefunc = hooksecurefunc
local GetWeaponEnchantInfo = GetWeaponEnchantInfo
local textures = {}

local function createTexture(name)
    local texture = _G[name]:CreateTexture(nil, "BACKGROUND")
    texture:SetSize(_G[name.."Icon"]:GetSize())
    for i=1, _G[name.."Icon"]:GetNumPoints() do
        texture:SetPoint(_G[name.."Icon"]:GetPoint(i))
    end
    texture:SetMask("Interface\\AddOns\\TemporaryWeaponEnchant\\images\\mask")
    return texture
end

textures["mainhand"] = createTexture("TempEnchant2")
textures["offhand"] = createTexture("TempEnchant1")

local function resetTexture(texture)
    texture:SetTexture(nil)
    texture.textureActive = nil
    texture.id = nil
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

------------------------------
--- Blizzard
------------------------------

local function UpdateTempEnchant(hasMainHandEnchant, mainHandEnchantID, hasOffHandEnchant, offHandEnchantID)

    local mhTexture = hasOffHandEnchant and textures["mainhand"] or textures["offhand"]

    if hasMainHandEnchant then
        if addonTable.spells[mainHandEnchantID] and (not mhTexture.id or mhTexture.id ~= mainHandEnchantID) then
            mhTexture:SetTexture(addonTable.spells[mainHandEnchantID])
            mhTexture.id = mainHandEnchantID
            mhTexture.textureActive = true
        elseif not addonTable.spells[mainHandEnchantID] and mhTexture.textureActive then
            resetTexture(mhTexture)
        end
    elseif not hasMainHandEnchant and mhTexture.textureActive then
        resetTexture(mhTexture)
    end

    if hasOffHandEnchant then
        if addonTable.spells[offHandEnchantID] and (not textures["offhand"].id or textures["offhand"].id ~= offHandEnchantID) then
            textures["offhand"]:SetTexture(addonTable.spells[offHandEnchantID])
            textures["offhand"].textureActive = true
            textures["offhand"].id = offHandEnchantID
        elseif not addonTable.spells[offHandEnchantID] and textures["offhand"].textureActive then
            resetTexture(textures["offhand"])
        end
    elseif not hasOffHandEnchant and mhTexture ~= textures["offhand"] and textures["offhand"].textureActive then
        resetTexture(textures["offhand"])
    end
end

hooksecurefunc("TemporaryEnchantFrame_Update", function(...)
    local hasMainHandEnchant, _, _, mainHandEnchantID, hasOffHandEnchant, _, _, offHandEnchantID = ...
    UpdateTempEnchant(hasMainHandEnchant, mainHandEnchantID, hasOffHandEnchant, offHandEnchantID)
end)