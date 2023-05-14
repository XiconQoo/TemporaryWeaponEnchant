local _, addonTable = ...

addonTable.spells = {}
local function spells(spellTexture, enchantIds)
    for _,v in ipairs(enchantIds) do
        addonTable.spells[v] = select(3, GetSpellInfo(spellTexture))
    end
end

-- see https://wow.tools/dbc/?dbc=spellitemenchantment&build=2.5.3.41750#page=1 to find the enchantIds

---Poisons
spells(3408, {22, 603}) -- Crippling Poison
spells(8679, {323, 324, 325, 623, 624, 625, 2641, 3768, 3769}) -- Instant Poison
spells(2823, {7, 8, 626, 627, 2630, 2642, 2643, 3770, 3771}) -- Deadly Poison
spells(5761, {23, 35, 643}) -- Mind-Numbing Poison
spells(13219, {703, 704, 705, 706, 2644, 3772, 3773}) -- Wound Poison
spells(26785, {2640, 3774}) -- Anesthetic Poison
---Oils
spells(25117, {2623}) -- Minor Wizard Oil
spells(25126, {2626}) -- Lesser Wizard Oil
spells(25128, {2627}) -- Wizard Oil
spells(25129, {2628}) -- Brilliant Wizard Oil
spells(28019, {2678}) -- Superior wizard oil
spells(25125, {2624}) -- Minor Mana Oil
spells(25127, {2625}) -- Lesser Mana Oil
spells(25130, {2629}) -- Brilliant Mana Oil
spells(28016, {2676, 2677}) -- Superior Mana Oil
spells(47906, {3299}) -- Exceptional Wizard Oil
spells(47904, {3298}) -- Exceptional Mana Oil
spells(45397, {3266}) -- Righteous Weapon Coating
spells(45395, {3265}) -- Blessed Weapon Coating
---Warlock stuff
spells(55178, {3615, 3616, 3617, 3618, 3619, 3620}) -- Spellstone
spells(55153, {3609, 3610, 3611, 3612, 3613, 3614, 3597}) -- Firestone
---Shaman stuff
spells(25587, {563, 564, 1783, 2638, 2639, 3014}) -- Windfury Totem
spells(25505, {283, 284, 525, 1669, 2636, 3785, 3786, 3787}) -- Windfury Weapon
spells(25557, {124, 285, 543, 1683, 2637}) -- Flametongue Totem
spells(25489, {5, 4, 3, 523, 1665, 1666, 2634, 3779, 3780, 3781}) -- Flametongue Weapon
spells(25500, {2, 12, 524, 1667, 1668, 2635, 3782, 3783, 3784}) -- Frostbrand Weapon
spells(51730, {3345, 3346, 3347, 3348, 3349, 3350}) -- Earthliving Weapon
spells(8017, {
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
--- Misc
spells(29452, {2712}) -- Fel Sharpening Stone
spells(29453, {2713}) -- Adamantite Sharpening Stone
spells(22756, {2506}) -- Elemental Sharpening Stone
spells(16138, {1643}) -- Dense Sharpening Stone
spells(2828, {40}) -- Rough Sharpening Stone
spells(28891, {2684}) -- Consecrated Sharpening Stone
spells(2829, {13}) -- Coarse Sharpening Stone
spells(9900, {483}) -- Solid Sharpening Stone
spells(2830, {14}) -- Heavy Sharpening Stone
spells(56308, {2713}) -- Sharpen Blade
spells(3595, {26}) -- Frost Oil
spells(3594, {25}) -- Shadow Oil
spells(29720, {2720}) -- Greater Ward of Shielding
spells(29507, {2719}) -- Lesser Ward of Shielding
spells(38615, {3102}) -- Bloodboil Poison
spells(6650, {42}) -- Instant Toxin
spells(34339, {2954}) -- Fel Weightstone
spells(28898, {3592}) -- Blessed Wizard Oil
--- Fishing
spells(8089, {266}) -- Aquadynamic Fish Attractor
spells(8532, {264}) -- Aquadynamic Fish Lens
spells(9092, {265}) -- Flesh Eating Worm
spells(8088, {264}) -- Nightcrawlers
spells(45731, {266}) -- Sharpened Fish Hook
spells(8087, {263}) -- Shiny Bauble
spells(64401, {3868}) -- Glow Worm
