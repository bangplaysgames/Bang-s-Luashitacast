local helpers = gFunc.LoadFile('..\\lib\\helpers.lua');

local modifiers = {}

modifiers.STR = {
    ['Slice'] = 100,
    ['Dark Harvest'] = 40,
    ['Shadow of Death'] = 40,
    ['Nightmare Scythe'] = 60,
    ['Spinning Scythe'] = 100,
    ['Vorpal Scythe'] = 100,
    ['Guillotine'] = 30,
    ['Cross Reaper'] = 60,
    ['Spiral Hell'] = 50,
    ['Infernal Scythe'] = 30,
    ['Catastrophe'] = 40,
    ['Quietus'] = 60,
    ['Insurgency'] = 20,
    ['Combo'] = 30,
    ['Backhand Blow'] = 50,
    ['Raging Fists'] = 30,
    ['Spinning Attack'] = 100,
    ['Dragon Kick'] = 50,
    ['Asuran Fists'] = 15,
    ['Tornado Kick'] = 40,
    ['Victory Smite'] = 80,
    ['Ascetic\'s Fury'] = 50,
    ['Stringing Pummel'] = 32,
    ['Mercy Stroke'] = 80,
    ['Pyrrhic Kleos'] = 40,
    ['Fast Blade'] = 40,
    ['Burning Blade'] = 40,
    ['Red Lotus Blade'] = 40,
    ['Flat Blade'] = 100,
    ['Shining Blade'] = 40,
    ['Seraph Blade'] = 40,
    ['Circle Blade'] = 100,
    ['Vorpal Blade'] = 60,
    ['Swift Blade'] = 50,
    ['Savage Blade'] = 50,
    ['Sanguine Blade'] = 30,
    ['Knights of Round'] = 40,
    ['Death Blossom'] = 30,
    ['Expiacion'] = 30,
    ['Uriel Blade'] = 32,
    ['Hard Slash'] = 100,
    ['Power Slash'] = 60,
    ['Frostbite'] = 40,
    ['Freezebite'] = 40,
    ['Shockwave'] = 30,
    ['Crescent Moon'] = 80,
    ['Sickle Moon'] = 40,
    ['Spinning Slash'] = 50,
    ['Ground Strike'] = 50,
    ['Resolution'] = 85,
    ['Scourge'] = 40,
    ['Raging Axe'] = 60,
    ['Smash Axe'] = 100,
    ['Gale Axe'] = 100,
    ['Avalanche Axe'] = 60,
    ['Spinning Axe'] = 60,
    ['Rampage'] = 50,
    ['Calamity'] = 50,
    ['Mistral Axe'] = 50,
    ['Decimation'] = 50,
    ['Ruinator'] = 85,
    ['Cloudsplitter'] = 40,
    ['Shield Break'] = 60,
    ['Iron Tempest'] = 60,
    ['Sturmwind'] = 60,
    ['Armor Break'] = 60,
    ['Keen Edge'] = 100,
    ['Weapon Break'] = 60,
    ['Raging Rush'] = 50,
    ['Full Break'] = 50,
    ['Steel Cyclone'] = 60,
    ['Fell Cleave'] = 60,
    ['Metatron Torment'] = 80,
    ['Ukko\'s Fury'] = 80,
    ['King\'s Justice'] = 50,
    ['Double Thrust'] = 30,
    ['Thunder Thrust'] = 40,
    ['Raiden Thrust'] = 40,
    ['Leg Sweep'] = 100,
    ['Penta Thrust'] = 20,
    ['Vorpal Thrust'] = 50,
    ['Skewer'] = 50,
    ['Wheeling Thrust'] = 80,
    ['Impulse Drive'] = 100,
    ['Sonic Thrust'] = 40,
    ['Stardiver'] = 85,
    ['Camlann\'s Torment'] = 60,
    ['Drakesbane'] = 50,
    ['Blade: Rin'] = 60,
    ['Blade: Retsu'] = 20,
    ['Blade: Teki'] = 30,
    ['Blade: To'] = 40,
    ['Blade: Chi'] = 30,
    ['Blade: Ei'] = 40,
    ['Blade: Jin'] = 30,
    ['Blade: Ten'] = 30,
    ['Blade: Ku'] = 30,
    ['Blade: Kamu'] = 60,
    ['Tachi: Enpi'] = 60,
    ['Tachi: Hobaku'] = 60,
    ['Tachi: Goten'] = 60,
    ['Tachi: Kagero'] = 75,
    ['Tachi: Jinpu'] = 30,
    ['Tachi: Koki'] = 50,
    ['Tachi: Yukikaze'] = 75,
    ['Tachi: Gekko'] = 75,
    ['Tachi: Kasha'] = 75,
    ['Tachi: Shoha'] = 85,
    ['Tachi: Kaiten'] = 80,
    ['Tachi: Fudo'] = 80,
    ['Tachi: Rana'] = 50,
    ['Heavy Swing'] = 100,
    ['Rock Crusher'] = 40,
    ['Earth Crusher'] = 40,
    ['Starburst'] = 40,
    ['Sunburst'] = 40,
    ['Shell Crusher'] = 100,
    ['Full Swing'] = 50,
    ['Cataclysm'] = 30,
    ['Shining Strike'] = 40,
    ['Seraph Strike'] = 40,
    ['Brainshaker'] = 100,
    ['Skullbreaker'] = 100,
    ['True Strike'] = 100,
    ['Judgment'] = 50,
    ['Hexa Strike'] = 30,
    ['Black Halo'] = 30,
    ['Flash Nova'] = 50,
    ['Randgrith'] = 40,
    ['Mystic Boon'] = 30,
    ['Flaming Arrow'] = 20,
    ['Piercing Arrow'] = 20,
    ['Dulling Arrow'] = 20,
    ['Sidewinder'] = 20,
    ['Blast Arrow'] = 20,
    ['Arching Arrow'] = 20,
    ['Empyreal Arrow'] = 20,
    ['Refulgent Arrow'] = 60,
    ['Namas Arrow'] = 40,

}

