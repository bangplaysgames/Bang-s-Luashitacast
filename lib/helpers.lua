local helpers = {}
local chat = require('chat');

local blinkDelay = 0;

local lockDelay = 0;

local lockRetryDelay = 0;

local needBlink = false;

local needLock = false;

local locked = false;

local secondBlinkDelay = 0.5;

local lockTrackAfterBlink = 3;

local get_memory_manager = function()
	if (MemoryManager ~= nil) then
		return MemoryManager;
	end

	if (AshitaCore ~= nil and AshitaCore.GetMemoryManager ~= nil) then
		return AshitaCore:GetMemoryManager();
	end
end

local get_target_manager = function()
	local memoryManager = get_memory_manager();
	if (memoryManager ~= nil and memoryManager.GetTarget ~= nil) then
		return memoryManager:GetTarget();
	end
end

local now = function()
	return os.clock();
end

local get_locked_on = function()
	local targetManager = get_target_manager();
	if (targetManager == nil or bit == nil or bit.band == nil) then
		return false;
	end

	if (targetManager.GetLockedOnFlags == nil) then
		return false;
	end

	local flags = targetManager:GetLockedOnFlags();
	if (flags == nil) then
		return false;
	end

	return bit.band(flags, 1) == 1;
end

local set_model_update = function()
	local memoryManager = get_memory_manager();
	if (memoryManager == nil) then
		return;
	end

	if (memoryManager.GetParty == nil or memoryManager.GetEntity == nil) then
		return;
	end

	local partyManager = memoryManager:GetParty();
	local entityManager = memoryManager:GetEntity();
	if (partyManager == nil or entityManager == nil) then
		return;
	end

	if (partyManager.GetMemberTargetIndex == nil or entityManager.SetModelUpdateFlags == nil) then
		return;
	end

	local playerIndex = partyManager:GetMemberTargetIndex(0);
	if (playerIndex == nil) then
		return;
	end

	entityManager:SetModelUpdateFlags(playerIndex, 1);
end

require('common')

helpers.const = gFunc.LoadFile('constants.lua') or {}

helpers.thTable = {}

helpers.CurrentSub = '';

helpers.Aketon = {
	['Southern San d\'Oria'] = 'Kingdom Aketon',
	['Northern San d\'Oria'] = 'Kingdom Aketon',
	['Port San d\'Oria'] = 'Kingdom Aketon',
	['Chateau d\'Oraguille'] = 'Kingdom Aketon',
	['Bastok Markets'] = 'Republic Aketon',
	['Bastok Mines'] = 'Republic Aketon',
	['Bastok Metalworks'] = 'Republic Aketon',
	['Port Bastok'] = 'Republic Aketon',
	['Heaven\'s Tower'] = 'Federation Aketon',
	['Windurst Woods'] = 'Federation Aketon',
	['Windurst Waters'] = 'Federation Aketon',
	['Windurst Walls'] = 'Federation Aketon',
	['Port Windurst'] = 'Federation Aketon'
}

helpers.hasEntry = function(tab, val)
	if (tab == nil) then
		return;
	end

	for index, value in ipairs(tab) do
		if value == val then
			return true;
		end
	end
end

helpers.sortTable = function(t)
	if (t == nil) then
		return;
	end

	local function compare(a,b)
		if (a == nil or b == nil or a[2] == nil or b[2] == nil) then
			return false;
		end

		return a[2] < b[2];
	end

	if (table == nil or table.sort == nil) then
		return;
	end

	return table.sort(t, compare);
end

