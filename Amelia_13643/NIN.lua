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
        Main = 'Kororito +1',
        Sub = 'Kororito +1',
        Range = 'Moonring Blade',
        Head = 'Emperor Hairpin',
        Neck = 'Focus Collar',
        Ear1 = 'Raising Earring',
        Ear2 = 'Bone Earring',
        Body = 'Shinobi Gi',
        Hands = 'Alumine Moufles',
        Ring1 = 'Sniper\'s Ring +1',
        Ring2 = 'Rajas Ring',
        Back = { Name = 'Nomad\'s Mantle', Augment = { [1] = 'DEF+3', [2] = '"Dual Wield"+1' } },
        Waist = 'Swift Belt',
        Legs = { Name = 'Jujitsu Sitabaki', Augment = { [1] = 'STR+2', [2] = 'HP+10', [3] = '"Store TP"+1', [4] = 'DEX+2' } },
        Feet = 'Sarutobi Kyahan',
    },
    ['TP'] = {
        Range = 'Moonring Blade',
        Head = 'Voyager Sallet',
        Neck = 'Focus Collar',
        Ear1 = 'Coral Earring',
        Ear2 = 'Coral Earring',
        Body = 'Haubergeon',
        Hands = 'Shinobi Tekko',
        Ring1 = 'Sniper\'s Ring +1',
        Ring2 = 'Rajas Ring',
        Back = { Name = 'Nomad\'s Mantle', Augment = { [1] = 'DEF+3', [2] = '"Dual Wield"+1' } },
        Waist = 'Swift Belt',
        Legs = { Name = 'Jujitsu Sitabaki', Augment = { [1] = 'STR+2', [2] = 'HP+10', [3] = '"Store TP"+1', [4] = 'DEX+2' } },
        Feet = 'Sarutobi Kyahan',
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
    ['MAB'] = {},
    ['FastCast'] = {},
    ['lock'] = {
        Head = 'Voyager Sallet',
        Body = 'Alumine Haubert',
        Hands = 'Shinobi Tekko',
        Legs = 'Alumine Brayettes',
        Feet = 'Sarutobi Kyahan',
    },
    ['Nuke'] = {
        Range = 'Moonring Blade',
        Ear1 = 'Moldavite Earring',
        Ear2 = 'Bone Earring',
        Body = 'Shinobi Gi',
        Hands = 'Alumine Moufles',
        Ring1 = 'Eremite\'s Ring +1',
        Ring2 = 'Eremite\'s Ring +1',
        Back = { Name = 'Nomad\'s Mantle', Augment = { [1] = 'DEF+3', [2] = '"Dual Wield"+1' } },
        Waist = 'Ryl.Kgt. Belt',
        Legs = { Name = 'Jujitsu Sitabaki', Augment = { [1] = 'STR+2', [2] = 'HP+10', [3] = '"Store TP"+1', [4] = 'DEX+2' } },
        Feet = 'Sarutobi Kyahan',
    },
    ['Refresh'] = {}
};
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
    if(#args > 0)then
        if(args[1]:any('warpring'))then
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
        if(player.MPP < 75)then
            stateSet = gFunc.Combine(stateSet, sets.Refresh);
        end
        if(player.IsMoving)then
            stateSet = gFunc.Combine(stateSet, { Legs = 'Blood Cuisses' });
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
    local act = gData.GetAction();
    local actSet = sets.Idle;
    if(jHelp.IsNINNuke)then
        actSet = gFunc.Combine(actSet, sets.Nuke);
    end
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
    if(mods ~= nil)then
        for i=1,#mods do
            local mod = mods[i].stat;
            wsSet = gFunc.Combine(wsSet, sets[mod]);
        end
    end

    --Print Mod string to chat log:
    print(chat.message(act.Name .. ':  ') .. chat.header(modstring));

    --Append MAB gear for Aeolian Edge:
    if(mod.IsMAB(act.Name))then
        wsPrebuild = {}
        wsPrebuild.Element = mod.IsMAB(act.Name);
        wsSet = gFunc.Combine(wsSet, sets.MAB);
        if(help.GetObi(wsPrebuild, const.Obis))then
            wsSet = gFunc.Combine(wsSet, {Waist = help.GetObi(wsPrebuild, const.Obis)});
        end
    end

    if(act.Name == 'Sidewinder' or act.Name == 'Namas Arrow')then
        wsSet = gFunc.Combine(wsSet, sets.Racc);
        wsSet = gFunc.Combine(wsSet, sets.BowWS);
    end

    --Gorget Determination
    local gorget = mod.getGorget(act.Name, const.Gorgets);
    if(gorget ~= nil)then
        wsSet.Neck = gorget;
    end

    if(act.Name == 'Sidewinder' or act.Name == 'Namas Arrow')then
    end
    --Equip Final WS set:
    gFunc.EquipSet(wsSet);
end

return profile;