modifiers.VIT = {
    ['Shoulder Tackle'] = 100,
    ['One Inch Punch'] = 100,
    ['Asuran Fists'] = 15,
    ['Tornado Kick'] = 40,
    ['Final Heaven'] = 80,
    ['Ascetic\'s Fury'] = 50,
    ['Stringing Pummel'] = 32,
    ['Power Slash'] = 60,
    ['Herculean Slash'] = 80,
    ['Scourge'] = 40,
    ['Torcleaver'] = 80,
    ['Calamity'] = 50,
    ['Shield Break'] = 60,
    ['Armor Break'] = 60,
    ['Weapon Break'] = 60,
    ['Full Break'] = 50,
    ['Steel Cyclone'] = 60,
    ['Upheaval'] = 85,
    ['Camlann\'s Torment'] = 60,

}

modifiers.DEX = {
    ['Combo'] = 30,
    ['Backhand Blow'] = 50,
    ['Raging Fists'] = 30,
    ['Howling Fist'] = 50,
    ['Dragon Kick'] = 50,
    ['Shijin Spiral'] = 85,
    ['Wasp Sting'] = 100,
    ['Gust Slash'] = 40,
    ['Viper Bite'] = 100,
    ['Cyclone'] = 40,
    ['Dancing Edge'] = 40,
    ['Shark Bite'] = 40,
    ['Evisceration'] = 50,
    ['Aeolian Edge'] = 40,
    ['Rudra\'s Storm'] = 80,
    ['Mandalic Stab'] = 60,
    ['Mordant Rime'] = 30,
    ['Pyrrhic Kleos'] = 40,
    ['Fast Blade'] = 40,
    ['Chant du Cygne'] = 80,
    ['Expiacion'] = 20,
    ['Dimidiation'] = 80,
    ['Bora Axe'] = 100,
    ['Onslaught'] = 80,
    ['Primal Rend'] = 30,
    ['Double Thrust'] = 30,
    ['Penta Thrust'] = 20,
    ['Sonic Thrust'] = 40,
    ['Geirskogul'] = 80,
    ['Blade: Rin'] = 60,
    ['Blade: Retsu'] = 60,
    ['Blade: Jin'] = 30,
    ['Blade: Ten'] = 30,
    ['Blade: Ku'] = 30,
    ['Blade: Yu'] = 40,
    ['Blade: Shun'] = 85,
    ['Blade: Metsu'] = 80,
    ['Jishnu\'s Radiance'] = 80,
    ['Coronach'] = 40,

}

