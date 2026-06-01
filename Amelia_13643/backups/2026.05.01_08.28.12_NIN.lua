local profile = {};

local chat = require('chat');

local mod = gFunc.LoadFile('..\\lib\\modifierTables.lua');

local warpring = function()
    AshitaCore:GetChatManager():QueueCommand(-1, '/item "Warp Ring" <me>');
end

local jHelp = gFunc.LoadFile('..\\lib\\JobHelpers.lua');

local help = gFunc.LoadFile('..\\lib\\helpers.lua');

local sets = {
    ['Idle'] = {
        Main = 'Yoto +1',
        Sub = 'Yoto',
        Head = 'Voyager Sallet',
        Neck = 'Focus Collar',
        Ear1 = 'Raising Earring',
        Ear2 = 'Bone Earring',
        Body = 'Alumine Haubert',
        Hands = 'Alumine Moufles',
        Ring1 = 'Sniper\'s Ring +1',
        Ring2 = 'Warp Ring',
        Back = { Name = 'Nomad\'s Mantle', Augment = { [1] = 'DEF+3', [2] = '"Dual Wield"+1' } },
        Waist = { Name = 'Leather Belt', Augment = 'HP+10' },
        Legs = { Name = 'Jujitsu Sitabaki', Augment = { [1] = 'STR+2', [2] = 'HP+10', [3] = '"Store TP"+1', [4] = 'DEX+2' } },
        Feet = 'Sarutobi Kyahan',
    },
    ['TP'] = {
        Main = 'Yoto +1',
        Sub = 'Yoto',
        Head = 'Voyager Sallet',
        Neck = 'Focus Collar',
        Ear1 = 'Raising Earring',
        Ear2 = 'Bone Earring',
        Body = 'Shinobi Gi',
        Hands = 'Shinobi Tekko',
        Ring1 = 'Sniper\'s Ring +1',
        Ring2 = 'Warp Ring',
        Back = { Name = 'Nomad\'s Mantle', Augment = { [1] = 'DEF+3', [2] = '"Dual Wield"+1' } },
        Waist = { Name = 'Leather Belt', Augment = 'HP+10' },
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
    ['FastCast'] = {}
};
profile.Sets = sets;

profile.Packer = {
};

local Settings = {
    CurrentLevel = 0,
    CurrentSub = '',
    TP_Mode = 'Haste',
    wrdelay = 0,
    itemuse = false,
}

profile.OnLoad = function()
    gSettings.AllowAddSet = true;
    jHelp.ThotBar();
end

profile.OnUnload = function()
end

profile.HandleCommand = function(args)
end

profile.HandleDefault = function()
    --Player Info
    local player = gData.GetPlayer();

    if(Settings.itemuse == false)then
        if(Settings.wrdelay ~= 0)then
            gFunc.Equip('ring1', 'Warp Ring');
        end
        if(Settings.wrdelay <= os.time())then
            if(Settings.itemuse == false)then
                Settings.itemuse = true;
                warpring();
            end
        end
        return;
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
        if(helpers.GetObi(wsPrebuild, const.Obis))then
            wsSet = gFunc.Combine(wsSet, {Waist = helpers.GetObi(wsPrebuild, const.Obis)});
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