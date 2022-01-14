local _, addonTable = ...

TempEnchant1Icon:SetMask("Interface\\AddOns\\TempWeapEnchant\\images\\mask")
TempEnchant2Icon:SetMask("Interface\\AddOns\\TempWeapEnchant\\images\\mask")

hooksecurefunc("TemporaryEnchantFrame_Update", function(...)

    local hasMainHandEnchant,_,_,mainHandEnchantID,hasOffHandEnchant,_,_, offHandEnchantID = ...
    if hasMainHandEnchant and addonTable.spells[mainHandEnchantID] then
        (hasOffHandEnchant and TempEnchant2Icon or TempEnchant1Icon):SetTexture(addonTable.spells[mainHandEnchantID])
    end
    if hasOffHandEnchant and addonTable.spells[offHandEnchantID] then
        TempEnchant1Icon:SetTexture(addonTable.spells[offHandEnchantID])
    end
end)