modifiers.AGI = {
    ['Shark Bite'] = 40,
    ['Exenterator'] = 85,
    ['Sickle Moon'] = 40,
    ['Vorpal Thrust'] = 50,
    ['Blade: Hi'] = 80,
    ['Flaming Arrow'] = 50,
    ['Piercing Arrow'] = 50,
    ['Dulling Arrow'] = 50,
    ['Sidewinder'] = 50,
    ['Blast Arrow'] = 50,
    ['Arching Arrow'] = 50,
    ['Empyreal Arrow'] = 50,
    ['Apex Arrow'] = 85,
    ['Hot Shot'] = 70,
    ['Split Shot'] = 70,
    ['Sniper Shot'] = 70,
    ['Slug Shot'] = 70,
    ['Blast Shot'] = 70,
    ['Heavy Shot'] = 70,
    ['Detonator'] = 70,
    ['Numbing Shot'] = 80,
    ['Last Stand'] = 85,
    ['Coronach'] = 40,
    ['Wildfire'] = 60,
    ['Trueflight'] = 100,
    ['Leaden Salute'] = 100,

}

modifiers.INT = {
    ['Dark Harvest'] = 40,
    ['Shadow of Death'] = 40,
    ['Spiral Hell'] = 50,
    ['Infernal Scythe'] = 70,
    ['Entropy'] = 85,
    ['Catastrophe'] = 40,
    ['Insurgency'] = 20,
    ['Gust Slash'] = 40,
    ['Cyclone'] = 40,
    ['Aeolian Edge'] = 40,
    ['Burning Blade'] = 40,
    ['Red Lotus Blade'] = 40,
    ['Expiacion'] = 30,
    ['Frostbite'] = 40,
    ['Freezebite'] = 40,
    ['Spinning Slash'] = 30,
    ['Groundstrike'] = 50,
    ['Thunder Thrust'] = 40,
    ['Raiden Thrust'] = 40,
    ['Blade: Teki'] = 30,
    ['Blade: To'] = 40,
    ['Blade: Chi'] = 30,
    ['Blade: Ei'] = 40,
    ['Blade: Yu'] = 40,
    ['Blade: Kamu'] = 60,
    ['Rock Crusher'] = 40,
    ['Earth Crusher'] = 40,
    ['Spirit Taker'] = 50,
    ['Shattersoul'] = 85,
    ['Gate of Tartarus'] = 80,
    ['Vidohunir'] = 80,
    ['Tartarus Torpor'] = 30,
    ['Exudation'] = 50,

}

modifiers.MND = {
    ['Guillotine'] = 50,
    ['Cross Reaper'] = 60,
    ['Quietus'] = 60,
    ['Energy Steal'] = 100,
    ['Energy Drain'] = 100,
    ['Shining Blade'] = 40,
    ['Seraph Blade'] = 40,
    ['Swift Blade'] = 50,
    ['Savage Blade'] = 50,
    ['Sanguine Blade'] = 50,
    ['Requiescat'] = 85,
    ['Knights of Round'] = 40,
    ['Death Blossom'] = 50,
    ['Uriel Blade'] = 32,
    ['Shockwave'] = 30,
    ['Cloudsplitter'] = 40,
    ['Tachi: Koki'] = 30,
    ['Starburst'] = 40,
    ['Sunburst'] = 40,
    ['Retribution'] = 50,
    ['Garland of Bliss'] = 70,
    ['Omnicience'] = 80,
    ['Shining Strike'] = 40,
    ['Seraph Strike'] = 40,
    ['Judgment'] = 50,
    ['Hexa Strike'] = 30,
    ['Black Halo'] = 70,
    ['Realmrazer'] = 85,
    ['Mystic Boon'] = 70,
    ['Exudiation'] = 50

}

modifiers.CHR = {
    ['Shadowstitch'] = 100,
    ['Dancing Edge'] = 40,
    ['Mordant Rime'] = 70,
    ['Primal Rend'] = 60,
    ['Tachi: Ageha'] = 60,

}

