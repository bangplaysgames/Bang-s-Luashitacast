local profile = {};

local chat = require('chat');

local mod = gFunc.LoadFile('..\\lib\\modifierTables.lua');

local warpring = function()
    AshitaCore:GetChatManager():QueueCommand(-1, '/item "Warp Ring" <me>');
end

local jHelp = gFunc.LoadFile('..\\lib\\JobHelpers.lua');

local help = gFunc.LoadFile('..\\lib\\helpers.lua');

local const = gFunc.LoadFile('constants.lua');

local sets = {
    ['TP'] = {
        Main = 'X\'s Knife',
        Sub = 'Thief\'s Knife',
        Range = 'Moonring Blade',
        Head = 'Walahra Turban',
        Neck = 'Focus Collar',
        Ear1 = 'Brutal Earring',
        Ear2 = 'Coral Earring',
        Body = 'Rapparee Harness',
        Hands = { Name = 'Battle Gloves', Augment = { [1] = 'Potency of "Cure" effect received+1%', [2] = 'MP+3', [3] = 'HP+3', [4] = '"Store TP"+1', [5] = 'DEF+2' } },
        Ring1 = 'Rajas Ring',
        Ring2 = { Name = 'Jaeger Ring', Augment = { [1] = 'AGI+3', [2] = '"Store TP"+1' } },
        Back = { Name = 'Nomad\'s Mantle', Augment = { [1] = 'DEF+3', [2] = '"Dual Wield"+1' } },
        Waist = 'Swift Belt',
        Legs = { Name = 'Coeurl Trousers', Augment = 'Attack+6' },
        Feet = 'Leaping Boots',
    },
    ['Idle'] = {
        Main = 'X\'s Knife',
        Sub = 'Thief\'s Knife',
        Range = 'Moonring Blade',
        Head = 'Emperor Hairpin',
        Neck = 'Focus Collar',
        Ear1 = 'Brutal Earring',
        Ear2 = 'Coral Earring',
        Body = 'Rapparee Harness',
        Hands = { Name = 'Battle Gloves', Augment = { [1] = 'Potency of "Cure" effect received+1%', [2] = 'MP+3', [3] = 'HP+3', [4] = '"Store TP"+1', [5] = 'DEF+2' } },
        Ring1 = 'Sniper\'s Ring +1',
        Ring2 = { Name = 'Jaeger Ring', Augment = { [1] = 'AGI+3', [2] = '"Store TP"+1' } },
        Back = 'Accura Cape',
        Waist = 'Swift Belt',
        Legs = 'Brass Subligar',
        Feet = 'Leaping Boots',
    },
    ['STR'] = {
        Head = { Name = 'Voyager Sallet', Mods = { STR = 3, DEX = 4 } },
        Neck = { Name = 'Harmonia\'s Torque', Mods = { STR = 2, VIT = -5 } },
        Body = { Name = 'Rogue\'s Vest', Mods = { STR = 3 } },
        Ring1 = { Name = 'Rajas Ring', Mods = { STR = 5, DEX = 5 } },
        Ring2 = { Name = 'Flame Ring', Mods = { STR = 5, INT = 2, MND = -2 } },
        Back = { Name = 'Amemet Mantle', Mods = { STR = 1 } },
        Waist = { Name = 'Ryl.Kgt. Belt', Mods = { STR = 2, DEX = 2, AGI = 2, INT = 2, MND = 2, CHR = 2 } },
    },
    ['DEX'] = {
        Head = 'Voyager Sallet',
        Ring1 = 'Rajas Ring',
        Back = 'Assassin\'s Cape',
        Waist = 'Ryl.Kgt. Belt',
        Feet = 'Hct. Leggings +1',
    },
    ['VIT'] = {},
    ['AGI'] = {
        Head = { Name = 'Emperor Hairpin', Mods = { DEX = 3, AGI = 3 } },
        Ear1 = { Name = 'Drone Earring', Mods = { AGI = 3 } },
        Ear2 = { Name = 'Drone Earring', Mods = { AGI = 3 } },
        Ring2 = { Name = 'Jaeger Ring', Mods = { AGI = 3 }, Augment = { [1] = 'AGI+3', [2] = '"Store TP"+1' } },
        Waist = { Name = 'Ryl.Kgt. Belt', Mods = { STR = 2, DEX = 2, AGI = 2, INT = 2, MND = 2, CHR = 2 } },
        Feet = { Name = 'Leaping Boots', Mods = { DEX = 3, AGI = 3 } },
    },
    ['INT'] = {},
    ['MND'] = {},
    ['CHR'] = {},
    ['SA'] = {
        Head = 'Voyager Sallet',
        Ring1 = 'Rajas Ring',
        Back = 'Assassin\'s Cape',
        Waist = 'Ryl.Kgt. Belt',
        Feet = 'Leaping Boots',
    },
    ['TA'] = {
        Head = 'Emperor Hairpin',
        Back = 'Assassin\'s Cape',
        Waist = 'Ryl.Kgt. Belt',
        Feet = 'Leaping Boots',
    },
    ['Resting'] = {},
    ['TH'] = {
        Head = 'Wh. Rarab Cap +1',
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
    itemuse = false,
    thWeapons = true
}

profile.OnLoad = function()
    gSettings.AllowAddSet = true;
    jHelp.ThotBar();
    AshitaCore:GetChatManager():QueueCommand(-1, '/alias /warpring /lac fwd warpring');
    Settings.wrdelay = os.time() + 25;
    Settings.warpRing = false;
end

profile.OnUnload = function()
    AshitaCore:GetChatManager():QueueCommand(-1, '/alias delete /warpring');
end

local IsTHApplied = function(target)
    if (target ~= nil)then
        if help.thTable[target] == nil then
            help.thTable[target] = {}
        end
    end
    if(help.thTable[target] ~= nil)then
        local THState = help.thTable[target].THApplied;
        return THState;
    end
    return false;
end

profile.HandleCommand = function(args)
    if (#args > 0) then
        if (args[1]:any('warpring')) then
            local wrDelay = help.WarpRing();
            if (wrDelay ~= nil) then
                Settings.wrdelay = wrDelay;
                Settings.warpRing = true;
            end
        end
    end
end

profile.HandleDefault = function()
    --Player Info
    local player = gData.GetPlayer();

    if (Settings.warpRing and Settings.wrdelay <= os.time()) then
        local result = help.WarpRingUse();
        if (result == nil or result == 0) then
            Settings.warpRing = false;
        else
            Settings.wrdelay = result;
        end
    end

    --State Engine
    local stateSet = sets.Idle;
    if (player.Status == 'Engaged') then
        local target = gData.GetTarget();
        local targetId;
        if(target ~= nil)then
            targetId = target.Id;
        end

        if(gData.GetBuffCount('Sneak Attack') > 0)then
            stateSet = gFunc.Combine(stateSet, sets.SA);
        elseif(gData.GetBuffCount('Trick Attack') > 0)then
            stateSet = gFunc.Combine(stateSet, sets.TA);
        else
            stateSet = gFunc.Combine(stateSet, sets.TP);
        end

        --If TH hasn't been applied,  Equip TH set
        if (targetId ~= nil and not IsTHApplied(targetId)) then
            stateSet = gFunc.Combine(stateSet, sets.TH)
        end

    elseif (player.Status == 'Resting') then
        stateSet = gFunc.Combine(stateSet, sets.Resting);
    else
        if(player.IsMoving)then
            stateSet = gFunc.Combine(stateSet, { Feet = 'Trotter Boots' })
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