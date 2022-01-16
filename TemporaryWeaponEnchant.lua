local _, addonTable = ...

if (not IsAddOnLoaded("Lorti-UI-Classic")) then
    TempEnchant1Icon:SetMask("Interface\\AddOns\\TemporaryWeaponEnchant\\images\\mask")
    TempEnchant2Icon:SetMask("Interface\\AddOns\\TemporaryWeaponEnchant\\images\\mask")
end

if (IsAddOnLoaded("ElvUI")) then
    local E = unpack(ElvUI):GetModule('Auras')
    local oldFunc = E.UpdateTempEnchant
    E.UpdateTempEnchant = function(self, button, index)
        oldFunc(self, button, index)
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

hooksecurefunc("TemporaryEnchantFrame_Update", function(...)
    local hasMainHandEnchant,_,_,mainHandEnchantID,hasOffHandEnchant,_,_, offHandEnchantID = ...
    if hasMainHandEnchant and addonTable.spells[mainHandEnchantID] then
        (hasOffHandEnchant and TempEnchant2Icon or TempEnchant1Icon):SetTexture(addonTable.spells[mainHandEnchantID])
    end
    if hasOffHandEnchant and addonTable.spells[offHandEnchantID] then
        TempEnchant1Icon:SetTexture(addonTable.spells[offHandEnchantID])
    end
end)