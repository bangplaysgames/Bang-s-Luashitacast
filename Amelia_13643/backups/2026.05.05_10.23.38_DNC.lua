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
        Main = 'Bone Knife +1',
        Sub = 'Bone Knife +1',
        Range = 'War Hoop',
        Head = 'Emperor Hairpin',
        Neck = 'Focus Collar',
        Ear1 = 'Drone Earring',
        Ear2 = 'Drone Earring',
        Body = 'Velvet Robe',
        Hands = { Name = 'Battle Gloves', Augment = { [1] = 'Potency of "Cure" effect received+1%', [2] = 'MP+3', [3] = 'HP+3', [4] = '"Store TP"+1', [5] = 'DEF+2' } },
        Ring1 = { Name = 'Jaeger Ring', Augment = { [1] = 'AGI+3', [2] = '"Store TP"+1' } },
        Ring2 = 'Rajas Ring',
        Back = { Name = 'Nomad\'s Mantle', Augment = { [1] = 'DEF+3', [2] = '"Dual Wield"+1' } },
        Waist = { Name = 'Leather Belt', Augment = 'HP+10' },
        Legs = 'Dancer\'s Tights',
        Feet = 'Leaping Boots',
    },
    ['TP'] = {
        Main = 'Bone Knife +1',
        Sub = 'Bone Knife +1',
        Range = 'War Hoop',
        Head = 'Voyager Sallet',
        Neck = 'Focus Collar',
        Ear1 = 'Drone Earring',
        Ear2 = 'Drone Earring',
        Body = 'Velvet Robe',
        Hands = { Name = 'Battle Gloves', Augment = { [1] = 'Potency of "Cure" effect received+1%', [2] = 'MP+3', [3] = 'HP+3', [4] = '"Store TP"+1', [5] = 'DEF+2' } },
        Ring1 = { Name = 'Jaeger Ring', Augment = { [1] = 'AGI+3', [2] = '"Store TP"+1' } },
        Ring2 = 'Rajas Ring',
        Back = { Name = 'Nomad\'s Mantle', Augment = { [1] = 'DEF+3', [2] = '"Dual Wield"+1' } },
        Waist = 'Swift Belt',
        Legs = 'Dancer\'s Tights',
        Feet = 'Leaping Boots',
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
        ['Legs'] = 'Hume Pants',
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
        if(Settings.wrDelay >= os.time())then
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
    end
    if (Settings.warpRing) then
        stateSet = gFunc.Combine(stateSet, {['Ring1'] = 'Warp Ring'});
    end
    gFunc.EquipSet(stateSet);
    equippedSet = stateSet;

    help.CheckBlink(equippedSet, sets.Blink);
end

profile.HandleAbility = function()
    --Init Set
    local abSet = sets.Idle;

    --ForceBlink
    help.ForceBlink(sets.Blink, abSet);
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