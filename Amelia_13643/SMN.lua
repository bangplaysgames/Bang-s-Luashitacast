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
        Sub = 'Tenax Strap',
        Head = 'Summoner\'s Horn',
        Neck = 'Aesir Torque',
        Ear1 = 'Coral Earring',
        Ear2 = 'Loquac. Earring',
        Body = 'Minstrel\'s Coat',
        Hands = 'Summoner\'s Brcr.',
        Ring1 = 'Evoker\'s Ring',
        Ring2 = 'Warp Ring',
        Back = 'Rainbow Cape',
        Waist = 'Swift Belt',
        Legs = 'Summoner\'s Spats',
        Feet = 'Nashira Crackows',
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
    ['FastCast'] = {
        Head = 'Enchanting Ribbon',
    },
    ['lock'] = {
    },
    ['Blink'] = {
        ['Legs'] = 'Hume Pants',
    },
    ['Nuke'] = {
    },
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
end

profile.HandlePreshot = function()
end

profile.HandleMidshot = function()
end

profile.HandleWeaponskill = function()
    --Get the Weapon Skill:
    local act = gData.GetAction();
    --Compile the String to send to chat log
    local modstring = mod.SetModString(mods);
    --Pre-define WS Set
    local wsSet = sets.TP;
    --Construct and combine best set using WSCs
    wsSet = gFunc.Combine(wsSet, mod.getMods(act.Name, sets))

    --Print Mod string to chat log:
    print(chat.message(act.Name .. ':  ') .. chat.header(modstring));

    --Append MAB gear for Magical WSs:
    if (mod.IsMAB(act.Name)) then
        wsPrebuild = {}
        wsPrebuild.Element = mod.IsMAB(act.Name);
        wsSet = gFunc.Combine(wsSet, sets.MAB);
        if (help.GetObi(wsPrebuild, help.const.Obis)) then
            wsSet = gFunc.Combine(wsSet, { Waist = help.GetObi(wsPrebuild, help.const.Obis) });
        end
    end

    if (help.WsNeedsAcc(act.Name))then
        wsSet = gFunc.Combine(wsSet, sets.WSAcc);
    end

    --Gorget Determination
    local gorget = mod.getGorget(act.Name, help.const.Gorgets);
    if (gorget ~= nil) then
        wsSet.Neck = gorget;
    end

    --Equip Final WS set:
    gFunc.EquipSet(wsSet);
end

return profile;