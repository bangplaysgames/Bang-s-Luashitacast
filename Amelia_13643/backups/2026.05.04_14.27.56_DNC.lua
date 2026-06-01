local profile = {};

local chat = require('chat');

local mod = gFunc.LoadFile('..\\lib\\modifierTables.lua');

local const = gFunc.LoadFile('constants.lua');

local warpring = function()
    AshitaCore:GetChatManager():QueueCommand(-1, '/item "Warp Ring" <me>');
end

local jHelp = gFunc.LoadFile('..\\lib\\JobHelpers.lua');

local help = gFunc.LoadFile('..\\lib\\helpers.lua');

local equippedSet = {}

local sets = {
    ['Idle'] = {
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
    ['CHR'] = {},
    ['FastCast'] = {},
    ['lock'] = {
    },
    ['Blink'] = {
        ['Head'] = 'Sprout Beret',
    }
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
            Settings.wrdelay = helpers.WarpRing();
            Settings.warpRing = true;
        end
    end
end

profile.HandleDefault = function()
    --Player Info
    local player = gData.GetPlayer();

    if (Settings.wrdelay <= os.time() and Settings.warpRing) then
        AshitaCore:GetChatManager():QueueCommand(-1, '/item \'Warp Ring\' <me>');
        Settings.warpRing = false;
    end

    --State Engine
    local stateSet = sets.Idle;
    if (player.Status == 'Engaged') then
        stateSet = gFunc.Combine(stateSet, sets.TP);

    elseif (player.Status == 'Resting') then
        stateSet = gFunc.Combine(stateSet, sets.Resting);
    else
    end
    gFunc.EquipSet(stateSet);
    equippedSet = stateSet;
    if (Settings.warpRing) then
        gFunc.Equip('ring1', 'WarpRing');
    end
    help.CheckBlink(equippedSet, sets.Blink);
end

profile.HandleAbility = function()
    --Init Set
    local abSet = sets.Idle;

    --ForceBlink
    help.ForceBlink(equippedSet, abSet);
end

profile.HandleItem = function()
end

profile.HandlePrecast = function()
    gFunc.EquipSet(sets.FastCast);
end

profile.HandleMidcast = function()
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
        if (helpers.GetObi(wsPrebuild, const.Obis)) then
            wsSet = gFunc.Combine(wsSet, { Waist = helpers.GetObi(wsPrebuild, const.Obis) });
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