modifiers.Properties = {
    --Sword
    ['Fast Blad'] = { 'Soil' },
    ['Burning Blade'] = { 'Flame' },
    ['Red Lotus Blade'] = { 'Flame', 'Breeze' },
    ['Flat Blade'] = { 'Thunder' },
    ['Shining Blade'] = { 'Soil' },
    ['Seraph Blade'] = { 'Soil' },
    ['Circle Blade'] = { 'Reverberation', 'Thunder' },
    ['Spirits Within'] = { '' },
    ['Vorpal Blade'] = { 'Soil', 'Thunder' },
    ['Swift Blade'] = { 'Soil', 'Dark' },
    ['Savage Blade'] = { 'Thunder', 'Breeze', 'Soil' },
    ['Sanguine Blade'] = { '' },
    ['Requiescat'] = { 'Soil', 'Dark' },
    ['Knights of Round'] = { 'Light', 'Flame', 'Breeze', 'Thunder' },
    ['Chant du Cygne'] = { 'Light', 'Flame', 'Breeze', 'Thunder', 'Snow', 'Aqua' },
    ['Death Blossom'] = { 'Breeze', 'Thunder', 'Snow', 'Aqua' },
    ['Atonement'] = { 'Flame', 'Light', 'Aqua' },
    ['Expiacion'] = { 'Soil', 'Snow', 'Aqua' },
    ['Uriel Blade'] = { 'Flame', 'Light', 'Breeze', 'Thunder' },
    ['Glory Slash'] = { 'Flame', 'Light', 'Breeze', 'Thunder' },
    --Archery
    ['Flaming Arrow'] = {'Flame', 'Light'},
    ['Piercing Arrow'] = {'Thunder', 'Light'},
    ['Dulling Arrow'] = {'Flame', 'Light'},
    ['Sidewinder'] = {'Aqua', 'Light'},
    ['Blast Arrow'] = {'Snow', 'Light'},
    ['Arching Arrow'] = {'Flame', 'Light'},
    ['Refulgent Arrow'] = {'Aqua', 'Light'},
    ['Empyreal Arrow'] = {'Flame', 'Light'},
    ['Namas Arrow'] = {'Flame', 'Light', 'Aqua', 'Snow'},
    ['Jishnu\'s Radiance'] = {'Flame', 'Light', 'Thunder', 'Breeze'},
    ['Apex Arrow'] = {'Thunder', 'Breeze', 'Light'},
    --Axe
    ['Raging Axe'] = {'Breeze', 'Thunder'},
    ['Smash Axe'] = {'Snow', 'Water'},
    ['Gale Axe'] = {'Breeze'},
    ['Avalanche Axe'] = {'Soil', 'Thunder'},
    ['Spinning Axe'] = {'Flame', 'Soil'},
    ['Rampage'] = {'Soil'},
    ['Calamity'] = {'Soil', 'Thunder'},
    ['Mistral Axe'] = {'Flame', 'Light'},
    ['Bora Axe'] = {'Soil', 'Breeze'},
    ['Decimation'] = {'Flame', 'Light'},
    ['Onslaught'] = {'Shadow', 'Soil', 'Snow', 'Aqua'},
    ['Primal Rend'] = {'Soil', 'Shadow', 'Aqua'},
    ['Cloudsplitter'] = {'Shadow', 'Soil', 'Snow', 'Aqua', 'Thunder', 'Breeze'},
    ['Ruinator'] = {'Snow', 'Aqua', 'Breeze'},
    --Club
    ['Shining Strike'] = {'Thunder'},
    ['Seraph Strike'] = {'Thunder'},
    ['Brainshaker'] = {'Aqua'},
    ['Starlight'] = {''},
    ['Moonlight'] = {''},
    ['Skullbreaker'] = {'Snow', 'Aqua'},
    ['True Strike'] = {'Breeze', 'Thunder'},
    ['Judgment'] = {'Thunder'},
    ['Hexa Strike'] = {'Flame', 'Light'},
    ['Flash Nova'] = {'Snow', 'Aqua'},
    ['Black Halo'] = {'Thunder', 'Breeze', 'Shadow'},
    ['Randgrith'] = {'Thunder', 'Flame', 'Breeze', 'Light'},
    ['Mystic Boon'] = {''},
    ['Dagan'] = {''},
    ['Reamrazer'] = {'Flame', 'Light', 'Thunder'},
    ['Exudiation'] = {'Shadow', 'Soil', 'Snow', 'Aqua', 'Thunder', 'Breeze'},
    --Dagger
    ['Wasp Sting'] = {'Soil'},
    ['Gust Slash'] = {'Breeze'},
    ['Shadow'] = {'Aqua'},
    ['Viper Bite'] = {'Soil'},
    ['Cyclone'] = {'Breeze', 'Thunder'},
    ['Energy Steal'] = {''},
    ['Energy Drain'] = {''},
    ['Dancing Edge'] = {'Soil', 'Breeze'},
    ['Shark Bite'] = {'Breeze', 'Thunder'},
    ['Aeolian Edge'] = {'Thunder', 'Soil', 'Breeze'},
    ['Evisceration'] = {'Soil', 'Shadow', 'Light'},
    ['Exenterator'] = {'Thunder', 'Breeze', 'Soil'},
    ['Mercy Stroke'] = {'Shadow', 'Soil', 'Snow', 'Aqua'},
    ['Mandalic Stab'] = {'Flame', 'Light', 'Shadow'},
    ['Pyrrhic Kleos'] = {'Snow', 'Aqua', 'Soil'},
    ['Mordant Rime'] = {'Thunder', 'Breeze', 'Snow', 'Aqua'},
    ['Rudra\'s Storm'] = {'Soil', 'Shadow', 'Snow', 'Aqua'},
    --Great Axe
    ['Shield Break'] = {'Thunder'},
    ['Iron Tempest'] = {'Soil'},
    ['Sturmwind'] = {'Aqua', 'Soil'},
    ['Armor Break'] = {'Thunder'},
    ['Keen Edge'] = {'Shadow'},
    ['Weapon Break'] = {'Aqua'},
    ['Raging Rush'] = {'Snow', 'Aqua'},
    ['Full Break'] = {'Snow', 'Aqua'},
    ['Fell Cleave'] = {'Thunder', 'Soil', 'Breeze'},
    ['Steel Cyclone'] = {'Snow', 'Aqua', 'Breeze'},
    ['Upheaval'] = {'Flame', 'Light', 'Shadow'},
    ['Metatron Torment'] = {'Flame', 'Light', 'Thunder', 'Breeze'},
    ['King\'s Justice'] = {'Thunder', 'Breeze', 'Soil'},
    ['Ukko\'s Fury'] = {'Flame', 'Light', 'Thunder', 'Breeze'},
    --Great Katana
    ['Tachi: Enpi'] = {'Light', 'Soil'},
    ['Tachi: Hobaku'] = {'Snow'},
    ['Tachi: Goten'] = {'Light', 'Thunder'},
    ['Tachi: Kagero'] = {'Flame'},
    ['Tachi: Jinpu'] = {'Soil', 'Breeze'},
    ['Tachi: Koki'] = {'Aqua', 'Thunder'},
    ['Tachi: Yukikaze'] = {'Snow', 'Breeze'},
    ['Tachi: Gekko'] = {'Snow', 'Aqua'},
    ['Tachi: Ageha'] = {'Shadow', 'Soil'},
    ['Tachi: Kasha'] = {'Flame', 'Light', 'Shadow'},
    ['Tachi: Shoha'] = {'Thunder', 'Breeze', 'Shadow'},
    ['Tachi: Kaiten'] = {'Flame', 'Light', 'Thunder', 'Breeze'},
    ['Tachi: Rana'] = {'Soil', 'Shadow', 'Snow'},
    ['Tachi: Fudo'] = {'Flame', 'Light', 'Thunder', 'Breeze', 'Snow', 'Aqua'},
    --Great Sword
    ['Hard Slash'] = {'Soil'},
    ['Power Slash'] = {'Light'},
    ['Frost Bite'] = {'Snow'},
    ['Freezebite'] = {'Snow', 'Breeze'},
    ['Shockwave'] = {'Aqua'},
    ['Crescent Moon'] = {'Soil'},
    ['Sickle Moon'] = {'Soil', 'THunder'},
    ['Spinning Slash'] = {'Thunder', 'Breeze'},
    ['Herculean Slash'] = {'Snow', 'Thunder', 'Breeze'},
    ['Ground Strike'] = {'Breeze', 'Thunder', 'Snow', 'Aqua'},
    ['Resolution'] = {'Thunder', 'Breeze', 'Soil'},
    ['Scourge'] = {'Flame', 'Light', 'Thunder', 'Breeze'},
    ['Torcleaver'] = {'Flame', 'Light', 'Thunder', 'Breeze', 'Snow', 'Aqua'},
    ['Dimidiation'] = {'Flame', 'Light', 'Thunder', 'Breeze'},
    --H2H
    ['Combo'] = {'Thunder'},
    ['Shoulder Tackle'] = {'Aqua', 'Thunder'},
    ['One Inch Punch'] = {'Shadow'},
    ['Backhand Blow'] = {'Breeze'},
    ['Raging Fists'] = {'Thunder'},
    ['Spinning Attack'] = {'Flame', 'Thunder'},
    ['Howling Fist'] = {'Light', 'Thunder'},
    ['Dragon Kick'] = {'Thunder', 'Breeze'},
    ['Tornado Kick'] = {'Snow', 'Thunder', 'Breeze'},
    ['Asuran Fists'] = {'Soil', 'Shadow', 'Flame'},
    ['Final Heaven'] = {'Flame', 'Light', 'Thunder', 'Breeze'},
    ['Ascetic\'s Fury'] = {'Flame', 'Light'},
    ['Stringing Pummel'] = {'Soil', 'Shadow', 'Flame'},
    ['Victory Smite'] = {'Flame', 'Light', 'Thunder', 'Breeze'},
    ['Shijin Spiral'] = {'Flame', 'Light', 'Aqua'},
    --Katana
    ['Blade: Rin'] = {'Light'},
    ['Blade: Retsu'] = {'Soil'},
    ['Blade: Teki'] = {'Aqua'},
    ['Blade: To'] = {'Snow', 'Breeze'},
    ['Blade: Chi'] = {'Thunder', 'Light'},
    ['Blade: Ei'] = {'Shadow'},
    ['Blade: Jin'] = {'Thunder', 'Breeze'},
    ['Blade: Ten'] = {'Shadow', 'Soil'},
    ['Blade: Yu'] = {'Aqua', 'Soil'},
    ['Blade: Ku'] = {'Shadow', 'Soil', 'Light'},
    ['Blade: Shun'] = {'Flame', 'Light', 'Thunder'},
    ['Blade: Metsu'] = {'Shadow', 'Soil', 'Snow', 'Aqua', 'Thunder', 'Breeze'},
    ['Blade: Kamu'] = {'Thunder', 'Breeze', 'Shadow'},
    ['Blade: Hi'] = {'Shadow', 'Soil', 'Snow', 'Aqua'},
    --Marksmanship
    ['Hot Shot'] = {'Flame', 'Light'},
    ['Split Shot'] = {'Aqua', 'Light'},
    ['Sniper Shot'] = {'Flame', 'Light'},
    ['Slug Shot'] = {'Aqua', 'Light', 'Breeze'},
    ['Blast Shot'] = {'Snow', 'Light'},
    ['Heavy Shot'] = {'Flame', 'Light'},
    ['Numbing Shot'] = {'Thunder', 'Breeze'},
    ['Detonator'] = {'Flame', 'Light'},
    ['Coronach'] = {'Shadow', 'Soil', 'Snow', 'Aqua', 'Thunder', 'Breeze'},
    ['Trueflight'] = {'Thunder', 'Breeze', 'Soil'},
    ['Leaden Salute'] = {'Shadow', 'Soil', 'Light'},
    ['Wildfire'] = {'Shadow', 'Soil', 'Snow', 'Aqua'},
    ['Last Stand'] = {'Flame', 'Light', 'Aqua'},
    --Polearm
    ['Double Thrust'] = {'Light'},
    ['Thunder Thrust'] = {'Light', 'Thunder'},
    ['Raiden Thrust'] = {'Light', 'Thunder'},
    ['Leg Sweep'] = {'Thunder'},
    ['Penta Thrust'] = {'Shadow'},
    ['Vorpal Thrust'] = {'Aqua', 'Light'},
    ['Skewer'] = {'Light', 'Thunder'},
    ['Wheeling Thrust'] = {'Flame', 'Light'},
    ['Sonic Thrust'] = {'Light', 'Soil'},
    ['Impulse Drive'] = {'Shadow', 'Soil', 'Snow'},
    ['Sonic Thrust'] = {'Light', 'Soil'},
    ['Stardiver'] = {'Soil', 'Shadow', 'Light'},
    ['Gierskogul'] = {'Light', 'Thunder', 'Breeze', 'Flame', 'Snow', 'Aqua'},
    ['Camlann\'s Torment'] = {'Light', 'Thunder', 'Breeze', 'Flame'},
    ['Drakesbane'] = {'Flame', 'Light'},
    --Scythe
    ['Slice'] = {'Soil'},
    ['Dark Harvest'] = {'Aqua'},
    ['Shadow of Death'] = {'Snow', 'Aqua'},
    ['Nightmare Scythe'] = {'Dark', 'Soil'},
    ['Spinning Scythe'] = {'Aqua', 'Soil'},
    ['Vorpal Scythe'] = {'Light', 'Soil'},
    ['Guillotine'] = {'Snow'},
    ['Cross Reaper'] = {'Aqua', 'Snow'},
    ['Spiral Hell'] = {'Aqua', 'Snow', 'Soil'},
    ['Infernal Scythe'] = {'Dark', 'Aqua'},
    ['Entropy'] = {'Soil', 'Dark', 'Aqua'},
    ['Catastrophe'] = {'Snow', 'Aqua', 'Soil', 'Dark'},
    ['Quietus'] = {'Snow', 'Aqua', 'Soil', 'Dark'},
    ['Insurgency'] = {'Flame', 'Light', 'Dark'}
}

