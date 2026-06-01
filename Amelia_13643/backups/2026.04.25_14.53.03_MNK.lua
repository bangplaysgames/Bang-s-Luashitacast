local profile = {};

local chat = require('chat');

local mod = gFunc.LoadFile('..\\lib\\modifierTables.lua');

local warpring = function()
    AshitaCore:GetChatManager():QueueCommand(-1, '/item "Warp Ring" <me>');
end

local help = gFunc.LoadFile('..\\lib\\helpers.lua');

local sets = {
    ['Idle'] = {
        Main = 'Patas',
        Head = 'Emperor Hairpin',
        Neck = 'Focus Collar',
        Ear1 = 'Drone Earring',
        Ear2 = 'Drone Earring',
        Body = 'Shinobi Gi',
        Hands = 'Battle Gloves',
        Ring1 = 'Jaeger Ring',
        Ring2 = 'Sniper\'s Ring +1',
        Back = 'Accura Cape',
        Waist = 'Swift Belt',
        Legs = 'Shinobi Hakama',
        Feet = 'Sarutobi Kyahan',
    },
    ['TP'] = {
        Main = 'Patas',
        Head = 'Voyager Sallet',
        Neck = 'Focus Collar',
        Ear1 = 'Drone Earring',
        Ear2 = 'Drone Earring',
        Body = 'Shinobi Gi',
        Hands = 'Battle Gloves',
        Ring1 = 'Jaeger Ring',
        Ring2 = 'Sniper\'s Ring +1',
        Back = 'Accura Cape',
        Waist = 'Swift Belt',
        Legs = 'Shinobi Hakama',
        Feet = 'Sarutobi Kyahan',
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
    itemuse = false,
}

profile.OnLoad = function()
    gSettings.AllowAddSet = true;
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
end

profile.HandleMidcast = function()
end

profile.HandlePreshot = function()
end

profile.HandleMidshot = function()
end

profile.HandleWeaponskill = function()
end

return profile;