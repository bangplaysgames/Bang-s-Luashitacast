local bluTables = {}

bluTables.BLU = {
    ["Pollen"] = { type = "Healing", mods = { ['MND'] = 0, ['VIT'] = 0 } },
    ["Sandspin"] = { type = "Magical", mods = { ['INT'] = 20 } },
    ["Foot Kick"] = { type = "Physical", mods = { ['STR'] = 10, ['DEX'] = 10 } },
    ["Sprout Smack"] = { type = "Physical", mods = { ['VIT'] = 30 } },
    ["Wild Oats"] = { type = "Physical", mods = { ['AGI'] = 30 } },
    ["Power Attack"] = { "Physical", mods = { ['STR'] = 10, ['VIT'] = 10 } },
    ["Cocoon"] = { type = "Enhancing", mods = {} },
    ["Metallic Body"] = { type = "Enhancing", mods = {} },
    ["Queasyshroom"] = { "Physical", mods = { ['INT'] = 20 } },
    ["Battle Dance"] = { "Physical", mods = { ['STR'] = 30 } },
    ["Feather Storm"] = { "Physical", mods = { ['AGI'] = 30 } },
    ["Head Butt"] = { type = "Physical", mods = { ['STR'] = 20, ['INT'] = 20 } },
    ["Healing Breeze"] = { type = "Healing", mods = {} },
    ["Sheep Song"] = { type = "Enfeebling", mods = {} },
    ["Helldive"] = { "Physical", mods = { ['AGI'] = 30 } },
    ["Cursed Sphere"] = { "Magical", mods = { ['INT'] = 30 } },
    ["Blastbomb"] = { "Magical", mods = { ['INT'] = 20 } },
    ["Bludgeon"] = { "Physical", mods = { ['CHR'] = 30 } },
    ["Blood Drain"] = { type = "Magical", mods = {} },
    ["Claw Cyclone"] = { "Physical", mods = { ['DEX'] = 30 } },
    ["Poison Breath"] = { type = "Breath", mods = {} },
    ["Soporific"] = { type = "Enfeebling", mods = {} },
    ["Screwdriver"] = { "Physical", mods = { ['STR'] = 20, ['MND'] = 20 } },
    ["Bomb Toss"] = { "Magical", mods = { ['INT'] = 20 } },
    ["Grand Slam"] = { "Physical", mods = { ['VIT'] = 30 } },
    ["Wild Carrot"] = { type = "Healing", mods = {} },
    ["Chaotic Eye"] = { type = "Enfeebling", mods = {} },
    ["Sound Blast"] = { type = "Enfeebling", mods = {} },
    ["Death Ray"] = { "Magical", mods = { ['INT'] = 20, ['MND'] = 20 } },
    ["Smite of Rage"] = { "Physical", mods = { ['STR'] = 20, ['DEX'] = 20 } },
    ["Digest"] = { type = "Magical", mods = {} },
    ["Pinecone Bomb"] = { "Physical", mods = { ['STR'] = 20, ['AGI'] = 20 } },
    ["Blank Gaze"] = { type = "Enfeebling", mods = {} },
    ["Jet Stream"] = { "Physical", mods = { ['AGI'] = 30 } },
    ["Uppercut"] = { "Physical", mods = { ['STR'] = 35 } },
    ["Mysterious Light"] = { "Magical", mods = { ['CHR'] = 30 } },
    ["Terror Touch"] = { "Physical", mods = { ['DEX'] = 20, ['INT'] = 20 } },
    ["MP Drainkiss"] = { type = "Magical", mods = {} },
    ["Venom Shell"] = { type = "Enfeebling", mods = {} },
    ["Stinking Gas"] = { type = "Enfeebling", mods = {} },
    ["Blitzstrahl"] = { "Magical", mods = { ['INT'] = 30, ['MND'] = 10 } },
    ["Mandibular Bite"] = { "Physical", mods = { ['STR'] = 20, ['INT'] = 20 } },
    ["Awful Eye"] = { type = "Enfeebling", mods = {} },
    ["Geist Wall"] = { type = "Enfeebling", mods = {} },
    ["Magnetite Cloud"] = { type = "Breath", mods = {} },
    ["Jettatura"] = { type = "Enfeebling", mods = {} },
    ["Blood Saber"] = { type = "Magical", mods = {} },
    ["Refueling"] = { type = "Enhancing", mods = {} },
    ["Sickle Slash"] = { "Physical", mods = { ['DEX'] = 50 } },
    ["Ice Break"] = { "Magical", mods = { ['INT'] = 30 } },
    ["Self-Destruct"] = { type = "Magical", mods = { ['HP'] = 100 } },
    ["Frightful Roar"] = { type = "Enfeebling", mods = {} },
    ["Cold Wave"] = { type = "Enfeebling", mods = {} },
    ["Filamented Hold"] = { type = "Enfeebling", mods = {} },
    ["Hecatomb Wave"] = { type = "Breath", mods = {} },
    ["Radiant Breath"] = { type = "Breath", mods = {} },
    ["Feather Barrier"] = { type = "Enhancing", mods = {} },
    ["Light of Penance"] = { type = "Enfeebling", mods = {} },
    ["Flying Hip Press"] = { type = "Breath", mods = {} },
    ["Magic Fruit"] = { type = "Healing", mods = { ['MND'] = 0, ['VIT'] = 0, ['Healing Magic'] = 0 } },
    ["Dimensional Death"] = { "Physical", mods = { ['STR'] = 50 } },
    ["Spiral Spin"] = { "Physical", mods = { ['AGI'] = 30 } },
    ["Death Scissors"] = { "Physical", mods = { ['STR'] = 60 } },
    ["Eyes on Me"] = { "Magical", mods = { ['CHR'] = 40 } },
    ["Bad Breath"] = { type = "Breath", mods = {} },
    ["Maelstrom"] = { "Magical", mods = { ['INT'] = 30, ['MND'] = 10 } },
    ["Seedspray"] = { "Physical", mods = { ['DEX'] = 30 } },
    ["1000 Needles"] = { type = "Magical", mods = {} },
    ["Memento Mori"] = { type = "Enhancing", mods = {} },
    ["Body Slam"] = { "Physical", mods = { ['VIT'] = 40 } },
    ["Hydro Shot"] = { "Physical", mods = { ['AGI'] = 30 } },
    ["Frypan"] = { "Physical", mods = { ['STR'] = 20, ['MND'] = 20 } },
    ["Frenetic Rip"] = { type = "Physical", mods = { ['STR'] = 20, ['DEX'] = 20 } },
    ["Spinal Cleave"] = { "Physical", mods = { ['STR'] = 30 } },
    ["Voracious Trunk"] = { type = "Enfeebling", mods = {} },
    ["Feather Tickle"] = { type = "Enfeebling", mods = {} },
    ["Yawn"] = { type = "Enfeebling", mods = {} },
    ["Infrasonics"] = { type = "Enfeebling", mods = {} },
    ["Zephyr Mantle"] = { type = "Enhancing", mods = {} },
    ["Corrosive Ooze"] = { "Magical", mods = { ['INT'] = 20 } },
    ["Sandspray"] = { type = "Enfeebling", mods = {} },
    ["Frost Breath"] = { type = "Breath", mods = {} },
    ["Diamondhide"] = { type = "Enhancing", mods = {} },
    ["Enervation"] = { type = "Enfeebling", mods = {} },
    ["Firespit"] = { "Magical", mods = { ['INT'] = 20, ['MND'] = 20 } },
    ["Tail Slap"] = { "Physical", mods = { ['STR'] = 20, ['VIT'] = 50 } },
    ["Hysteric Barrage"] = { "Physical", mods = { ['DEX'] = 30 } },
    ["Asuran Claws"] = { type = "Physical", mods = { ['STR'] = 10, ['DEX'] = 10 } },
    ["Cannonball"] = { "Physical", mods = { ['STR'] = 50, ['VIT'] = 50 } },
    ["Amplification"] = { type = "Enhancing", mods = {} },
    ["Heat Breath"] = { type = "Breath", mods = {} },
    ["Lowing"] = { type = "Enfeebling", mods = {} },
    ["Triumphant Roar"] = { type = "Enhancing", mods = {} },
    ["Saline Coat"] = { type = "Enhancing", mods = {} },
    ["Disseverment"] = { type = "Physical", mods = { ['STR'] = 20, ['DEX'] = 20} },
    ["Sub-zero Smash"] = { type = "Physical", mods = { ['VIT'] = 60 } },
    ["Temporal Shift"] = { type = "Enhancing", mods = {} },
    ["Ram Charge"] = { "Physical", mods = { ['STR'] = 30, ['MND'] = 50 } },
    ["Mind Blast"] = { "Magical", mods = { ['MND'] = 30 } },
    ["Actinic Burst"] = { type = "Enfeebling", mods = {} },
    ["Reactor Cool"] = { type = "Enhancing", mods = {} },
    ["Magic Hammer"] = { "Magical", mods = { ['MND'] = 30 } },
    ["Exuviation"] = { type = "Healing", mods = {} },
    ["Plasma Charge"] = { type = "Enhancing", mods = {} },
    ["Vertical Cleave"] = { type = "Physical", mods = { ['STR'] = 50 } },
    ["Plenilune Embrace"] = { "Healing", mods = { ['MND'] = 200 } },
    ["Acrid Stream"] = { type = "Magical", mods = { ['MND'] = 30 } },
    ["Leafstorm"] = { type = "Magical", mods = { ['STR'] = 30 } },
    ["Cimicine Discharge"] = { type = "Enfeebling", mods = {} },
    ["Regeneration"] = { type = "Enhancing", mods = {} },
    ["Animating Wail"] = { type = "Enhancing", mods = {} },
    ["Battery Charge"] = { type = "Enhancing", mods = {} },
    ["Blazing Bound"] = { type = "Magical", mods = { ['STR'] = 30 } },
    ["Demoralizing Roar"] = { type = "Enfeebling", mods = {} },
    ["Final Sting"] = { type = "Physical", mods = { ['HP'] = 100 } },
    ["Goblin Rush"] = { type = "Physical", mods = { ['STR'] = 30, ['DEX'] = 30 } },
    ["Vanity Dive"] = { type = "Physical", mods = { ['DEX'] = 50 } },
    ["Magic Barrier"] = { type = "Enhancing", mods = {} },
    ["Whirl of Rage"] = { type = "Physical", mods = { ['STR'] = 30, ['MND'] = 30 } },
    ["Benthic Typhoon"] = { type = "Physical", mods = { ['AGI'] = 60 } },
    ["Auroral Drape"] = { type = "Enhancing", mods = {} },
    ["Osmosis"] = { type = "Magical", mods = {} },
    ["Quad. Continuum"] = { type = "Physical", mods = { ['STR'] = 32, ['VIT'] = 32 } },
    ["Fantod"] = { type = "Enfeebling", mods = {} },
    ["Thermal Pulse"] = { type = "Magical", mods = { ['VIT'] = 40 } },
    ["Empty Thrash"] = { type = "Physical", mods = { ['STR'] = 50 } },
    ["Dream Flower"] = { type = "Enfeebling", mods = {} },
    ["Occultation"] = { type = "Enhancing", mods = {} },
    ["Charged Whisker"] = { type = "Magical", mods = { ['DEX'] = 50 } },
    ["Winds of Promy."] = { type = "Healing", mods = {} },
    ["Delta Thrust"] = { type = "Physical", mods = { ['STR'] = 20, ['VIT'] = 50 } },
    ["Evryone. Grudge"] = { type = "Magical", mods = { ['MND'] = 40 } },
    ["Reaving Wind"] = { type = "Enfeebling", mods = {} },
    ["Barrier Tusk"] = { type = "Enhancing", mods = {} },
    ["Mortal Ray"] = { type = "Enfeebling", mods = {} },
    ["Water Bomb"] = { type = "Magical", mods = { ['INT'] = 20, ['MND'] = 10 } },
    ["Heavy Strike"] = { type = "Physical", mods = { ['STR'] = 50 } },
    ["Dark Orb"] = { type = "Magical", mods = { ['INT'] = 40 } },
    ["White Wind"] = { type = "Healing", mods = {} },
    ["Sudden Lunge"] = { type = "Physical", mods = { ['AGI'] = 40 } },
    ["Thunderbolt"] = { type = "Magical", mods = { ['INT'] = 30, ['MND'] = 20 } },
    ["Harden Shell"] = { type = "Enhancing", mods = {} },
    ["Quadrastrike"] = { type = "Physical", mods = { ['STR'] = 30 } },
    ["Vapor Spray"] = { type = "Breath", mods = {} },
    ["Absolute Terror"] = { type = "Enfeebling", mods = {} },
    ["Thunder Breath"] = { type = "Breath", mods = {} },
    ["Gates of Hades"] = { type = "Magical", mods = { ['STR'] = 20, ['DEX'] = 20 } },
    ["Tourbillion"] = { type = "Physical", mods = { ['STR'] = 25, ['MND'] = 25 } },
    ["O. Counterstance"] = { type = "Enhancing", mods = {} },
    ["Amorphic Spikes"] = { type = "Physical", mods = { ['DEX'] = 20, ['INT'] = 20 } },
    ["Pyric Bulwark"] = { type = "Enhancing", mods = {} },
    ["Wind Breath"] = { type = "Breath", mods = {} },
    ["Barbed Crescent"] = { type = "Physical", mods = { ['DEX'] = 50 } },
    ["Bilgestorm"] = { type = "Physical", mods = {} },
    ["Bloodrake"] = { type = "Physical", mods = { ['STR'] = 30, ['MND'] = 30 } },

}