helpers.TreasureHunter = function (targetId, user)
	if(targetId == nil)then
		return;
	end

	local player;
	local memoryManager = get_memory_manager();
	if(memoryManager ~= nil)then
		local partyManager;
		if(memoryManager.GetParty ~= nil)then
			partyManager = memoryManager:GetParty();
		end
		if(partyManager ~= nil and partyManager.GetMemberServerId ~= nil)then
			player = partyManager:GetMemberServerId(0);
		end
	end

	local target;
	if(gData ~= nil and gData.GetTarget ~= nil)then
		target = gData.GetTarget();
	end
	local targ;

	if(target ~= nil)then
		targ = target.Index;
	end
	local targetEntity;
	if(targ ~= nil and GetEntity ~= nil)then
		targetEntity = GetEntity(targ);
	end
	if(helpers.thTable == nil)then
		helpers.thTable = {}
	end
	if(helpers.thTable ~= nil)then
		if(helpers.thTable[targetId] == nil)then
			helpers.thTable[targetId] = {}
			helpers.thTable[targetId].THApplied = false;
			if(targetEntity ~= nil)then
				helpers.thTable[targetId].Status = targetEntity.Status;
				helpers.thTable[targetId].HPP = targetEntity.HPPercent;
			end
		end
	end
	for k,v in pairs(helpers.thTable)do
		local targEntity;
		if(v.Index ~= nil and GetEntity ~= nil)then
			targEntity = GetEntity(v.Index);
		end
		if(targEntity ~= nil)then
			helpers.thTable[k].Status = targEntity.Status;
		end
	end

	if(player ~= nil and user == player)then
		if(target ~= nil)then
			if(targetId ~= nil and targetId == target.Id)then
				if(helpers.thTable[targetId] == nil)then
					helpers.thTable[targetId] = {}
					helpers.thTable[targetId].Index = target.Index;
					if(targetEntity ~= nil)then
						helpers.thTable[targetId].HPP = targetEntity.HPPercent;
						helpers.thTable[targetId].Status = targetEntity.Status;
					end
					helpers.thTable[targetId].THApplied = true;
				elseif(helpers.thTable[targetId] ~= nil and helpers.thTable[targetId].THApplied ~= true)then
					if(targetEntity ~= nil)then
						helpers.thTable[targetId].HPP = targetEntity.HPPercent;
						helpers.thTable[targetId].Status = targetEntity.Status;
					end
					helpers.thTable[targetId].THApplied = true;
				else
					if(targetEntity ~= nil)then
						helpers.thTable[targetId].HPP = targetEntity.HPPercent;
						helpers.thTable[targetId].Status = targetEntity.Status;
					end
				end
			end
		end
	end
end

helpers.UpdateTHTable = function()
	if(helpers.thTable == nil)then
		helpers.thTable = {}
	end

	for k,v in pairs(helpers.thTable)do
		local targEnt;
		if(v.Index ~= nil and GetEntity ~= nil)then
			targEnt = GetEntity(v.Index);
		end
		if(targEnt ~= nil)then
			helpers.thTable[k].Status = targEnt.Status;
			helpers.thTable[k].HPP = targEnt.HPPercent;
		end
	end
end

helpers.BadWeather = function(spell, Obis)
	if(spell == nil or spell.Element == nil or Obis == nil or gData == nil or gData.GetEnvironment == nil)then
		return false;
	end

	local env = gData.GetEnvironment();
	if(env == nil)then
		return false;
	end

	local weakWeather = {['Fire'] = 'Water', ['Ice'] = 'Fire', ['Wind'] = 'Ice', ['Earth'] = 'Wind', ['Thunder'] = 'Earth', ['Water'] = 'Thunder', ['Dark'] = 'Light', ['Light'] = 'Dark'}

	if(env.WeatherElement == weakWeather[spell.Element] and Obis[spell.Element] == 'Hachirin-no-Obi')then
		return true
	else
		return false
	end
end

helpers.GetObi = function(spell, Obis)
	if(spell == nil or Obis == nil or gData == nil or gData.GetEnvironment == nil)then
		return;
	end

	local element = spell.Element;
	if(element == nil)then
		return;
	end

	local env = gData.GetEnvironment();
	if(env == nil)then
		return;
	end

	if(element == env.WeatherElement or element == env.DayElement)then
		if(Obis[element] == '' or Obis[element] == nil)then
			return false;
		else
			if(not helpers.BadWeather(spell, Obis))then
				return Obis[element];
			end
		end
	end
end

helpers.WarpRing = function()
	local delay = os.time() + 11;
	if(gFunc ~= nil and gFunc.Equip ~= nil)then
		gFunc.Equip('ring1', 'Warp Ring');
	end
	if(chat ~= nil and chat.header ~= nil)then
		print(chat.header('Warp Ring Activated: ' .. tostring(delay - os.time())))
	else
		print('Warp Ring Activated: ' .. tostring(delay - os.time()))
	end
	return delay
end

