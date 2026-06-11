local JobHelpers = {}

JobHelpers.SmnSkill = T{'Shining Ruby','Glittering Ruby','Crimson Howl','Inferno Howl','Frost Armor','Crystal Blessing','Aerial Armor','Hastega II','Fleet Wind','Hastega','Earthen Ward','Earthen Armor','Rolling Thunder','Lightning Armor','Soothing Current','Ecliptic Growl','Heavenward Howl','Ecliptic Howl','Noctoshield','Dream Shroud','Altana\'s Favor','Reraise','Reraise II','Reraise III','Raise','Raise II','Raise III','Wind\'s Blessing'};

JobHelpers.enmityActions = T{ 'Animated Flourish', 'Sentinel', 'Reprisal', 'Enlight', 'Rampart', 'Shield Bash', 'Provoke', 'Cure', 'Cure II', 'Cure III', 'Cure IV', 'Magic Fruit', 'Curing Waltz', 'Curing Waltz II', 'Curing Waltz III', 'Curing Waltz IV', 'Atonement', }

JobHelpers.GetInstrument = function(ranged)
    local instruments = {
        ['Flute'] = 'Wind',
        ['Flute +1'] = 'Wind',
        ['Flute +2'] = 'Wind',
        ['Cornette'] = 'Wind',
        ['Cornette +1'] = 'Wind',
        ['Cornette +2'] = 'Wind',
        ['Piccolo'] = 'Wind',
        ['Piccolo +1'] = 'Wind',
        ['Mary\'s Horn'] = 'Wind',
        ['Gemshorn'] = 'Wind',
        ['Gemshorn +1'] = 'Wind',
        ['Royal Spearman\'s Horn'] = 'Wind',
        ['Siren Flute'] = 'Wind',
        ['Kingdom Horn'] = 'Wind',
        ['San d\'Orian Horn'] = 'Wind',
        ['Traversiere'] = 'Wind',
        ['Traversiere +1'] = 'Wind',
        ['Traversiere +2'] = 'Wind',
        ['Faerie Piccolo'] = 'Wind',
        ['Horn'] = 'Wind',
        ['Horn +1'] = 'Wind',
        ['Oliphant'] = 'Wind',
        ['Angel\'s Flute'] = 'Wind',
        ['Angel Flute +1'] = 'Wind',
        ['Storm Fife'] = 'Wind',
        ['Crumhorn'] = 'Wind',
        ['Crumhorn +1'] = 'Wind',
        ['Crumhorn +2'] = 'Wind',
        ['Hamelin Flute'] = 'Wind',
        ['Iron Ram Horn'] = 'Wind',
        ['Frenzy Fife'] = 'Wind',
        ['Hellish Bugle'] = 'Wind',
        ['Hellish Bugle +1'] = 'Wind',
        ['Shofar'] = 'Wind',
        ['Shofar +1'] = 'Wind',
        ['Harlequin\'s Horn'] = 'Wind',
        ['Cradle Horn'] = 'Wind',
        ['Requiem Flute'] = 'Wind',
        ['Relic Horn'] = 'Wind',
        ['Pyrrhic Horn'] = 'Wind',
        ['Dynamis Horn'] = 'Wind',
        ['Millenium Horn'] = 'Wind',
        ['Gjallarhorn'] = 'Wind',
        ['Ney'] = 'Wind',
        ['Cantabank\'s Horn'] = 'Wind',
        ['Apollo\'s Flute'] = 'Wind',
        ['Syrinx'] = 'Wind',
        ['Pan\'s Horn'] = 'Wind',
        ['Maple Harp'] = 'String',
        ['Maple Harp +1'] = 'String',
        ['Harp'] = 'String',
        ['Harp +1'] = 'String',
        ['Military Harp'] = 'String',
        ['Rose Harp'] = 'String',
        ['Rose Harp +1'] = 'String',
        ['Lamia Harp'] = 'String',
        ['Ebony Harp'] = 'String',
        ['Ebony Harp +1'] = 'String',
        ['Ebony Harp +2'] = 'String',
        ['Nursemaid\'s Harp'] = 'String',
        ['Mythic Harp'] = 'String',
        ['Mythic Harp +1'] = 'String',
        ['Sorrowful Harp'] = 'String',
        ['Angel Lyre'] = 'String',
        ['Cythara Anglica'] = 'String',
        ['Cythara Anglica +1'] = 'String',
        ['Vihuela'] = 'String',
        ['Crooner\'s Cithara'] = 'String',
        ['Pyf Harp'] = 'String',
        ['Daurdabla'] = 'String',
        ['Oneiros Harp'] = 'String',
        ['Langeleik'] = 'String',
        ['Terpander'] = 'String',
        ['Battle Horn +1'] = 'Wind',
    }
    return instruments[ranged];
end

JobHelpers.IsNINNuke = function(spell)
    local name = spell.Name;
    if (string.find(name, 'Katon') or
            string.find(name, 'Suiton') or
            string.find(name, 'Raiton') or
            string.find(name, 'Doton') or
            string.find(name, 'Huton') or
            string.find(name, 'Hyoton')) then
        return true;
    end
end

JobHelpers.ThotBar = function()
    local player = gData.GetPlayer();
    AshitaCore:GetChatManager():QueueCommand(-1, '/tb palette change ' .. player.MainJob .. '/' .. player.SubJob)
end

return JobHelpers;