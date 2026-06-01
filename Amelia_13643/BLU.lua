local profile = {};

local chat = require('chat');

local mod = gFunc.LoadFile('..\\lib\\modifierTables.lua');
local blu = gFunc.LoadFile('..\\lib\\bluTables.lua');

local warpring = function()
    AshitaCore:GetChatManager():QueueCommand(-1, '/item "Warp Ring" <me>');
end

local const = gFunc.LoadFile('constants.lua') or {};

local jHelp = gFunc.LoadFile('..\\lib\\JobHelpers.lua');

local help = gFunc.LoadFile('..\\lib\\helpers.lua');

local sets = {
    ['Idle'] = {
        Range = 'Moonring Blade',
        Head = 'Emperor Hairpin',
        Neck = 'Fortitude Torque',
        Ear1 = 'Brutal Earring',
        Ear2 = 'Coral Earring',
        Body = 'Mirage Jubbah',
        Hands = 'Magus Bazubands',
        Ring1 = 'Sniper\'s Ring +1',
        Ring2 = 'Rajas Ring',
        Back = 'Accura Cape',
        Waist = 'Swift Belt',
        Legs = { Name = 'Magus Shalwar +1', Augment = { [1] = '"Regen"+3', [2] = '"Refresh"+1' } },
        Feet = 'Nashira Crackows',
    },
    ['TP'] = {
        Range = 'Moonring Blade',
        Head = 'Homam Zucchetto',
        Neck = 'Fortitude Torque',
        Ear1 = 'Brutal Earring',
        Ear2 = 'Coral Earring',
        Body = 'Mirage Jubbah',
        Hands = 'Magus Bazubands',
        Ring1 = 'Sniper\'s Ring +1',
        Ring2 = 'Rajas Ring',
        Back = { Name = 'Nomad\'s Mantle', Augment = { [1] = 'DEF+3', [2] = '"Dual Wield"+1' } },
        Waist = 'Swift Belt',
        Legs = { Name = 'Magus Shalwar +1', Augment = { [1] = '"Regen"+3', [2] = '"Refresh"+1' } },
        Feet = 'Nashira Crackows',
    },
    ['Resting'] = {
    },
    ['STR'] = {
        Head = {Name = 'Voyager Sallet', Mods = { STR = 3, DEX = 4 }},
        Neck = {Name = 'Harmonia\'s Torque', Mods = { STR = 2, VIT = -1}},
        Body = {Name = 'Magus Jubbah', Mods = { STR = 3, DEX = 3 }},
        Ring1 = {Name = 'Flame Ring', Mods = { STR = 5, INT = 2, MND = -2 }},
        Ring2 = {Name = 'Rajas Ring', Mods = { STR = 5, DEX = 5 }},
        Back = {Name = 'Amemet Mantle', Mods = { STR = 1 }},
        Waist = {Name = 'Ryl.Kgt. Belt', Mods = { STR = 2, DEX = 2, AGI = 2, INT = 2, MND = 2, CHR = 2 }},
    },
    ['STR_NoSlow'] = {
    },
    ['DEX'] = {
        Head = { Name = 'Voyager Sallet', Mods = {STR = 3, DEX = 4 }},
        Body = { Name = 'Magus Jubbah', Mods = {STR = 3, DEX = 3}},
        Ring2 = { Name = 'Rajas Ring', Mods = {STR = 5, DEX = 5} },
        Waist = {Name = 'Ryl.Kgt. Belt', Mods = { STR = 2, DEX = 2, AGI = 2, INT = 2, MND = 2, CHR = 2 }},
        Legs = { Name = 'Magus Shalwar +1', Augment = { [1] = '"Regen"+3', [2] = '"Refresh"+1' }, Mods = {DEX = 5, VIT = 5, AGI = 5} },
    },
    ['DEX_NoSlow'] = {
    },
    ['VIT'] = {},
    ['AGI'] = {},
    ['INT'] = {},
    ['MND'] = {},
    ['CHR'] = {},
    ['FastCast'] = {
        Head = { Name = 'Entrancing Ribbon', Augment = { [1] = 'Pet: Rng. Acc.+2', [2] = '"Fast Cast"+1', [3] = 'Pet: Accuracy+2' } },
        Ear1 = 'Loquac. Earring',
    },
    ['lock'] = {
    },
    ['Blink'] = {
        ['Legs'] = 'Hume Pants',
    },
    ['Nuke'] = {
    },
    ['Refresh'] = {},
    ['Waltz'] = {},
    ['MAB'] = {
        Ear1 = 'Moldavite Earring',
    },
    ['Cures'] = {
        Neck = 'Colossus\'s Torque',
        Body = 'Magus Jubbah',
        Waist = 'Ryl.Kgt. Belt',
    },
    ['CurePot'] = {
        Hands = { Name = 'Silk Cuffs', Augment = { [1] = 'MP+15', [2] = '"Cure" potency +2%' } },
    }};
profile.Sets = sets;

profile.Packer = {
};

local Settings = {
    CurrentLevel = 0,
    CurrentSub = '',
    TP_Mode = 'Haste',
    wrdelay = 0,
    warpRing = false,
    wrUse = false;
    blinkDelay = 0,
    displayHead = false,
}

profile.OnLoad = function()
    gSettings.AllowAddSet = true;
    jHelp.ThotBar();
    gFunc.LockStyle(sets.lock);
    AshitaCore:GetChatManager():QueueCommand(-1, '/alias /warpring /lac fwd warpring');
    Settings.wrdelay = os.time() + 25;
    Settings.warpRing = false;