bluTables.Properties = {
    ['Foot Kick'] = { 'Breeze' },
    ['Sprout Smack'] = { 'Aqua' },
    ['Wild Oats'] = { 'Light' },
    ['Power Attack'] = { 'Aqua' },
    ['Queasyshroom'] = { 'Shadow' },
    ['Battle Dance'] = { 'Thunder' },
    ['Feather Storm'] = { 'Light' },
    ['Head Butt'] = { 'Thunder' },
    ['Helldive'] = { 'Light' },
    ['Bludgeon'] = { 'Flame' },
    ['Claw Cyclone'] = { 'Soil' },
    ['Screwdriver'] = { 'Light', 'Soil' },
    ['Grand Slam'] = { 'Snow' },
    ['Smite of Rage'] = { 'Breeze' },
    ['Pinecone Bomb'] = { 'Flame' },
    ['Jet Stream'] = { 'Thunder' },
    ['Uppercut'] = { 'Flame', 'Thunder' },
    ['Terror Touch'] = { 'Shadow', 'Aqua' },
    ['Mandibular Bite'] = { 'Snow' },
    ['Sickle Slash'] = { 'Shadow' },
    ['Dimensional Death'] = { 'Shadow', 'Aqua' },
    ['Spiral Spin'] = { 'Light' },
    ['Death Scissors'] = { 'Shadow', 'Aqua' },
    ['Seedspray'] = { 'Snow', 'Breeze' },
    ['Body Slam'] = { 'Thunder' },
    ['Hydro Shot'] = { 'Aqua' },
    ['Frypan'] = { 'Thunder' },
    ['Frenetic Rip'] = { 'Snow' },
    ['Spinal Cleave'] = { 'Soil', 'Breeze' },
    ['Tail Slap'] = { 'Aqua' },
    ['Hysteric Barrage'] = { 'Breeze' },
    ['Asuran Claws'] = { 'Flame', 'Thunder' },
    ['Cannonball'] = { 'Flame', 'Light' },
    ['Disseverment'] = { 'Snow', 'Aqua' },
    ['Sub-zero Smash'] = { 'Thunder', 'Breeze' },
    ['Ram Charge'] = { 'Thunder', 'Breeze' },
    ['Vertical Cleave'] = { 'Shadow', 'Soil' },
    ['Final Sting'] = { 'Flame', 'Light' },
    ['Goblin Rush'] = { 'Flame', 'Light', 'Thunder' },
    ['Vanity Dive'] = { 'Soil' },
    ['Whirl of Rage'] = { 'Soil', 'Breeze' },
    ['Benthic Typhoon'] = { 'Shadow', 'Soil', 'Light' },
    ['Quad. Continuum'] = { 'Snow', 'Aqua', 'Soil' },
    ['Empty Thrash'] = { 'Shadow', 'Soil' },
    ['Delta Thrust'] = { 'Flame', 'Breeze' },
    ['Heavy Strike'] = { 'Thunder', 'Breeze', 'Light' },
    ['Sudden Lunge'] = { 'Breeze' },
    ['Quadrastrike'] = { 'Flame', 'Soil' },
    ['Tourbillion'] = { 'Flame', 'Light', 'Thunder', 'Breeze' },
    ['Amorphic Spikes'] = { 'Shadow', 'Soil', 'Light' },
    ['Barbed Crescent'] = { 'Snow', 'Aqua', 'Flame' },
    ['Bilgestorm'] = { 'Shadow', 'Soil', 'Snow', 'Aqua' },
    ['Bloodrake'] = { 'Shadow', 'Soil', 'Snow', 'Aqua' },
}

