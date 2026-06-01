local profile = {};

local chat = require('chat');

local mod = gFunc.LoadFile('..\\lib\\modifierTables.lua');

local warpring = function()
    AshitaCore:GetChatManager():QueueCommand(-1, '/item "Warp Ring" <me>');
end

local const = gFunc.LoadFile('constants.lua');

local jHelp = gFunc.LoadFile('..\\lib\\JobHelpers.lua');

local help = gFunc.LoadFile('..\\lib\\helpers.lua');

local sets = {
    ['Idle'] = {
        Main = 'Xiutleato',
        Sub = 'Coral Sword',
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
        Main = 'Xiutleato',
        Sub = 'Coral Sword',
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
        Head = 'Voyager Sallet',
        Neck = 'Harmonia\'s Torque',
        Ear1 = 'Brutal Earring',
        Body = 'Magus Jubbah',
        Ring1 = 'Flame Ring',
        Ring2 = 'Rajas Ring',
        Back = 'Amemet Mantle',
        Waist = 'Ryl.Kgt. Belt',
    },
    ['DEX'] = {
        Head = 'Voyager Sallet',
        Body = 'Magus Jubbah',
        Ring2 = 'Rajas Ring',
        Waist = 'Ryl.Kgt. Belt',
        Legs = { Name = 'Magus Shalwar +1', Augment = { [1] = '"Regen"+3', [2] = '"Refresh"+1' } },
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
};
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
        Settings.wrDelay = os.time() + 1;
        if (Settings.wrDelay >= os.time()) then
            Settings.warpRing = false;
        end
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
end

profile.HandlePrecast = function()
    gFunc.EquipSet(sets.FastCast);
end

profile.HandleMidcast = function()
    --Get Action
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

    --Iterate through mods table to construct the best set for the WS based on the mods:
    if (mods ~= nil) then
        for i = 1, #mods do
            local mod = mods[i].stat;
            wsSet = gFunc.Combine(wsSet, sets[mod]);
        end
    end

    --Print Mod string to chat log:
    print(chat.message(act.Name .. ':  ') .. chat.header(modstring));

    --Append MAB gear for Aeolian Edge:
    if (mod.IsMAB(act.Name)) then
        wsPrebuild = {}
        wsPrebuild.Element = mod.IsMAB(act.Name);
        wsSet = gFunc.Combine(wsSet, sets.MAB);
        if (help.GetObi(wsPrebuild, const.Obis)) then
            wsSet = gFunc.Combine(wsSet, { Waist = help.GetObi(wsPrebuild, const.Obis) });
        end
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