end

profile.OnUnload = function()
    AshitaCore:GetChatManager():QueueCommand(-1, '/alias delete /warpring');
    AshitaCore:GetChatManager():QueueCommand(-1, '/lockstyle off');
end

profile.HandleCommand = function(args)
    if (#args > 0) then
        if (args[1]:any('warpring')) then
            Settings.wrdelay = help.WarpRing();
            Settings.warpRing = true;
        end
    end
end

profile.HandleDefault = function()
    --Player Info
    local player = gData.GetPlayer();

    if (Settings.wrdelay <= os.time() and Settings.warpRing) then
        AshitaCore:GetChatManager():QueueCommand(-1, '/item \"Warp Ring\" <me>');
    end

    --State Engine
    local stateSet = sets.Idle;
    if (player.Status == 'Engaged') then
        stateSet = gFunc.Combine(stateSet, sets.TP);

    elseif (player.Status == 'Resting') then
        stateSet = gFunc.Combine(stateSet, sets.Resting);
    else
        if(player.MPP < 75)then
            stateSet = gFunc.Combine(stateSet, sets.Refresh);
        end
    end
    if (Settings.warpRing) then
        stateSet = gFunc.Combine(stateSet, { ['Ring1'] = 'Warp Ring' });
    end
    gFunc.EquipSet(stateSet);
    equippedSet = stateSet;

    help.CheckBlink(equippedSet, sets.Blink);
end

profile.HandleAbility = function()
    local act = gData.GetAction();

    --Init Set
    local abSet = sets.Idle;

    --ForceBlink
    help.ForceBlink(sets.Blink, abSet);

    --Waltz
    if (string.find(act.Name, 'Waltz')) then
        abSet = gFunc.Combine(abSet, sets.Waltz);
    end

    --Equip Final abSet
    gFunc.EquipSet(abSet);
end

profile.HandleItem = function()
    local act = gData.GetAction();
    if(act.Name == 'Warp Ring')then
        Settings.warpRing = false;
    end
end

profile.HandlePrecast = function()
    gFunc.EquipSet(sets.FastCast);
end

profile.HandleMidcast = function()
    --Get Action
    local act = gData.GetAction();
    local bluType = blu.GetBLU(act.Name);
    local chain = gData.GetBuffCount('Chain Affinity') > 0;

    if(bluType == 'Not Blue Magic')then
        return;
    end

    print (bluType)

    local spellSet = sets.Idle;
    if(bluType == 'Physical')then
        spellSet = gFunc.Combine(spellSet, sets.TP);
    elseif(bluType == 'Magical')then
        spellSet = gFunc.Combine(spellSet, sets.Nuke);
        spellSet = gFunc.Combine(spellSet, sets.MAB);
    elseif(bluType == 'Healing' and sets.CurePot ~= nil)then
        spellSet = gFunc.Combine(spellSet, sets.Cures);
        spellSet = gFunc.Combine(spellSet, sets.CurePot);
    elseif(bluType == 'Breath' and sets.Breath ~= nil)then
        spellSet = gFunc.Combine(spellSet, sets.Breath);
    elseif(bluType == 'Enfeebling' and sets.Enfeebling ~= nil)then
        spellSet = gFunc.Combine(spellSet, sets.Enfeebling);
    elseif(bluType == 'Enhancing' and sets.Enhancing ~= nil)then
        spellSet = gFunc.Combine(spellSet, sets.Enhancing);
    end

    local bluModSet, bluMods = blu.getMods(act.Name, sets);
    spellSet = gFunc.Combine(spellSet, bluModSet);

    local modstring = blu.SetModString(bluMods);
    if(modstring ~= '')then
        print(chat.message(act.Name .. ':  ') .. chat.header(modstring));
    end

    if(chain and bluType == 'Physical')then
        local gorget = blu.GetGorget(act.Name, const.Gorgets);
        if (gorget ~= nil)then
            spellSet.Neck = gorget;
        end
    end

    gFunc.EquipSet(spellSet);
end

profile.HandlePreshot = function()
end

profile.HandleMidshot = function()
end

profile.HandleWeaponskill = function()
    --Get the Weapon Skill:
    local act = gData.GetAction();
    --Get the WS Mods:
    local mods = mod.getMods(act.Name);
    --Compile the String to send to chat log
    local modstring = mod.SetModString(mods);
    --Pre-define WS Set
    local wsSet = sets.TP;

    --Construct and combine best set using WSCs
    wsSet = gFunc.Combine(wsSet, mod.getMods(act.Name, sets));

    --Print Mod string to chat log:
    print(chat.message(act.Name .. ':  ') .. chat.header(modstring));

    --Append MAB gear for Magical WSs:
    if (mod.IsMAB(act.Name)) then
        wsPrebuild = {}
        wsPrebuild.Element = mod.IsMAB(act.Name);
        wsSet = gFunc.Combine(wsSet, sets.MAB);
        if (help.GetObi(wsPrebuild, const.Obis)) then
            wsSet = gFunc.Combine(wsSet, { Waist = help.GetObi(wsPrebuild, const.Obis) });
        end
    end

    if (help.WsNeedsAcc(act.Name))then
        wsSet = gFunc.Combine(wsSet, sets.WSAcc);
    end

    --Gorget Determination
    local gorget = mod.getGorget(act.Name, const.Gorgets);
    if (gorget ~= nil) then
        wsSet.Neck = gorget;
    end

    --Equip Final WS set:
    gFunc.EquipSet(wsSet);
end

return profile;
