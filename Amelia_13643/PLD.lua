local profile = {};

local chat = require('chat');

local mod = gFunc.LoadFile('..\\lib\\modifierTables.lua');

local const = gFunc.LoadFile('constants.lua');

local warpring = function()
    AshitaCore:GetChatManager():QueueCommand(-1, '/item "Warp Ring" <me>');
end

local jHelp = gFunc.LoadFile('..\\lib\\JobHelpers.lua');

local help = gFunc.LoadFile('..\\lib\\helpers.lua');

local sets = {
    ['Idle'] = {
        Main = 'Xiutleato',
        Sub = 'Aegis',
        Head = 'Homam Zucchetto',
        Neck = 'Fortitude Torque',
        Ear1 = 'Coral Earring',
        Ear2 = 'Coral Earring',
        Body = 'Haubergeon',
        Hands = 'Gallant Gauntlets',
        Ring1 = 'Sniper\'s Ring +1',
        Ring2 = 'Rajas Ring',
        Back = 'Amemet Mantle',
        Waist = 'Swift Belt',
        Legs = 'Gallant Breeches',
        Feet = 'Gallant Leggings',
    },
    ['TP'] = {
        Main = 'Xiutleato',
        Sub = 'Aegis',
        Head = 'Homam Zucchetto',
        Neck = 'Fortitude Torque',
        Ear1 = 'Brutal Earring',
        Ear2 = 'Coral Earring',
        Body = 'Haubergeon',
        Hands = 'Gallant Gauntlets',
        Ring1 = 'Sniper\'s Ring +1',
        Ring2 = 'Warp Ring',
        Back = 'Amemet Mantle',
        Waist = 'Swift Belt',
        Legs = 'Gallant Breeches',
        Feet = 'Gallant Leggings',
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
    ['FastCast'] = {
        ['Head'] = 'Entrancing Ribbon',
    }
,
    ['lock'] = {
    } };
profile.Sets = sets;

profile.Packer = {
};

local Settings = {
    CurrentLevel = 0,
    CurrentSub = '',
    TP_Mode = 'Haste',
    wrdelay = 0,
    warpRing = false
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
    if (Settings.warpRing) then
        gFunc.Equip('ring1', 'WarpRing');
    end
end

profile.HandleAbility = function()
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
        if (help.GetObi(wsPrebuild, const.Obis)) then
            wsSet = gFunc.Combine(wsSet, { Waist = help.GetObi(wsPrebuild, const.Obis) });
        end
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