local WSElement = T{
    ['Seraph Strike'] = 'Light',
    ['Shining Strike'] = 'Light',
    ['Flash Nova'] = 'Light',
    ['Burning Blade'] = 'Fire',
    ['Red Lotus Blade'] = 'Fire',
    ['Shining Blade'] = 'Light',
    ['Seraph Blade'] = 'Light',
    ['Sanguine Blade'] = 'Dark',
    ['Gust Slash'] = 'Wind',
    ['Cyclone'] = 'Wind',
    ['Aeolian Edge'] = 'Wind',
    ['Frostbite'] = 'Ice',
    ['Freezebite'] = 'Ice',
    ['Dark Harvest'] = 'Dark',
    ['Shadow of Death'] = 'Dark',
    ['Blade: Teki'] = 'Water',
    ['Blade: To'] = 'Ice',
    ['Blade: Chi'] = 'Earth',
    ['Blade: Ei'] = 'Dark',
    ['Thunder Thrust'] = 'Thunder',
    ['Raiden Thrust'] = 'Thunder',
    ['Rock Crusher'] = 'Earth',
    ['Earth Breaker'] = 'Earth',
    ['Cataclysm'] = 'Dark',
    ['Tachi: Goten'] = 'Thunder',
    ['Tachi: Kagero'] = 'Fire',
    ['Tachi: Jinpu'] = 'Wind',
    ['Hot Shot'] = 'Fire',
    ['Wildfire'] = 'Fire',
    ['Leaden Salute'] = 'Dark'
}



