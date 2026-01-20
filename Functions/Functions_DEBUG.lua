local GlobalAddonName, E = ...
function E.DEBUG_START()
	local timer = debugprofilestart()
	return timer
end
function E.DEBUG_STOP(funcName)
	if not funcName then funcName = "" end
	local timer = E.func_CompactRoundNumber(debugprofilestop())
	local result = funcName.." "..E.func_Gradient("debug timer: ", "|cffD177FF", "|cff63A4E0")
	result = result..timer
	return DEFAULT_CHAT_FRAME:AddMessage(result.."|cff63A4E0 ms.|r")
end
function E.debugInfo(id)
	local result = E.Config_DebugID_ALL and (E.COLOR_GRAY.." id:"..id.."|r") or ""
	return result
end
function E.func_goldenHeight(width)
	return width / 1.61803398875
end
function E.func_goldenWidth(height)
	return height * 1.61803398875
end
----------------------------------------------------------------
-- Вспомогательная функция: извлечение ID предметов из таблицы
-- Принимает любую таблицу tbl
-- Если tbl — массив (array), возвращает список значений
-- Если tbl — map/set, возвращает список ключей
-- Возвращает массив чисел/ключей
local function extractItemIDs(tbl)
	if not tbl then return nil end
	local list = {}
	-- Проверяем, является ли таблица массивом
	if #tbl > 0 then
		for i = 1, #tbl do
			list[#list + 1] = tbl[i]  -- добавляем значение в результат
		end
		return list
	end
	-- Если map или set, берём ключи
	for k in pairs(tbl) do
		list[#list + 1] = k
	end
	return list
end
-- local function extractItemIDs(tbl)
-- 	local list = {}
-- 	for itemID in pairs(tbl) do
-- 		if type(itemID) == "number" then
-- 			list[#list + 1] = itemID
-- 		end
-- 	end
-- 	return list
-- end
----------------------------------------------------------------
-- Вспомогательная функция для форматирования чанков
-- list: массив чисел или значений
-- chunk_size: сколько элементов в одной строке
-- formatter: функция, которая превращает элемент в строку
-- Возвращает массив строк, каждая строка содержит chunk_size элементов
local function formatChunks(list, chunk_size, formatter)
	local chunks = {}
	local count = #list
	for i = 1, count, chunk_size do
		local chunk = {}
		local last = math.min(i + chunk_size - 1, count)
		for j = i, last do
			chunk[#chunk + 1] = formatter(list[j])  -- применяем форматтер к элементу
		end
		chunks[#chunks + 1] = table.concat(chunk, ", ")  -- соединяем элементы через запятую
	end
	return chunks
end
----------------------------------------------------------------
-- Функция для вывода таблицы itemID как списка чисел, по 24 элемента в строке
-- tbl: любая таблица (массив, map, set)
-- Работает с глобальными E.editBox и E.editFrame
function E.func_itemslistSort24(tbl)
	if not tbl or not E.editBox or not E.editFrame then
		return
	end
	E.DEBUG_START()
	-- Извлекаем все itemID из таблицы
	local list = extractItemIDs(tbl)
	if #list == 0 then
		E.DEBUG_STOP()
		return
	end
	-- Удаляем дубликаты
	E.func_TableRemoveDuplicates(list)
	-- Сортировка по убыванию
	table.sort(list, function(a, b)
		return (tonumber(a) or a) > (tonumber(b) or b)
	end)
	-- Форматируем чанки по 24 элемента
	local chunks = formatChunks(list, 24, tostring)
	-- Объединяем все строки с переносом |n и добавляем финальную запятую
	E.editBox:SetText(table.concat(chunks, ",|n") .. ",")
	E.editFrame:Show()
	E.DEBUG_STOP()
end
----------------------------------------------------------------
-- Функция для вывода таблицы itemID в формате [itemID] = <val>, по 12 элементов в строке
-- tbl: любая таблица (массив, map, set)
-- val: значение, которое будет присвоено каждому itemID (по умолчанию "true")
-- Работает с глобальными E.editBox и E.editFrame
function E.func_itemslistToSetText_12(tbl, val)
	if not tbl or not E.editBox or not E.editFrame then
		return
	end
	E.DEBUG_START()
	local value = val or "true"
	local list = extractItemIDs(tbl)
	if #list == 0 then
		E.DEBUG_STOP()
		return
	end
	table.sort(list, function(a, b)
		return a > b
	end)
	local formatter = function(item)
		return string.format("[%d] = %s", item, value)
	end
	local chunks = formatChunks(list, 12, formatter)
	for i = 1, #chunks do
		chunks[i] = chunks[i] .. ","
	end
	E.editBox:SetText(table.concat(chunks, "|n"))
	E.editFrame:Show()
	E.DEBUG_STOP()
end