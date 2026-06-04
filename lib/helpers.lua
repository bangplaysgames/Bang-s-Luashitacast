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

local addModSetEncoding;
local addModSetEncodingOk, addModSetEncodingModule = pcall(require, 'encoding');
if (addModSetEncodingOk) then
	addModSetEncoding = addModSetEncodingModule;
elseif (AshitaCore ~= nil and AshitaCore.GetInstallPath ~= nil and ashita ~= nil and ashita.fs ~= nil) then
	local encodingPath = AshitaCore:GetInstallPath() .. 'addons\\luashitacast\\encoding.lua';
	if (ashita.fs.exists(encodingPath)) then
		local encodingLoader = loadfile(encodingPath);
		if (encodingLoader ~= nil) then
			addModSetEncodingOk, addModSetEncodingModule = pcall(encodingLoader);
			if (addModSetEncodingOk) then
				addModSetEncoding = addModSetEncodingModule;
			end
		end
	end
end

pcall(require, 'sugar');

local BASE_ATTRIBUTE_STATS = { 'STR', 'DEX', 'VIT', 'AGI', 'INT', 'MND', 'CHR' };
local BASE_ATTRIBUTE_LOOKUP = {};
for _, stat in ipairs(BASE_ATTRIBUTE_STATS) do
	BASE_ATTRIBUTE_LOOKUP[stat] = true;
end

-- Lua patterns do not support | alternation; match each stat explicitly.
local STAT_VALUE_SEP_PATTERN = '[^0-9%+%-]*';
local STAT_SIGN_VALUE_PATTERN = '([+-]?)(%d+)';
local FFXI_FORMAT_BYTE_PATTERN = '[' .. string.char(0x1E, 0x1F, 0x7F) .. '].';

local function isBaseAttribute(stat)
	return BASE_ATTRIBUTE_LOOKUP[stat] == true;
end

local function countMods(mods)
	local count = 0;
	if (mods == nil) then
		return count;
	end

	for _ in pairs(mods) do
		count = count + 1;
	end
	return count;
end

local function toUtf8(text)
	if (text == nil) then
		return '';
	end

	if (addModSetEncoding ~= nil and addModSetEncoding.ShiftJIS_To_UTF8 ~= nil) then
		return addModSetEncoding:ShiftJIS_To_UTF8(text);
	end

	return text;
end

local profileModCache = nil;

local function stripDescriptionText(text)
	if (text == nil or text == '') then
		return '';
	end

	if (type(text) == 'string' and text.strip_colors ~= nil) then
		text = text:strip_colors();
	end

	text = text:gsub('\xEF.', ' ');
	text = text:gsub(FFXI_FORMAT_BYTE_PATTERN, '');
	text = text:gsub(string.char(0x01) .. '.', ' ');
	-- FFXI inserts icon bytes after a display digit; real value follows (e.g. STR+2<0x81><0x60>5 -> STR+5).
	for byte = 128, 255 do
		local prefix = string.char(byte);
		text = text:gsub('([+-])%d(' .. prefix .. '.)(%d)', '%1%3');
	end
	text = text:gsub('%s+', ' ');
	return text;
end

-- FFXI item descriptions embed control bytes between stat names and values.
local function sanitizeDescriptionRaw(text)
	return stripDescriptionText(text);
end

local function sanitizeDescriptionUtf8(text)
	return stripDescriptionText(text);
end

local function unescapeItemName(name)
	if (name == nil) then
		return '';
	end

	return name:gsub("\\'", "'");
end

local function extractItemNameBeforeMods(content, modsStart)
	if (content == nil or modsStart == nil or modsStart < 2) then
		return nil;
	end

	local closeQuote = modsStart - 1;
	while closeQuote > 0 and content:sub(closeQuote, closeQuote) ~= "'" do
		closeQuote = closeQuote - 1;
	end

	if (closeQuote < 2) then
		return nil;
	end

	local openQuote = closeQuote - 1;
	while openQuote > 0 do
		if (content:sub(openQuote, openQuote) == "'" and content:sub(openQuote - 1, openQuote - 1) ~= '\\') then
			break;
		end
		openQuote = openQuote - 1;
	end

	if (openQuote < 1 or content:sub(openQuote, openQuote) ~= "'") then
		return nil;
	end

	local nameRegion = content:sub(math.max(1, openQuote - 80), openQuote - 1);
	if (nameRegion:match('Name%s*=%s*$') == nil) then
		return nil;
	end

	return unescapeItemName(content:sub(openQuote + 1, closeQuote - 1));
end

local function parseModsExpressionsFromLua(block)
	local expressions = {};
	if (block == nil or block == '') then
		return expressions;
	end

	for _, stat in ipairs(BASE_ATTRIBUTE_STATS) do
		for expr in string.gmatch(block, stat .. '%s*=%s*([^,}]+)') do
			expressions[stat] = (expr:match('^%s*(.-)%s*$'));
		end
	end

	return expressions;