--Exported Function
local baseAttributes = { 'STR', 'DEX', 'AGI', 'VIT', 'INT', 'MND', 'CHR' };

local getModifierTable = function(a)
    local modTable = {}
    if(modifiers.STR[a] ~= nil)then
        local mod = {stat = 'STR', value = modifiers.STR[a]};
        table.insert(modTable, mod);
    end
    if(modifiers.DEX[a] ~= nil)then
        local mod = {stat = 'DEX', value = modifiers.DEX[a]};
        table.insert(modTable, mod);
    end
    if(modifiers.AGI[a] ~= nil)then
        local mod = {stat = 'AGI', value = modifiers.AGI[a]};
        table.insert(modTable, mod);
    end
    if(modifiers.VIT[a] ~= nil)then
        local mod = {stat = 'VIT', value = modifiers.VIT[a]};
        table.insert(modTable, mod);
    end
    if(modifiers.INT[a] ~= nil)then
        local mod = {stat = 'INT', value = modifiers.INT[a]};
        table.insert(modTable, mod);
    end
    if(modifiers.MND[a] ~= nil)then
        local mod = {stat = 'MND', value = modifiers.MND[a]};
        table.insert(modTable, mod);
    end
    if(modifiers.CHR[a] ~= nil)then
        local mod = {stat = 'CHR', value = modifiers.CHR[a]};
        table.insert(modTable, mod);
    end

    table.sort(modTable, function(a,b) return a.value < b.value  end)

    return modTable;
