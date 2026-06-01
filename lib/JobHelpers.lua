local JobHelpers = {}

JobHelpers.SmnSkill = T{'Shining Ruby','Glittering Ruby','Crimson Howl','Inferno Howl','Frost Armor','Crystal Blessing','Aerial Armor','Hastega II','Fleet Wind','Hastega','Earthen Ward','Earthen Armor','Rolling Thunder','Lightning Armor','Soothing Current','Ecliptic Growl','Heavenward Howl','Ecliptic Howl','Noctoshield','Dream Shroud','Altana\'s Favor','Reraise','Reraise II','Reraise III','Raise','Raise II','Raise III','Wind\'s Blessing'};

JobHelpers.enmityActions = T{ 'Animated Flourish', 'Sentinel', 'Reprisal', 'Enlight', 'Rampart', 'Shield Bash', 'Provoke', 'Cure', 'Cure II', 'Cure III', 'Cure IV', 'Magic Fruit', 'Curing Waltz', 'Curing Waltz II', 'Curing Waltz III', 'Curing Waltz IV', 'Atonement', }

JobHelpers.GetSets = function(priority)
    local subOverrides;
    local mainOverrides;

    local player = gData.GetPlayer();
    local path = string.format('%sconfig\\addons\\luashitacast\\%s_%u\\SubSets\\', AshitaCore:GetInstallPath(), gState.PlayerName, gState.PlayerId);
    if(not ashita.fs.exists(path .. player.MainJob .. '.lua'))then
        JobHelpers.CreateSetFile(player.MainJob);
    end
    if(not ashita.fs.exists(path .. player.SubJob .. '.lua'))then
        JobHelpers.CreateSetFile(player.SubJob);
    end

    if(priority == 'main')then
        mainsets = gFunc.LoadFile('SubSets\\'.. player.SubJob .. '.lua');
        subsets = gFunc.LoadFile('SubSets\\'.. player.MainJob .. '.lua');
    else
        subsets = gFunc.LoadFile('SubSets\\' .. player.SubJob .. '.lua');
        mainsets = gFunc.LoadFile('SubSets\\' .. player.MainJob .. '.lua');
    end

    local sets = {}

    if(mainsets ~= nil)then
        for k,v in pairs(mainsets)do
            --Bypass Overrides
            if(k == 'Override')then
                mainOverrides = v;
            else
                --Declare the set name
                if(sets[k] == nil)then
                    sets[k] = {}
                end
                --Define sets from main job.  This is to accommodate any sets that the main job may have defined that are not shared.
                sets[k] = v;
            end
        end
    end
    if(subsets ~= nil)then
        for k,v in pairs(subsets) do
            --Bypass Overrides
            if(k ~= 'Override')then
                --Check if the Main Job has a predefined set.  If so, it will combine the main job's set with the subjob's set.
                if(mainsets[k] ~= nil)then
                    sets[k] = gFunc.Combine(mainsets[k], v);
                else
                    if(sets[k] == nil)then
                        sets[k] = {}
                    end
                    --If no main job set, then it takes the subjob set.
                    sets[k] = v;
                end
            else
                subOverrides = v;
            end
        end
    end

    --Adjust for Main Job Overrides
    if(mainOverrides ~= nil)then
        for k,v in pairs(mainOverrides)do
            sets[k] = gFunc.Combine(sets[k], v);
        end
    end

    --Adjust for Sub Job Overrides
    if(subOverrides ~= nil)then
        for k,v in pairs(subOverrides)do
            sets[k] = gFunc.Combine(sets[k], v);
        end
    end
    JobHelpers.GenerateAllJobs();
    return sets;
end

JobHelpers.CreateSetFile = function(job)
    local path = string.format('%sconfig\\addons\\luashitacast\\%s_%u\\SubSets\\%s.lua', AshitaCore:GetInstallPath(), gState.PlayerName, gState.PlayerId, job);
    local file = io.open(path, 'w');
    if (file == nil) then
        gFunc.Error('Failed to access file: ' .. path .. '. Likely insufficient Permissions.');
        return false;
    end
    file:write('local sub = {}\n');
    file:write('\n');
    file:write('sub.TP = {}\n');
    file:write('\n');
    file:write('sub.Idle = {}\n');
    file:write('\n');
    file:write('sub.FC = {}\n');
    file:write('\n');
    file:write('sub.STR = {}\n');
    file:write('\n');
    file:write('sub.DEX = {}\n');
    file:write('\n');
    file:write('sub.VIT = {}\n');
    file:write('\n');
    file:write('sub.AGI = {}\n');
    file:write('\n');
    file:write('sub.INT = {}\n');
    file:write('\n');
    file:write('sub.MND = {}\n');
    file:write('\n');
    file:write('sub.CHR = {}\n');
    file:write('\n');
    file:write('sub.Elemental = {}\n');
    file:write('\n');
    file:write('sub.DarkMagic = {}\n');
    file:write('\n');
    file:write('sub.Enhancing = {}\n');
    file:write('\n');
    file:write('sub.Enfeebling = {}\n');
    file:write('\n');
    file:write('sub.Healing = {}\n');
    file:write('\n');
    file:write('sub.Divine = {}\n');
    file:write('\n');
    file:write('sub.Blue = {}\n');
    file:write('\n');
    file:write('sub.MAB = {}\n');
    file:write('\n');
    file:write('sub.CurePot = {}\n');
    file:write('\n');
    file:write('sub.Bar = {}');
    file:write('\n');
    file:write('sub.Med = {}\n');
    file:write('\n');
    file:write('sub.Waltz = {}\n');
    file:write('\n');
    file:write('sub.RF = {}\n');
    file:write('\n');
    file:write('sub.Jig = {}\n');
    file:write('\n');
    file:write('sub.Step = {}\n');
    file:write('\n');
    file:write('sub.Jump = {}\n');
    file:write('\n');
    file:write('sub.Mug = {}\n');
    file:write('\n');
    file:write('sub.VF = {}\n');
    file:write('\n');
    file:write('sub.Enmity = {}\n');
    file:write('\n');
    file:write('sub.Singing = {}\n');
    file:write('\n');
    file:write('sub.WoodWind = {}\n');
    file:write('\n');
    file:write('sub.String = {}\n');
    file:write('\n');
    file:write('sub.MoveSpeed = {}\n');
    file:write('\n');
    file:write('sub.Override = {\n');
    file:write('    TP = {},\n');
    file:write('\n');
    file:write('    Idle = {}\n');
    file:write('}\n');
    file:write('\n');
    file:write('return sub;\n');
    file:close();
end

JobHelpers.GenerateAllJobs = function()
    local path = string.format('%sconfig\\addons\\luashitacast\\%s_%u\\', AshitaCore:GetInstallPath(), gState.PlayerName, gState.PlayerId);
    local jobs = T{ 'WAR', 'MNK', 'THF', 'WHM', 'BLM', 'RDM', 'PLD', 'DRK', 'BST', 'BRD', 'RNG', 'SMN', 'SAM', 'NIN', 'DRG', 'BLU', 'COR', 'PUP', 'DNC', 'SCH', 'GEO', 'RUN'}

    for i=1,#jobs do
        if(not ashita.fs.exists(path .. jobs[i] .. '.lua'))then
            local file = io.open(path .. jobs[i] .. '.lua', 'w');

            file:write('local profile = gFunc.LoadFile(\'Global.lua\');\n');
            file:write('\n');
            file:write('return profile;');
            file:close();
        end
    end
end

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
        ['Langeleik'] = 'String'
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