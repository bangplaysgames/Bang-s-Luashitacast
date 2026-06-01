local profile = {};

local chat = require('chat');

local mod = gFunc.LoadFile('..\\lib\\modifierTables.lua');

local warpring = function()
    AshitaCore:GetChatManager():QueueCommand(-1, '/item "Warp Ring" <me>');
end

local jHelp = gFunc.LoadFile('..\\lib\\JobHelpers.lua');

local help = gFunc.LoadFile('..\\lib\\helpers.lua');

local sets = {
    ['TP'] = {
        Main = 'Dagger of Trials',
        Sub = 'Bone Knife +1',
        Range = 'Moonring Blade',
        Head = 'Voyager Sallet',
        Neck = 'Rabbit Charm',
        Ear1 = 'Coral Earring',
        Ear2 = 'Coral Earring',
        Body = 'Rapparee Harness',
        Hands = { Name = 'Battle Gloves', Augment = { [1] = 'Potency of "Cure" effect received+1%', [2] = 'MP+3', [3] = 'HP+3', [4] = '"Store TP"+1', [5] = 'DEF+2' } },
        Ring1 = 'Sniper\'s Ring +1',
        Ring2 = { Name = 'Jaeger Ring', Augment = { [1] = 'AGI+3', [2] = '"Store TP"+1' } },
        Back = { Name = 'Nomad\'s Mantle', Augment = { [1] = 'DEF+3', [2] = '"Dual Wield"+1' } },
        Waist = 'Swift Belt',
        Legs = 'Brass Subligar',
        Feet = 'Leaping Boots',
    },
    ['Idle'] = {
        Sub = 'Bone Knife +1',
        Head = 'Voyager Sallet',
        Neck = 'Rabbit Charm',
        Ear1 = 'Coral Earring',
        Ear2 = 'Coral Earring',
        Body = 'Rapparee Harness',
        Hands = 'Battle Gloves',
        Ring1 = 'Sniper\'s Ring +1',
        Ring2 = 'Jaeger Ring',
        Back = 'Accura Cape',
        Waist = 'Swift Belt',
        Legs = 'Brass Subligar',
        Feet = 'Leaping Boots',
    },
    ['SA'] = {},
    ['TA'] = {},
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
    itemuse = false,
    thWeapons = true
}

profile.OnLoad = function()
    gSettings.AllowAddSet = true;
    jHelp.ThotBar();
end

profile.OnUnload = function()
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