end

local scoreItem = function(item, modTable, sourceStat)
    local score = 0;

    if(type(item) == 'table' and item.Mods ~= nil)then
        for i = 1,#modTable do
            local mod = modTable[i];
            if(item.Mods[mod.stat] ~= nil)then
                score = score + (item.Mods[mod.stat] * mod.value);
            end
        end
    elseif(sourceStat ~= nil)then
        for i = 1,#modTable do
            local mod = modTable[i];
            if(mod.stat == sourceStat)then
                score = score + mod.value;
            end
        end
    end

    return score;
end

local stripModData = function(item)
    if(type(item) ~= 'table' or item.Mods == nil)then
        return item;
    end

    local cleanItem = {};
    for k,v in pairs(item)do
        if(k ~= 'Mods')then
            cleanItem[k] = v;
        end
    end

    return cleanItem;
end

modifiers.getMods = function(a, sets)
    local modTable = getModifierTable(a);

    if(sets == nil)then
        return modTable;
    end

    local bestSet = {};
    local bestScores = {};

    for i = 1,#baseAttributes do
        local stat = baseAttributes[i];
        local statSet = sets[stat];
        if(statSet ~= nil)then
            for slot,item in pairs(statSet)do
                local score = scoreItem(item, modTable, stat);
                if(score > 0 and (bestScores[slot] == nil or score > bestScores[slot]))then
                    bestScores[slot] = score;
                    bestSet[slot] = stripModData(item);
                end
            end
        end
    end

    return bestSet, modTable;