end

local function buildProfileModCache()
	profileModCache = {};
	if (AshitaCore == nil or gState == nil or ashita == nil or ashita.fs == nil) then
		return profileModCache;
	end

	local profileDir = string.format('%sconfig\\addons\\luashitacast\\%s_%u\\', AshitaCore:GetInstallPath(), gState.PlayerName, gState.PlayerId);
	if (not ashita.fs.exists(profileDir)) then
		return profileModCache;
	end

	local files = ashita.fs.get_directory(profileDir, '.*%.lua');
	if (files == nil) then
		return profileModCache;
	end

	for _, filePath in ipairs(files) do
		if (string.find(string.lower(filePath), 'backups', 1, true) == nil) then
			local file = io.open(filePath, 'r');
			if (file ~= nil) then
				local content = file:read('*all');
				file:close();
				if (content ~= nil) then
					local searchPos = 1;
					while true do
						local modsStart, modsEnd = string.find(content, 'Mods%s*=%s*{', searchPos);
						if (modsStart == nil) then
							break;
						end

						local blockStart = string.find(content, '{', modsStart, true);
						if (blockStart ~= nil) then
							local blockEnd = blockStart;
							local depth = 1;
							while blockEnd < #content and depth > 0 do
								blockEnd = blockEnd + 1;
								local byte = content:byte(blockEnd);
								if (byte == string.byte('{')) then
									depth = depth + 1;
								elseif (byte == string.byte('}')) then
									depth = depth - 1;
								end
							end

							local modsBlock = string.sub(content, blockStart + 1, blockEnd - 1);
							local itemName = extractItemNameBeforeMods(content, modsStart);
							if (itemName ~= nil) then
								local expressions = parseModsExpressionsFromLua(modsBlock);
								if (countMods(expressions) > 0) then
									local existing = profileModCache[itemName];
									if (existing == nil or countMods(expressions) > countMods(existing)) then
										profileModCache[itemName] = expressions;
									end
								end
							end
						end

						searchPos = modsEnd + 1;
					end
				end
			end
		end
	end

	return profileModCache;
end

local function getCachedModExpressions(itemName)
	if (itemName == nil or itemName == '') then
		return nil;
	end

	if (profileModCache == nil) then
		buildProfileModCache();
	end

	return profileModCache[itemName];
end

local function parseAttributeModsFromText(text)
	local mods = {};
	if (text == nil or text == '') then
		return mods;
	end

	text = sanitizeDescriptionUtf8(text);

	for _, stat in ipairs(BASE_ATTRIBUTE_STATS) do
		for sign, amount in string.gmatch(text, stat .. STAT_VALUE_SEP_PATTERN .. STAT_SIGN_VALUE_PATTERN) do
			local value = tonumber(amount) or 0;
			if (sign == '-') then
				value = -value;
			end
			mods[stat] = (mods[stat] or 0) + value;
		end
	end

	return mods;
end

local function getResourceByName(itemName)
	if (itemName == nil or itemName == '' or AshitaCore == nil) then
		return nil;
	end

	local resourceManager = AshitaCore:GetResourceManager();
	if (resourceManager == nil or resourceManager.GetItemByName == nil) then
		return nil;
	end

	for lang = 0, 2, 1 do
		local resource = resourceManager:GetItemByName(itemName, lang);
		if (resource ~= nil) then
			return resource;
		end
	end

	return nil;
end

local function getBaseModsFromResource(resource)
	local bestMods = {};
	local bestCount = 0;

	if (resource == nil or resource.Description == nil) then
		return bestMods;
	end

	for descIndex = 0, 3, 1 do
		local description = resource.Description[descIndex];
		if (description ~= nil and description ~= '') then
			local candidates = {
				parseAttributeModsFromText(sanitizeDescriptionUtf8(toUtf8(sanitizeDescriptionRaw(description)))),
				parseAttributeModsFromText(sanitizeDescriptionUtf8(sanitizeDescriptionRaw(description))),
				parseAttributeModsFromText(sanitizeDescriptionUtf8(description)),
			};

			for _, mods in ipairs(candidates) do
				local modCount = countMods(mods);
				if (modCount > bestCount) then
					bestCount = modCount;
					bestMods = mods;
				end
			end
		end
	end

	return bestMods;
end

local function expressionsToBaseMods(expressions)
	local baseMods = {};
	if (expressions == nil) then
		return baseMods;
	end

	for stat, expr in pairs(expressions) do
		if (type(expr) == 'number') then
			baseMods[stat] = expr;
		elseif (type(expr) == 'string') then
			local value = tonumber(expr);
			if (value == nil) then
				value = tonumber(expr:match('^%s*([+-]?%d+)'));
			end
			if (value ~= nil) then
				baseMods[stat] = value;
			end
		end
	end

	return baseMods;