helpers.ForceBlink = function(es, as)
	if (es == nil) then
		return;
	end

	local currentTime = now();
	local targetSet = as or {};
	local swap = es['Legs'];
	if (swap == targetSet['Legs'])then
		swap = nil;
	end

	if (not needLock or currentTime > lockDelay) then
		locked = get_locked_on();
		lockRetryDelay = 0;
	end
	needLock = true;
	blinkDelay = currentTime + secondBlinkDelay;
	lockDelay = blinkDelay + lockTrackAfterBlink;

	if (swap ~= nil) then
		if(gFunc ~= nil and gFunc.Equip ~= nil)then
			gFunc.Equip('Legs', swap);
		end
	else
		if(gFunc ~= nil and gFunc.EquipSet ~= nil)then
			gFunc.EquipSet(es);
		end
	end
	set_model_update();
	needBlink = true;
end

helpers.CheckBlink = function(es, ss)
	if (ss == nil) then
		return;
	end

	local currentTime = now();
	local targetManager = get_target_manager();
	local swap = ss['Legs'];
	if (es ~= nil and es['Legs'] == ss['Legs'])then
		swap = nil;
	end

	if (currentTime > blinkDelay and needBlink)then
		needBlink = false;
		if (swap ~= nil) then
			if(gFunc ~= nil and gFunc.Equip ~= nil)then
				gFunc.Equip('Legs', swap);
			end
		else
			if(gFunc ~= nil and gFunc.EquipSet ~= nil)then
				gFunc.EquipSet(ss);
			end
		end
		set_model_update();
	end

	if(needLock and currentTime > lockDelay)then
		needLock = false;
	end

	if(needLock and locked and targetManager ~= nil and not get_locked_on() and currentTime > lockRetryDelay)then
		local isSubTargetActive = 0;
		if(targetManager.GetIsSubTargetActive ~= nil)then
			isSubTargetActive = targetManager:GetIsSubTargetActive();
		end

		if(isSubTargetActive ~= 1)then
			local chatManager;
			if(AshitaCore ~= nil and AshitaCore.GetChatManager ~= nil)then
				chatManager = AshitaCore:GetChatManager();
			end
			if(chatManager ~= nil and chatManager.QueueCommand ~= nil)then
				chatManager:QueueCommand(-1, '/lockon')
			end
			lockRetryDelay = currentTime + 0.25;
		end
	end
end

helpers.WsNeedsAcc = function(WS)
	return helpers.hasEntry(helpers.const.AccWS, WS);
end
helpers.WsNeedAcc = helpers.WsNeedsAcc;

if(ashita ~= nil and ashita.events ~= nil and ashita.events.register ~= nil)then
	ashita.events.register('packet_in', 'helper_packet_in_cb', function(e)
	if(e == nil)then
		return;
	end

	if(e.id == 0x28 and e.data ~= nil and e.data.totable ~= nil and struct ~= nil and struct.unpack ~= nil and ashita ~= nil and ashita.bits ~= nil and ashita.bits.unpack_be ~= nil)then
		local targetId;
		local user = struct.unpack('L', e.data, 0x05 + 1);
		local dataTable = e.data:totable();
		if(dataTable ~= nil)then
			local targCount = ashita.bits.unpack_be(dataTable, 72, 10)
			if(targCount ~= nil)then
				for i=1,targCount do
					targetId = ashita.bits.unpack_be(dataTable, 150,     32)
				end
			end
		end
		helpers.TreasureHunter(targetId, user);
	end

	if(e.id == 0x29 and e.data ~= nil and struct ~= nil and struct.unpack ~= nil)then
		local t = struct.unpack('l', e.data, 0x08 + 0x01);
		local m = struct.unpack('H', e.data, 0x18 + 0x01);
		if(m == 6 and helpers.thTable ~= nil)then
			helpers.thTable[t] = nil
		end
	end

	if(e.id == 0x0A)then
		helpers.thTable = nil
		helpers.thTable = {}
	end

	helpers.UpdateTHTable();
end)

	ashita.events.register('d3d_present', 'helper_d3d_present_cb', function()

	end)
end

if(chat ~= nil and chat.error ~= nil)then
	print(chat.error('Helpers.lua Loaded'));
else
	print('Helpers.lua Loaded');
end

return helpers;
