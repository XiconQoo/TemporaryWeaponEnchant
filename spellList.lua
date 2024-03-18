local _, addonTable = ...

local GetSpellInfo, select, ipairs = GetSpellInfo, select, ipairs

addonTable.spells = {}
local function spells(textureId, textureIsItem, enchantIds)
    for _,v in ipairs(enchantIds) do
        if textureIsItem then
            local item = Item:CreateFromItemID(textureId)
            item:ContinueOnItemLoad(function()
                addonTable.spells[v] = item:GetItemIcon()
            end)
        else
            addonTable.spells[v] = select(3, GetSpellInfo(textureId))
        end
    end
end

-- see https://wow.tools/dbc/?dbc=spellitemenchantment&build=2.5.3.41750#page=1 to find the enchantIds

---Poisons
spells(3408, false, {22, 603}) -- Crippling Poison
spells(8679, false, {323, 324, 325, 623, 624, 625, 2641, 3768, 3769}) -- Instant Poison
spells(2823, false, {7, 8, 626, 627, 2630, 2642, 2643, 3770, 3771}) -- Deadly Poison
spells(5761, false, {23, 35, 643}) -- Mind-Numbing Poison
spells(13219, false, {703, 704, 705, 706, 2644, 3772, 3773}) -- Wound Poison
spells(26785, false, {2640, 3774}) -- Anesthetic Poison
---Oils
spells(211848, true, {7099}) -- Blackfathom Mana Oil
spells(20744, true, {2623}) -- Minor Wizard Oil
spells(20746, true, {2626}) -- Lesser Wizard Oil
spells(20750, true, {2627}) -- Wizard Oil
spells(20749, true, {2628}) -- Brilliant Wizard Oil
spells(28019, false, {2678}) -- Superior wizard oil
spells(20745, true, {2624}) -- Minor Mana Oil
spells(20747, true, {2625}) -- Lesser Mana Oil
spells(20748, true, {2629}) -- Brilliant Mana Oil
spells(28016, false, {2676, 2677}) -- Superior Mana Oil
spells(47906, false, {3299}) -- Exceptional Wizard Oil
spells(47904, false, {3298}) -- Exceptional Mana Oil
spells(45397, false, {3266}) -- Righteous Weapon Coating
spells(45395, false, {3265}) -- Blessed Weapon Coating
---Warlock stuff
spells(55178, false, {3615, 3616, 3617, 3618, 3619, 3620}) -- Spellstone
spells(55153, false, {3609, 3610, 3611, 3612, 3613, 3614, 3597}) -- Firestone
---Shaman stuff
spells(8512, false, {563, 564, 1783, 2638, 2639, 3014}) -- Windfury Totem
spells(8232, false, {283, 284, 525, 1669, 2636, 3785, 3786, 3787}) -- Windfury Weapon
spells(8227, false, {124, 285, 543, 1683, 2637}) -- Flametongue Totem
spells(8024, false, {5, 4, 3, 523, 1665, 1666, 2634, 3779, 3780, 3781}) -- Flametongue Weapon
spells(8033, false, {2, 12, 524, 1667, 1668, 2635, 3782, 3783, 3784}) -- Frostbrand Weapon
spells(51730, false, {3345, 3346, 3347, 3348, 3349, 3350}) -- Earthliving Weapon
spells(8017, false, {
    29, 3021, 3022, 3023, --Rank1
    6, 3024, 3025, 3026, --Rank2
    1, 3027, 3028, 3029, --Rank3
    503, 3030, 3031, 3032, --Rank4
    1663, 3033, 3034, 3035, --Rank5
    683, 3036, 3037, 3038, --Rank6
    1664, 3039, 3040, 3041,--Rank7
    2632, 3042, 3043, 3044,  --Rank8
    2633, 3018, 3019, 3020 --Rank9
}) -- Rockbiter weapon
--- Druid SOD
spells(407977, false, {7141}) -- Wild Strikes
--- Misc
spells(211845, true, {7098}) -- Blackfathom Sharpening Stone
spells(29452, false, {2712}) -- Fel Sharpening Stone
spells(29453, false, {2713}) -- Adamantite Sharpening Stone
spells(18262, true, {2506}) -- Elemental Sharpening Stone
spells(12404, true, {1643}) -- Dense Sharpening Stone
spells(2862, true, {40}) -- Rough Sharpening Stone
spells(23122, true, {2684}) -- Consecrated Sharpening Stone
spells(2863, true, {13}) -- Coarse Sharpening Stone
spells(7964, true, {483}) -- Solid Sharpening Stone
spells(2871, true, {14}) -- Heavy Sharpening Stone
spells(56308, false, {2713}) -- Sharpen Blade
spells(3829, true, {26}) -- Frost Oil
spells(3824, true, {25}) -- Shadow Oil
spells(29720, false, {2720}) -- Greater Ward of Shielding
spells(29507, false, {2719}) -- Lesser Ward of Shielding
spells(38615, false, {3102}) -- Bloodboil Poison
spells(5654, true, {42}) -- Instant Toxin
spells(34339, false, {2954}) -- Fel Weightstone
spells(23123, true, {3592}) -- Blessed Wizard Oil
--- Fishing
spells(8089, false, {266}) -- Aquadynamic Fish Attractor
spells(8532, false, {264}) -- Aquadynamic Fish Lens
spells(9092, false, {265}) -- Flesh Eating Worm
spells(8088, false, {264}) -- Nightcrawlers
spells(45731, false, {266}) -- Sharpened Fish Hook
spells(8087, false, {263}) -- Shiny Bauble
spells(64401, false, {3868}) -- Glow Worm