end

local function appendAugmentMods(item, augLists)
	if (gData == nil or gData.GetAugment == nil or item == nil) then
		return;
	end

	local augment = gData.GetAugment(item);
	if (augment == nil or augment.Augs == nil) then
		return;
	end

	for _, aug in pairs(augment.Augs) do
		if (aug.Stat ~= nil and isBaseAttribute(aug.Stat) and aug.Value ~= nil) then
			augLists[aug.Stat] = augLists[aug.Stat] or {};
			augLists[aug.Stat][#augLists[aug.Stat] + 1] = aug.Value;
		elseif (aug.String ~= nil) then
			local parsed = parseAttributeModsFromText(aug.String);
			for stat, value in pairs(parsed) do
				augLists[stat] = augLists[stat] or {};
				augLists[stat][#augLists[stat] + 1] = value;
			end
		end
	end
end

local function formatModExpression(baseAmount, augAmounts)
	local base = baseAmount or 0;
	local augs = augAmounts or {};
	local terms = {};

	if (base ~= 0) then
		terms[#terms + 1] = tostring(base);
	end

	for _, value in ipairs(augs) do
		if (value ~= nil and value ~= 0) then
			if (#terms == 0) then
				terms[#terms + 1] = tostring(value);
			elseif (value > 0) then
				terms[#terms + 1] = '+ ' .. tostring(value);
			else
				terms[#terms + 1] = '- ' .. tostring(math.abs(value));
			end
		end
	end

	if (#terms == 0) then
		return nil;
	end

	return table.concat(terms, ' ');
end

local function buildModExpressions(baseMods, augLists)
	local modExpressions = {};
	for _, stat in ipairs(BASE_ATTRIBUTE_STATS) do
		local expression = formatModExpression(baseMods[stat], augLists[stat]);
		if (expression ~= nil) then
			modExpressions[stat] = expression;
		end
	end
	return modExpressions;
end

local function buildAugmentEntry(augment)
	if (augment == nil) then
		return nil;
	end

	if (augment.Type == 'Unaugmented') then
		return nil;
	end

	local entry = {};
	if (augment.Path ~= nil) then
		entry.AugPath = augment.Path;
	elseif (augment.Trial ~= nil) then
		entry.AugTrial = augment.Trial;
	elseif (augment.Augs ~= nil) then
		local augCount = 0;
		for _, _ in pairs(augment.Augs) do
			augCount = augCount + 1;
		end

		if (augCount == 1) then
			for _, v in pairs(augment.Augs) do
				entry.Augment = v.String;
			end
		else
			entry.Augment = {};
			local index = 1;
			for _, v in pairs(augment.Augs) do
				entry.Augment[index] = v.String;
				index = index + 1;
			end
		end
	end

	return entry;
end

local function buildModSetFromEquipped()
	local setTable = {};
	if (gEquip == nil or gEquip.GetCurrentEquip == nil or gData == nil) then
		return setTable;
	end

	buildProfileModCache();

	local resourceManager = AshitaCore:GetResourceManager();
	for i = 1, 16, 1 do
		local equip = gEquip.GetCurrentEquip(i);
		if (type(equip) == 'table') and (equip.Item ~= nil) then
			local resource = resourceManager:GetItemById(equip.Item.Id);
			if (resource ~= nil) then
				local slot = gData.Constants.EquipSlotNames[i];
				local resourceName = toUtf8(resource.Name[1]);
				if (resourceName == nil or resourceName == '') then
					for nameIndex = 0, 3, 1 do
						if (resource.Name[nameIndex] ~= nil and resource.Name[nameIndex] ~= '') then
							resourceName = toUtf8(resource.Name[nameIndex]);
							break;
						end
					end
				end

				if (countMods(getBaseModsFromResource(resource)) == 0) then
					local resourceByName = getResourceByName(resourceName);
					if (resourceByName ~= nil) then
						resource = resourceByName;
					end
				end

				local baseMods = getBaseModsFromResource(resource);
				local augLists = {};
				appendAugmentMods(equip.Item, augLists);
				local modExpressions = buildModExpressions(baseMods, augLists);
				local augment = gData.GetAugment(equip.Item);
				local entry = { Name = resourceName };

				local augmentEntry = buildAugmentEntry(augment);
				if (augmentEntry ~= nil) then
					for key, value in pairs(augmentEntry) do
						entry[key] = value;
					end
				end

				if (countMods(modExpressions) == 0) then
					local cachedExpressions = getCachedModExpressions(resourceName);
					if (cachedExpressions ~= nil) then
						if (countMods(augLists) > 0) then
							modExpressions = buildModExpressions(expressionsToBaseMods(cachedExpressions), augLists);
						else
							modExpressions = cachedExpressions;
						end
					end
				end

				if (next(modExpressions) ~= nil) then
					entry.Mods = modExpressions;
				end

				setTable[slot] = entry;
			end
		end
	end

	return setTable;
end

local function writeModsTable(file, mods)
	file:write('Mods = { ');
	local first = true;
	for _, stat in ipairs(BASE_ATTRIBUTE_STATS) do
		local expression = mods[stat];
		if (expression ~= nil) then
			if (not first) then
				file:write(', ');
			end
			file:write(stat .. ' = ' .. expression);
			first = false;
		end
	end
	file:write(' }');
end

local function writeModSetEntry(file, slot, entry)
	local outString = '        ' .. slot .. ' = { Name = \'' .. string.gsub(entry.Name, '\'', '\\\'') .. '\'';
	if (entry.Mods ~= nil) then
		outString = outString .. ', ';
		file:write(outString);
		writeModsTable(file, entry.Mods);
		outString = '';
	end

	if (entry.Augment ~= nil) then
		if (type(entry.Augment) == 'string') then
			outString = outString .. ', Augment = \'' .. entry.Augment .. '\'';
		elseif (type(entry.Augment) == 'table') then
			local augIndex = 1;
			outString = outString .. ', Augment = { ';
			for _, checkAugment in pairs(entry.Augment) do
				if (augIndex ~= 1) then
					outString = outString .. ', ';
				end
				outString = outString .. '[' .. augIndex .. '] = \'' .. checkAugment .. '\'';
				augIndex = augIndex + 1;
			end
			outString = outString .. ' }';
		end
	end

	if (entry.AugPath ~= nil) then
		outString = outString .. ', AugPath=\'' .. entry.AugPath .. '\'';
	end

	if (entry.AugRank ~= nil) then
		outString = outString .. ', AugRank=' .. entry.AugRank;
	end

	if (entry.AugTrial ~= nil) then
		outString = outString .. ', AugTrial=' .. entry.AugTrial;
	end

	if (entry.Bag ~= nil) then
		outString = outString .. ', Bag=\'' .. entry.Bag .. '\'';
	end

	if (entry.Mods == nil) then
		outString = outString .. ' },\n';
		file:write(outString);
	else
		file:write(outString .. ' },\n');
	end
end

local function writeModSet(file, name, set)
	file:write('[\'' .. name .. '\'] = {\n');
	for i = 1, 16, 1 do
		local index = i;
		if (gSettings ~= nil and gSettings.AddSetEquipScreenOrder == true and gData ~= nil and gData.Constants ~= nil) then
			index = gData.Constants.EquipScreenOrder[i];
		end
		local slot = gData.Constants.EquipSlotNames[index];
		local entry = set[slot];
		if (entry ~= nil) then
			writeModSetEntry(file, slot, entry);
		end
	end
	file:write('    }');
end

local function parseSetsTable(wholeFile)
	local matchStrings = {
		'local sets = {',
		'local Sets = {',
		'profile.Sets = {',
		'local sets = T{',
		'local Sets = T{',
		'profile.Sets = T{'
	};

	local setsStart, setsEnd;
	for _, match in ipairs(matchStrings) do
		setsStart, setsEnd = string.find(wholeFile, match);
		if setsStart then
			break;
		end
	end

	return setsStart, setsEnd;
end

local function parseSetsKeys(wholeFile, startIndex)
	local comma = string.byte(',');
	local openBracket = string.byte('[');
	local closeBracket = string.byte(']');
	local parenthesisOpen = string.byte('{');
	local parenthesisClose = string.byte('}');
	local escapeSlash = string.byte('\\');
	local equalSign = string.byte('=');
	local singleQuote = string.byte('\'');
	local doubleQuote = string.byte('\"');
	local lineBreak = string.byte('\n');
	local underscore = string.byte('_');

	local function isLetter(byte)
		if ((byte >= 65) and (byte <= 90)) then
			return true;
		end
		return ((byte >= 97) and (byte <= 122));
	end

	local function isNumber(byte)
		return ((byte >= 48) and (byte <= 57));
	end

	local parenthesisCount = 1;
	local commentState = 'none';
	local stringState = 'none';
	local entryName = '';
	local entryState = 'none';
	local entryStart = 0;
	local keyIndices = {};
	local i = startIndex;
	local len = #wholeFile;

	while i <= len do
		local byte = wholeFile:byte(i);

		if commentState == 'blockcomment' then
			if string.sub(wholeFile, i, i + 1) == ']]' then
				commentState = 'none';
				i = i + 1;
			end
		elseif commentState == 'comment' then
			if byte == lineBreak then
				commentState = 'none';
			end
		elseif stringState == 'singlequote' then
			if byte == singleQuote then
				stringState = 'none';
			elseif byte == escapeSlash then
				i = i + 1;
			end
		elseif stringState == 'doublequote' then
			if byte == doubleQuote then
				stringState = 'none';
			elseif byte == escapeSlash then
				i = i + 1;
			end
		elseif string.sub(wholeFile, i, i + 3) == '--[[' then
			commentState = 'blockcomment';
			i = i + 3;
		elseif string.sub(wholeFile, i, i + 1) == '--' then
			commentState = 'comment';
			i = i + 1;
		elseif byte == singleQuote then
			stringState = 'singlequote';
		elseif byte == doubleQuote then
			stringState = 'doublequote';
		elseif byte == parenthesisOpen then
			parenthesisCount = parenthesisCount + 1;
		elseif byte == parenthesisClose then
			parenthesisCount = parenthesisCount - 1;
			if (parenthesisCount == 0) then
				if entryState == 'value' then
					keyIndices[#keyIndices + 1] = { Name = entryName, StartIndex = entryStart, EndIndex = i - 1 };
				end
				return keyIndices, i;
			end
		elseif entryState == 'key' then
			if (not isLetter(byte)) and (not isNumber(byte)) and (byte ~= underscore) then
				entryName = string.sub(wholeFile, entryStart, i - 1);
				if byte == equalSign then
					entryState = 'value';
				else
					entryState = 'space';
				end
			end
		elseif entryState == 'bracketkey' then
			if byte == closeBracket then
				entryName = string.sub(wholeFile, entryStart + 1, i - 1);
				local firstByte = string.byte(entryName, 1);
				local lastByte = string.byte(entryName, #entryName);
				if (firstByte == singleQuote) or (firstByte == doubleQuote) then
					entryName = string.sub(entryName, 2);
				end
				if ((lastByte == singleQuote) or (lastByte == doubleQuote)) then
					entryName = string.sub(entryName, 1, -2);
				end
				entryState = 'space';
			end
		elseif entryState == 'none' then
			if isLetter(byte) or byte == underscore then
				entryStart = i;
				entryState = 'key';
			elseif byte == openBracket then
				entryStart = i;
				entryState = 'bracketkey';
			end
		elseif entryState == 'space' then
			if byte == comma then
				entryState = 'none';
			elseif byte == equalSign then
				entryState = 'value';
			end
		elseif entryState == 'value' then
			if (byte == comma) and (parenthesisCount == 1) then
				keyIndices[#keyIndices + 1] = { Name = entryName, StartIndex = entryStart, EndIndex = i - 1 };
				entryState = 'none';
			end
		end

		i = i + 1;
	end

	return keyIndices, #wholeFile;
end

local function saveModSet(name, set)
	if (gProfile == nil or gProfile.FilePath == nil) then
		if (chat ~= nil and chat.header ~= nil) then
			print(chat.header('AddModSet') .. chat.error('No profile loaded.'));
		end
		return false;
	end

	local file = io.open(gProfile.FilePath, 'r');
	if (file == nil) then
		if (chat ~= nil and chat.header ~= nil) then
			print(chat.header('AddModSet') .. chat.error('Failed to open profile in read mode: ') .. chat.color1(2, gProfile.FilePath));
		end
		return false;
	end

	local wholeFile = file:read('*all');
	file:close();

	local setsStart, setsEnd = parseSetsTable(wholeFile);
	if (not setsStart) then
		if (chat ~= nil and chat.header ~= nil) then
			print(chat.header('AddModSet') .. chat.error('Could not locate sets table in: ') .. chat.color1(2, gProfile.FilePath));
		end
		return false;
	end

	if (gSettings ~= nil and gSettings.AddSetBackups and gFileTools ~= nil and gFileTools.CreateDirectories ~= nil and gState ~= nil) then
		local copyName = string.format('%s_%s', os.date('%Y.%m.%d_%H.%M.%S'), gProfile.FileName);
		local copyPath = string.format('%sconfig\\addons\\luashitacast\\%s_%u\\backups\\%s', AshitaCore:GetInstallPath(), gState.PlayerName, gState.PlayerId, copyName);
		gFileTools.CreateDirectories(copyPath);
		local backup = io.open(copyPath, 'w');
		if (backup ~= nil) then
			backup:write(wholeFile);
			backup:close();
		end
	end

	local keys, tableEnd = parseSetsKeys(wholeFile, setsEnd + 1);
	file = io.open(gProfile.FilePath, 'w');
	if (file == nil) then
		if (chat ~= nil and chat.header ~= nil) then
			print(chat.header('AddModSet') .. chat.error('Failed to open profile in write mode: ') .. chat.color1(2, gProfile.FilePath));
		end
		return false;
	end

	if #keys == 0 then
		file:write(string.sub(wholeFile, 1, setsEnd));
		file:write('\n    ');
		writeModSet(file, name, set);
		file:write(',\n');
		if tableEnd < #wholeFile then
			file:write(string.sub(wholeFile, tableEnd));
		end
		file:close();
	else
		local replaced = false;
		for _, key in pairs(keys) do
			if (key.Name == name) then
				file:write(string.sub(wholeFile, 1, key.StartIndex - 1));
				writeModSet(file, name, set);
				if ((key.EndIndex + 1) < #wholeFile) then
					file:write(string.sub(wholeFile, key.EndIndex + 1));
				end
				file:close();
				replaced = true;
				break;
			end
		end

		if (not replaced) then
			local offset = keys[#keys].EndIndex;
			file:write(string.sub(wholeFile, 1, offset));
			file:write(',\n    ');
			writeModSet(file, name, set);
			if ((offset + 1) < #wholeFile) then
				file:write(string.sub(wholeFile, offset + 1));
			end
			file:close();
		end
	end

	if (chat ~= nil and chat.header ~= nil) then
		print(chat.header('AddModSet') .. chat.message('Wrote mod set ') .. chat.color1(2, name) .. chat.message(' to file: ') .. chat.color1(2, gProfile.FilePath));
	end

	return true;
end

local function resolveSetTableName(setName)
	local setTableName = nil;
	if (gProfile ~= nil and gProfile.Sets ~= nil) then
		for name, _ in pairs(gProfile.Sets) do
			if (setName == name) then
				setTableName = name;
			end
		end

		if (setTableName == nil) then
			local lowerName = string.lower(setName);
			for name, _ in pairs(gProfile.Sets) do
				if (string.lower(name) == lowerName) then
					setTableName = name;
				end
			end
		end
	end

	if (setTableName == nil) then
		setTableName = setName;
	end

	return setTableName;
end

local function validateSetName(setName)
	if (setName == nil or setName == '') then
		return false, 'You must specify a set name for addmodset.';
	end

	local cleanSetName = setName:gsub('[^%w%s_]+', '');
	if (setName ~= cleanSetName) then
		return false, 'Invalid characters located in set name. Set must be only letters, numbers and underscores.';
	end

	if (string.sub(setName, 1, 1) == '_') then
		return false, 'Set name should not start with an underscore.';
	end

	if (tonumber(string.sub(setName, 1, 1)) ~= nil) then
		return false, 'Set name cannot start with a number.';
	end

	return true, nil;
end

local function getAddModSetDumpPath()
	if (AshitaCore == nil or gState == nil) then
		return nil;
	end

	local fileName = string.format('addmodset_dump_%s.txt', os.date('%Y.%m.%d_%H.%M.%S'));
	return string.format('%sconfig\\addons\\luashitacast\\%s_%u\\%s', AshitaCore:GetInstallPath(), gState.PlayerName, gState.PlayerId, fileName);
end

local function writeDumpLine(file, text)
	file:write(text .. '\n');
end

local function writeDumpHex(file, label, text)
	writeDumpLine(file, label);
	if (text == nil or text == '') then
		writeDumpLine(file, '  (empty)');
		return;
	end

	writeDumpLine(file, string.format('  length: %d', #text));
	local line = {};
	for i = 1, #text do
		line[#line + 1] = string.format('%02X', text:byte(i));
		if (#line == 16) then
			writeDumpLine(file, '  ' .. table.concat(line, ' '));
			line = {};
		end
	end

	if (#line > 0) then
		writeDumpLine(file, '  ' .. table.concat(line, ' '));
	end
end

local function writeDumpPrintable(file, label, text)
	writeDumpLine(file, label);
	if (text == nil or text == '') then
		writeDumpLine(file, '  (empty)');
		return;
	end

	writeDumpLine(file, '  ' .. text);
end

local function writeDumpModsTable(file, label, mods)
	writeDumpLine(file, label);
	if (mods == nil or countMods(mods) == 0) then
		writeDumpLine(file, '  (none)');
		return;
	end

	for _, stat in ipairs(BASE_ATTRIBUTE_STATS) do
		local value = mods[stat];
		if (value ~= nil) then
			writeDumpLine(file, string.format('  %s = %s', stat, tostring(value)));
		end
	end
end

local function writeDumpAugment(file, augment)
	writeDumpLine(file, 'Augment data:');
	if (augment == nil) then
		writeDumpLine(file, '  (nil)');
		return;
	end

	writeDumpLine(file, string.format('  Type: %s', tostring(augment.Type)));
	if (augment.Path ~= nil) then
		writeDumpLine(file, string.format('  Path: %s', tostring(augment.Path)));
	end
	if (augment.Trial ~= nil) then
		writeDumpLine(file, string.format('  Trial: %s', tostring(augment.Trial)));
	end

	if (augment.Augs == nil) then
		writeDumpLine(file, '  Augs: (none)');
		return;
	end

	for key, aug in pairs(augment.Augs) do
		writeDumpLine(file, string.format('  Aug[%s]:', tostring(key)));
		if (type(aug) == 'table') then
			writeDumpLine(file, string.format('    Stat: %s', tostring(aug.Stat)));
			writeDumpLine(file, string.format('    Value: %s', tostring(aug.Value)));
			writeDumpLine(file, string.format('    Percent: %s', tostring(aug.Percent)));
			writeDumpPrintable(file, '    String:', aug.String);
			if (aug.String ~= nil) then
				writeDumpHex(file, '    String (hex):', aug.String);
			end
		else
			writeDumpLine(file, string.format('    %s', tostring(aug)));
		end
	end
end

local function writeDumpDescriptions(file, resource)
	writeDumpLine(file, 'Descriptions:');
	if (resource == nil or resource.Description == nil) then
		writeDumpLine(file, '  (no resource or Description table)');
		return;
	end

	for descIndex = 0, 3, 1 do
		local description = resource.Description[descIndex];
		writeDumpLine(file, string.format('  [%d] raw', descIndex));
		if (description == nil or description == '') then
			writeDumpLine(file, '    (empty)');
		else
			writeDumpHex(file, '    hex:', description);
			writeDumpPrintable(file, '    as-is:', description);
			local stripped = sanitizeDescriptionRaw(description);
			writeDumpPrintable(file, '    after sanitizeDescriptionRaw:', stripped);
			writeDumpPrintable(file, '    after toUtf8(sanitize raw):', sanitizeDescriptionUtf8(toUtf8(stripped)));
			writeDumpModsTable(file, '    parsed mods (utf8 path):', parseAttributeModsFromText(sanitizeDescriptionUtf8(toUtf8(stripped))));
			writeDumpModsTable(file, '    parsed mods (raw sanitize):', parseAttributeModsFromText(sanitizeDescriptionUtf8(stripped)));
		end
	end
end

helpers.DumpEquippedItemData = function()
	if (gEquip == nil or gEquip.GetCurrentEquip == nil or gData == nil) then
		if (chat ~= nil and chat.header ~= nil) then
			print(chat.header('AddModSet') .. chat.error('Cannot dump: gEquip or gData unavailable.'));
		end
		return false;
	end

	local dumpPath = getAddModSetDumpPath();
	if (dumpPath == nil) then
		if (chat ~= nil and chat.header ~= nil) then
			print(chat.header('AddModSet') .. chat.error('Cannot determine dump file path.'));
		end
		return false;
	end

	if (gFileTools ~= nil and gFileTools.CreateDirectories ~= nil) then
		gFileTools.CreateDirectories(dumpPath);
	end

	local file = io.open(dumpPath, 'w');
	if (file == nil) then
		if (chat ~= nil and chat.header ~= nil) then
			print(chat.header('AddModSet') .. chat.error('Failed to open dump file: ') .. chat.color1(2, dumpPath));
		end
		return false;
	end

	writeDumpLine(file, '=== AddModSet equipped gear dump ===');
	writeDumpLine(file, string.format('Time: %s', os.date('%Y-%m-%d %H:%M:%S')));
	if (gProfile ~= nil and gProfile.FilePath ~= nil) then
		writeDumpLine(file, string.format('Profile: %s', gProfile.FilePath));
	end
	writeDumpLine(file, string.format('Encoding loaded: %s', tostring(addModSetEncoding ~= nil)));
	writeDumpLine(file, string.format('strip_colors available: %s', tostring(type('') == 'string' and ('').strip_colors ~= nil)));
	writeDumpLine(file, '');

	buildProfileModCache();
	local resourceManager = AshitaCore:GetResourceManager();

	for i = 1, 16, 1 do
		local equip = gEquip.GetCurrentEquip(i);
		if (type(equip) == 'table') and (equip.Item ~= nil) then
			local resource = resourceManager:GetItemById(equip.Item.Id);
			local slot = gData.Constants.EquipSlotNames[i];
			writeDumpLine(file, string.format('--- Slot: %s ---', slot));
			writeDumpLine(file, string.format('Item Id: %s', tostring(equip.Item.Id)));

			if (resource == nil) then
				writeDumpLine(file, 'Resource: (nil)');
			else
				local resourceName = toUtf8(resource.Name[1]);
				if (resourceName == nil or resourceName == '') then
					for nameIndex = 0, 3, 1 do
						if (resource.Name[nameIndex] ~= nil and resource.Name[nameIndex] ~= '') then
							resourceName = toUtf8(resource.Name[nameIndex]);
							break;
						end
					end
				end

				writeDumpLine(file, string.format('Name: %s', resourceName));
				writeDumpDescriptions(file, resource);

				local resourceByName = getResourceByName(resourceName);
				if (resourceByName ~= nil and resourceByName ~= resource) then
					writeDumpLine(file, 'Resource by name (alternate):');
					writeDumpDescriptions(file, resourceByName);
					resource = resourceByName;
				end

				local baseMods = getBaseModsFromResource(resource);
				local augLists = {};
				appendAugmentMods(equip.Item, augLists);
				local modExpressions = buildModExpressions(baseMods, augLists);
				local augment = gData.GetAugment(equip.Item);

				writeDumpAugment(file, augment);
				writeDumpModsTable(file, 'Parsed base mods (description):', baseMods);
				writeDumpLine(file, 'Parsed augment lists:');
				for _, stat in ipairs(BASE_ATTRIBUTE_STATS) do
					local amounts = augLists[stat];
					if (amounts ~= nil) then
						writeDumpLine(file, string.format('  %s: %s', stat, table.concat(amounts, ', ')));
					end
				end
				writeDumpModsTable(file, 'Built mod expressions (before cache):', modExpressions);

				local cachedExpressions = getCachedModExpressions(resourceName);
				writeDumpModsTable(file, 'Profile cache mods:', cachedExpressions);

				if (countMods(modExpressions) == 0 and cachedExpressions ~= nil) then
					if (countMods(augLists) > 0) then
						modExpressions = buildModExpressions(expressionsToBaseMods(cachedExpressions), augLists);
					else
						modExpressions = cachedExpressions;
					end
				end
				writeDumpModsTable(file, 'Final mod expressions:', modExpressions);
			end

			writeDumpLine(file, '');
		end
	end

	file:close();

	if (chat ~= nil and chat.header ~= nil) then
		print(chat.header('AddModSet') .. chat.message('Wrote equipped gear dump to: ') .. chat.color1(2, dumpPath));
	end

	return true, dumpPath;
end

helpers.AddModSet = function(setName)
	if (gSettings ~= nil and gSettings.AllowAddSet == false) then
		if (chat ~= nil and chat.header ~= nil) then
			print(chat.header('AddModSet') .. chat.error('Your profile has addset disabled.'));
		end
		return false;
	end

	if (gProfile == nil) then
		if (chat ~= nil and chat.header ~= nil) then
			print(chat.header('AddModSet') .. chat.error('You must have a profile loaded to use addmodset.'));
		end
		return false;
	end

	if (gProfile.Sets == nil) then
		if (chat ~= nil and chat.header ~= nil) then
			print(chat.header('AddModSet') .. chat.error('Your profile must have a sets table to use addmodset.'));
		end
		return false;
	end

	local valid, validationMessage = validateSetName(setName);
	if (not valid) then
		if (chat ~= nil and chat.header ~= nil) then
			print(chat.header('AddModSet') .. chat.error(validationMessage));
		end
		return false;
	end

	local setTableName = resolveSetTableName(setName);
	local modSet = buildModSetFromEquipped();
	if (saveModSet(setTableName, modSet)) then
		if (gState ~= nil and gState.LoadProfileEx ~= nil) then
			gState.LoadProfileEx(gProfile.FilePath);
		end
		return true;
	end

	return false;
end

if(ashita ~= nil and ashita.events ~= nil and ashita.events.register ~= nil)then
	if (ashita.events.unregister ~= nil) then
		ashita.events.unregister('command', 'helpers_addmodset_command_cb');
		ashita.events.unregister('packet_in', 'helper_packet_in_cb');
		ashita.events.unregister('d3d_present', 'helper_d3d_present_cb');
	end
	ashita.events.register('command', 'helpers_addmodset_command_cb', function(e)
		if (e == nil or e.command == nil) then
			return;
		end

		local args = e.command:args();
		if (#args == 0 or string.lower(args[1]) ~= '/addmodset') then
			return;
		end

		e.blocked = true;
		if (#args < 2) then
			if (chat ~= nil and chat.header ~= nil) then
				print(chat.header('AddModSet') .. chat.error('Usage: /addmodset <SetName>  or  /addmodset dump'));
			end
			return;
		end

		if (string.lower(args[2]) == 'dump' or string.lower(args[2]) == 'debug') then
			helpers.DumpEquippedItemData();
			return;
		end

		local parsedName = AshitaCore:GetChatManager():ParseAutoTranslate(args[2], false);
		helpers.AddModSet(parsedName);
	end);
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
