local profile = {};
local sets = {
    ['Idle'] = {
        Main = 'Bronze Zaghnal',
        Ammo = 'Herbal Broth',
        Head = 'Destrier Beret',
        Neck = 'Focus Collar',
        Ear1 = 'Bone Earring',
        Ear2 = 'Raising Earring',
        Body = 'Chocobo Shirt',
        Hands = 'Battle Gloves',
        Ring1 = 'Echad Ring',
        Ring2 = 'Warp Ring',
        Back = 'Shaper\'s Shawl',
        Legs = 'Brass Subligar',
        Feet = 'Leaping Boots',
    },
};
profile.Sets = sets;

profile.Packer = {
};

profile.OnLoad = function()
    gSettings.AllowAddSet = true;
end

profile.OnUnload = function()
end

profile.HandleCommand = function(args)
end

profile.HandleDefault = function()
    gFunc.EquipSet(sets.Idle);
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