end

modifiers.SetModString = function(a)
    local modstring = '';
    if(a ~= nil)then
        for i=1,#a do
            local mod = a[i].stat;
            local value = a[i].value;
            local tempstring = modstring;
            if modstring ~= '' then
                modstring = tempstring .. ' | ';
            end
            tempstring = modstring;
            modstring = tempstring .. mod .. ': ' .. tostring(value);
        end
    end
    return modstring;
end

modifiers.getGorget = function(a, g)
    local prop = modifiers.Properties[a];
    for i = 1,#prop do
        local property = prop[i];
        if(g[property] ~= nil)then
            --print(chat.header(tostring(g[property])));
            return g[property];
        end
    end
    return 'Nil';
end

modifiers.QuickDraw = function(a)
    local QDTab = { 'Light Shot', 'Dark Shot', 'Fire Shot', 'Water Shot', 'Thunder Shot', 'Earth Shot', 'Wind Shot', 'Ice Shot'}
    if helpers.hasEntry(QDTab, a)then
        return 'Quick Draw';
    end
end

modifiers.wearObi = function(s)
    local env = gData.GetEnvironment();
    if(s.Element == nil)then
        s.Element = WSElement[s.Name];
    end

    local stormTable = {
        ['Fire'] = 'Firestorm',
        ['Water'] = 'Rainstorm',
        ['Thunder'] = 'Thunderstorm',
        ['Earth'] = 'Sandstorm',
        ['Wind'] = 'Windstorm',
        ['Ice'] = 'Hailstorm',
        ['Light'] = 'Aurorastorm',
        ['Dark'] = 'Voidstorm'
    }

    local hasBuff = gData.GetBuffCount(stormTable[s.Element]) > 0;

    if ((s.Element == env.DayElement or s.Element == env.RawWeatherElement or hasBuff))then
        return true;
    else
        return false;
    end
end

modifiers.IsMAB = function(ws)
    local MABWS = T{ 
        ['Seraph Strike'] = 'Light', ['Shining Strike'] = 'Light', ['Flash Nova'] = 'Light',
        ['Burning Blade'] = 'Fire', ['Red Lotus Blade'] = 'Fire', ['Shining Blade'] = 'Light', 
        ['Seraph Blade'] = 'Light', ['Sanguine Blade'] = 'Dark', ['Gust Slash'] = 'Wind', 
        ['Cyclone'] = 'Wind', ['Aeolian Edge'] = 'Wind', ['Frostbite'] = 'Ice', 
        ['Freezebite'] = 'Ice', ['Dark Harvest'] = 'Dark', ['Shadow of Death'] = 'Dark', 
        ['Blade: Teki'] = 'Water', ['Blade: To'] = 'Ice', ['Blade: Chi'] = 'Earth', 
        ['Blade: Ei'] = 'Dark', ['Thunder Thrust'] = 'Thunder', ['Raiden Thrust'] = 'Thunder', 
        ['Rock Crusher'] = 'Earth', ['Earth Breaker'] = 'Earth', ['Cataclysm'] = 'Dark', 
        ['Tachi: Goten'] = 'Thunder', ['Tachi: Kagero'] = 'Fire', ['Tachi: Jinpu'] = 'Wind', 
        ['Tachi: Koki'] = 'Light', ['Hot Shot'] = 'Fire', ['Wildfire'] = 'Fire', ['Leaden Salute'] = 'Dark'}

    if(MABWS[ws] ~= nil)then
        return MABWS[ws];
    end

end

print('Return Modifier Tables');

return modifiers;
