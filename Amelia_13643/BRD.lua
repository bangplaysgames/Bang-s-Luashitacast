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
        Main = 'Iridal Staff',
        Range = 'Mary\'s Horn',
        Head = 'Emperor Hairpin',
        Neck = 'Focus Collar',
        Ear1 = 'Drone Earring',
        Ear2 = 'Drone Earring',
        Body = 'Minstrel\'s Coat',
        Hands = { Name = 'Battle Gloves', Augment = { [1] = 'Potency of "Cure" effect received+1%', [2] = 'MP+3', [3] = 'HP+3', [4] = '"Store TP"+1', [5] = 'DEF+2' } },
        Ring1 = 'Echad Ring',
        Ring2 = 'Warp Ring',
        Back = { Name = 'Nomad\'s Mantle', Augment = { [1] = 'DEF+3', [2] = '"Dual Wield"+1' } },
        Waist = { Name = 'Leather Belt', Augment = 'HP+10' },
        Legs = 'Brass Subligar',
        Feet = 'Leaping Boots',
    },
    ['TP'] = {
    },
    ['Resting'] = {
    },
    ['STR'] = {},
    ['DEX'] = {},
    ['VIT'] = {},
    ['AGI'] = {},
    ['INT'] = {},
    ['MND'] = {},
    ['CHR'] = {
        Neck = 'Bird Whistle',
        Waist = 'Corsette',
    },
    ['FastCast'] = {
        Head = { Name = 'Entrancing Ribbon', Augment = { [1] = 'Pet: Rng. Acc.+2', [2] = '"Fast Cast"+1', [3] = 'Pet: Accuracy+2' } },
        Ear1 = 'Loquac. Earring',
        Feet = 'Rostrum Pumps',
    },
    ['lock'] = {
    },
    ['Blink'] = {
        ['Legs'] = 'Hume Pants',
    },
    ['Nuke'] = {
    },
    ['Singing'] = {
        Head = 'Demon Helm +1',
        Body = 'Minstrel\'s Coat',
    },
    ['Wind'] = {},
    ['String'] = {}
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
        stateSet = gFunc.Combine(stateSet, sets.TP);

    elseif (player.Status == 'Resting') then
        stateSet = gFunc.Combine(stateSet, sets.Resting);
    else
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

    --Jig
    if (string.find(act.Name, 'Jig')) then
        abSet = gFunc.Combine(abSet, sets.Jig);
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

    local actSet = sets.Idle;

    --Minuet
    if (string.find(act.Name, 'Minuet'))then
        actSet = gFunc.Combine(actSet, { Range = 'Cornette +1' });
    end

    --March
    if (string.find(act.Name, 'March'))then
        actSet = gFunc.Combine(actSet, { Range = 'Battle Horn +1' });
    end

    --Madrigal
    if (string.find(act.Name, 'Madrigal'))then
        actSet = gFunc.Combine(actSet, { Range = 'Traversiere +2'});
    end

    --CHR Gear
    if (string.find(act.Name, 'Lullaby') or
        string.find(act.Name, 'Elegy') or
        string.find(act.Name, 'Requiem'))then
        actSet = gFunc.Combine(actSet, sets.CHR)
    end

    if (string.find(act.Name, 'Lullaby') or string.find(act.Name, 'Ballad'))then
        actSet = gFunc.Combine(actSet, { Range = 'Terpander' })
    end

    --Combine Singing
    actSet = gFunc.Combine(actSet, sets.Singing);

    --Get Instrument And Equip appropriate skill gear
    local inst = actSet.Range;
    local skill = jHelp.GetInstrument(inst);
    actSet = gFunc.Combine(actSet, sets[skill]);

    gFunc.EquipSet(actSet);
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

    if (act.Name == 'Sidewinder' or act.Name == 'Namas Arrow') then
        wsSet = gFunc.Combine(wsSet, sets.Racc);
        wsSet = gFunc.Combine(wsSet, sets.BowWS);
    end

    --Gorget Determination
    local gorget = mod.getGorget(act.Name, const.Gorgets);
    if (gorget ~= nil) then
        wsSet.Neck = gorget;
    end

    if (act.Name == 'Sidewinder' or act.Name == 'Namas Arrow') then
    end
    --Equip Final WS set:
    gFunc.EquipSet(wsSet);
end

return profile;