local baseAttributes = { 'STR', 'DEX', 'AGI', 'VIT', 'INT', 'MND', 'CHR', 'HP' };
local spellSetAliases = {
    STR = 'STR_NoSlow',
    DEX = 'DEX_NoSlow'
};

local getBLUEntry = function(name)
    local bluTable = bluTables.BLU[name];
    if(bluTable == nil)then
        return nil;
    end

    if(type(bluTable) == 'table')then
        return {
            type = bluTable.type or bluTable[1] or 'Not Blue Magic',
            mods = bluTable.mods or {}
        };
    end

    if(type(bluTable) == 'string')then
        return {
            type = bluTable,
            mods = {}
        };
    end
end

local getModifierTable = function(name)
    local entry = getBLUEntry(name);
    local modTable = {};

    if(entry == nil or entry.mods == nil)then
        return modTable;
    end

    for i = 1,#baseAttributes do
        local stat = baseAttributes[i];
        local value = entry.mods[stat];
        if(type(value) == 'number' and value > 0)then
            table.insert(modTable, { stat = stat, value = value });
        end
    end

    table.sort(modTable, function(a,b) return a.value < b.value end);

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

bluTables.getMods = function(name, sets)
    local modTable = getModifierTable(name);

    if(sets == nil)then
        return modTable;
    end

    local bestSet = {};
    local bestScores = {};

    for i = 1,#baseAttributes do
        local stat = baseAttributes[i];
        local setName = spellSetAliases[stat] or stat;
        local statSet = sets[setName] or sets[stat];
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

bluTables.SetModString = function(modTable)
    local modstring = '';
    if(modTable ~= nil)then
        for i = 1,#modTable do
            local mod = modTable[i].stat;
            local value = modTable[i].value;
            local tempstring = modstring;
            if(modstring ~= '')then
                modstring = tempstring .. ' | ';
            end
            tempstring = modstring;
            modstring = tempstring .. mod .. ': ' .. tostring(value);
        end
    end
    return modstring;
end

bluTables.GetGorget = function(name, gorgets)
    local properties = bluTables.Properties[name];
    if(properties == nil or gorgets == nil)then
        return nil;
    end

    for i = 1,#properties do
        local property = properties[i];
        if(gorgets[property] ~= nil)then
            return gorgets[property];
        end
    end

    return nil;
end
bluTables.getGorget = bluTables.GetGorget;


bluTables.GetBLU = function(name)
    local bluTable = getBLUEntry(name);
    local BLUtype = 'Not Blue Magic';
    local BLUmods = {};
    if(bluTable ~= nil)then
        BLUtype = bluTable.type or BLUtype;
        BLUmods = bluTable.mods or BLUmods;
    end
    return BLUtype, BLUmods;
end

return bluTables;
