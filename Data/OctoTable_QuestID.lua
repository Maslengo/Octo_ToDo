local GlobalAddonName, E = ...
local AddonTitle = C_AddOns.GetAddOnMetadata(GlobalAddonName, "Title")
--------------------------------------------------------------------------------
E.Octo_Table.OctoTable_QuestID = {
	57300,
	83740, -- Дурная слава у визиря
	83739, -- Дурная слава у генерала
	83738, -- Дурная слава у Прядильщицы
	83459, -- |A:questlog-questtypeicon-dungeon:14:14:0:0|a "Сияющий Рассвет"
	83339, -- Разрушители шпилей
	83338, -- Убийца Магов
	83337, -- Оскал бури
	83335, -- Разыскивается: попиратель
	83333, -- |A:Recurringavailablequesticon:14:14:0:0|a Шестеренки неприятностей
	83331, -- Важные (?) находки
	83153, -- Образцы газа
	82946, -- |A:Recurringavailablequesticon:14:14:0:0|a Вниз в глубины
	82678, -- |A:Wrapperavailablequesticon:14:14:0:0|a Архивы: первый диск
	82653, -- Скопище кошмаров
	82511, -- |A:Wrapperavailablequesticon:14:14:0:0|a Душа мира: Машина пробуждения
	82485, -- |A:Wrapperavailablequesticon:14:14:0:0|a Душа мира: Искроварня
	82482, -- |A:Wrapperavailablequesticon:14:14:0:0|a Душа мира: разнюхивание
	82452, -- |A:Wrapperavailablequesticon:14:14:0:0|a Воспоминание души мира: локальные задания
	81999, -- Новый дом – новая свечка!
	81966, -- |A:CampaignAvailableQuestIcon:11:11:0:0|a Каменный сон
	81574, -- |A:Recurringavailablequesticon:14:14:0:0|a Неудержимая поросль
	80670, -- |A:Wrapperavailablequesticon:14:14:0:0|a Глаза Прядильщицы
	80434, -- В подземные глубины
	80187, -- |A:Recurringavailablequesticon:14:14:0:0|a Выживание в стычках
	79683, -- Где свечка, там и дом
	79346, -- |A:Recurringavailablequesticon:14:14:0:0|a Жвачка против кошмаров
	79220, -- Известность у Ассамблеи глубин
	79219, -- Известность у совета Дорногала
	79218, -- Известность среди Арати Тайносводья
	79196, -- Известность у Отрезанных нитей
	79173, -- |A:Recurringavailablequesticon:14:14:0:0|a Помощь с припасами
	78933, -- |A:Recurringavailablequesticon:14:14:0:0|a Сладкое затмение
	78915, -- |A:Recurringavailablequesticon:14:14:0:0|a Тыквенная угроза
	78821, -- |A:Recurringavailablequesticon:14:14:0:0|a Цветение во Сне
	78714, -- |A:CampaignAvailableQuestIcon:11:11:0:0|a Вам не рады
	78713, -- |A:CampaignAvailableQuestIcon:11:11:0:0|a Сокрытая война
	78631, -- Разговор с глашатаями
	78504, -- Слегка помятый подарок
	78468, -- Архив
	78444, -- |A:Recurringavailablequesticon:14:14:0:0|a Достойный союзник: Стражи Сна
	78319, -- |A:Recurringavailablequesticon:14:14:0:0|a Цветочный бум
	78131, -- Подарок к Зимнему Покрову
	78033, -- Магический цветок
	78015, -- Фистия Огнемеченная
	77982, -- Жадный Джесси
	77878, -- Посланник Зимы
	77747, -- Полная бочка
	77746, -- Полная бочка
	77745, -- Полная бочка
	77744, -- Полная бочка
	77679, -- Помощь Соридорми
	77437, -- Грань Эпохи
	77414, -- Исследование Прилива Снов
	77251, -- |A:Recurringavailablequesticon:14:14:0:0|a Укрощение Прилива Снов
	77236, -- |A:Recurringavailablequesticon:14:14:0:0|a Исцелить само время
	77155, -- Полная бочка
	77153, -- Полная бочка
	77152, -- Полная бочка
	77099, -- Полная бочка
	77097, -- Полная бочка
	77096, -- Полная бочка
	77095, -- Полная бочка
	76733, -- |A:Recurringavailablequesticon:14:14:0:0|a В поисках картофеля
	76586, -- Принеси им свет
	76547, -- Все, что блестит
	76546, -- Идеология боголомов
	76533, -- Опасные документы
	76531, -- Полная бочка
	76459, -- Сопротивление
	76453, -- Память камня
	76449, -- Вечное противостояние
	76425, -- Известность у Стражей Сна
	76406, -- Грехи Испепелителя
	76404, -- Шестеренки в системе
	76379, -- Заходят как-то мурлок и дракон в портал времени...
	76362, -- Рогатый череп
	76351, -- Звери титанов
	76317, -- Зов Сна
	76169, -- |A:Recurringavailablequesticon:14:14:0:0|a Свечение во тьме
	76140, -- Рассвет Бесконечности
	75923, -- Поднять тревогу
	75922, -- Обжигающие новости
	75921, -- Сквозь пламя
	75920, -- Огненные взгляды
	75919, -- Остудить обереги
	75918, -- Огнеопасная вылазка
	75888, -- Лагерь насыщения
	75887, -- Силы Фиракка
	75694, -- |A:questlog-questtypeicon-raid:14:14:0:0|a Аберрий, Затененное Горнило: Саркарет
	75665, -- |A:Recurringavailablequesticon:14:14:0:0|a Достойный союзник: лоаммские ниффы
	75622, -- Всем бойцам!
	75576, -- Вторжение в "Угрюмого обжору"!
	75476, -- Колоссиан
	75459, -- Новейшие раскопки
	75366, -- Зеленый король
	75364, -- Углемрак
	75360, -- Подземарк
	75358, -- Жарик
	75353, -- Динн
	75349, -- Скорнак
	75342, -- Кронкапакс
	75340, -- Магтембо
	75338, -- Лавермикс
	75336, -- Инвок
	75334, -- Карокта
	75326, -- Брулло Мощный
	75322, -- Клакатак
	75314, -- Гадексия
	75298, -- Беспросветная королева
	75296, -- Генерал Зкорро
	75292, -- Профессор Гастринакс
	75290, -- Известность среди лоаммских ниффов
	75285, -- Алканон
	75276, -- Костеплет
	75274, -- Жижек
	75271, -- Аквифон
	75269, -- Капраку
	75267, -- Коб'рок
	75239, -- Ученик Фиракка: Шадейсетал
	74905, -- Исследователи под огнем
	74775, -- Ученик Фиракка: Кретченрат
	74568, -- |A:Recurringavailablequesticon:14:14:0:0|a Смерть поджигателям
	74378, -- Неистовство бури
	74349, -- Укобород
	74347, -- Ангварди Убийца Змеев
	74346, -- Кэрри Лютоглаз
	74345, -- Велтракс
	74344, -- Леди Шаз'ра
	74343, -- Грагот Крушитель Кораблей
	74342, -- Галахад
	74341, -- Просеиватель костей Марвак
	74339, -- Рейза Утопленница
	74338, -- Ишира
	74337, -- Газ'раксес
	74336, -- Вракен Охотник
	74333, -- Неистовый аметист
	74332, -- Люттрок
	74331, -- Агни Пылающее Копыто
	74330, -- Фимбул
	74329, -- Кангало
	74328, -- Чаротрикс
	74325, -- Кузнец приливов Зарвисс
	74322, -- Фавнос
	74321, -- Гарид
	74307, -- Кривоклык
	74306, -- Манафема
	74305, -- Профессор Клешнер
	74300, -- Тектоний
	72693, -- Припасы за известность
	72690, -- Припасы за известность
	72688, -- Припасы за известность
	71232, -- Известность на Драконьих островах
	71023, -- Известность в союзе Вальдраккена
	70916, -- Известность и слава
	70885, -- Припасы за известность
	70882, -- Припасы за известность
	66511, -- Знаменитость среди искарских клыкарров
	66419, -- Присяга
	66156, -- Известность в Драконьей экспедиции
	66042, -- |A:CampaignAvailableQuestIcon:11:11:0:0|a Закономерности в закономерностях
	65606, -- Знаменитость среди Маруук
	65266, -- |A:Recurringavailablequesticon:14:14:0:0|a Пропавшие исследования
	65143, -- Антрос
	64867, -- Припасы Просветленных
	64531, -- Мор'гет
	64522, -- |A:Recurringavailablequesticon:14:14:0:0|a Украденные кортийские припасы
	64273, -- Сдержать Верных Хелии
	64267, -- Таинственные подарки Ве'нари
	64266, -- Припасы Кодекса архивариуса
	64012, -- Припасы Легиона Смерти
	63949, -- |A:Recurringavailablequesticon:14:14:0:0|a Определяя судьбу
	63543, -- Атака некролордов
	62869, -- |A:Recurringavailablequesticon:14:14:0:0|a Возвращение потерянных душ
	61982, -- |A:Recurringavailablequesticon:14:14:0:0|a Наполнение резервуара
	61981, -- |A:Recurringavailablequesticon:14:14:0:0|a Наполнение резервуара
	61816, -- Мортанис
	61100, -- Припасы Двора Жнецов
	61098, -- Припасы Дикой Охоты
	61097, -- Припасы перерожденных
	61095, -- Припасы Неумирающей армии
	60775, -- |A:Recurringavailablequesticon:14:14:0:0|a Достойная участь
	60256, -- |A:questlog-questtypeicon-dungeon:14:14:0:0|a Ценная находка: Чертоги Покаяния
	60244, -- |A:questlog-questtypeicon-dungeon:14:14:0:0|a Обмен услугами: Чертоги Покаяния
	58097, -- Припасы от Ульдумского союза
	58096, -- Припасы от клана Раджани
	55976, -- Припасы Клинков Волн
	55348, -- Припасы от Ржавоболтского сопротивления
	54462, -- Благодарность империи Зандалари
	54461, -- Благодарность жителей Вол'дуна
	54460, -- Благодарность экспедиции Таланджи
	54458, -- Благодарность адмиралтейства Праудмуров
	54457, -- Благодарность ордена Возрождения Шторма
	54456, -- Благодарность ордена Пылающих Углей
	54455, -- Благодарность Армии Чести
	54454, -- Благодарность 7-го легиона
	54453, -- Благодарность Магни
	54451, -- Благодарность тортолланских искателей
	53982, -- Припасы от Освобожденных
	49015, -- |A:questlog-questtypeicon-raid:14:14:0:0|a Анторус, Пылающий Трон: смерть титана
	48977, -- Припасы от Армии Света
	48976, -- Припасы от Защитников Аргуса
	47148, -- |A:Recurringavailablequesticon:14:14:0:0|a Кое-что новенькое
	46777, -- Награда Армии погибели Легиона
	46749, -- Припасы Стражей
	46748, -- Припасы помраченных
	46747, -- Припасы Ткачей Снов
	46746, -- Припасы валарьяров
	46745, -- Припасы от Двора Фарондиса
	46743, -- Припасы из Крутогорья
	46666, -- Золотая жила
	46246, -- Уничтожить всех
	43533, -- |A:questlog-storylineicon:14:14:0:0|a Баланс сил
	40168, -- |A:Recurringavailablequesticon:14:14:0:0|a Бурлящий фиал
	39246, -- Владычество над морями
	38242, -- Раскопанная магия
	36614, -- Моя собственная крепость
	36567, -- Лучше больше, да лучше
	24757, -- |A:questlog-questtypeicon-raid:14:14:0:0|a Сила льда
	24756, -- |A:questlog-questtypeicon-raid:14:14:0:0|a Сила крови
	24749, -- |A:questlog-questtypeicon-raid:14:14:0:0|a Сила нечестивости
	24748, -- |A:questlog-questtypeicon-raid:14:14:0:0|a Последняя битва Короля-лича
	24743, -- |A:legendaryavailablequesticon:14:14:0:0|a Грань Тьмы
	24549, -- |A:questlog-questtypeicon-raid:14:14:0:0|a Темная Скорбь...
	24548, -- |A:questlog-questtypeicon-raid:14:14:0:0|a Расколотый трон
	24547, -- |A:questlog-questtypeicon-raid:14:14:0:0|a Пиршество душ
	24545, -- |A:questlog-questtypeicon-raid:14:14:0:0|a Святость и скверна
	14062, -- |A:Recurringavailablequesticon:14:14:0:0|a Не забыть про запеканку!
	14061, -- |A:Recurringavailablequesticon:14:14:0:0|a Слишком мало индеек
	14060, -- |A:Recurringavailablequesticon:14:14:0:0|a Проще пареной тыквы
	14059, -- |A:Recurringavailablequesticon:14:14:0:0|a У нас опять кончился соус?
	14058, -- |A:Recurringavailablequesticon:14:14:0:0|a Батат – значит, батат!
	14055, -- |A:Recurringavailablequesticon:14:14:0:0|a Батат – значит, батат!
	14054, -- |A:Recurringavailablequesticon:14:14:0:0|a Проще пареной тыквы
	14053, -- |A:Recurringavailablequesticon:14:14:0:0|a У нас опять кончился соус?
	14051, -- |A:Recurringavailablequesticon:14:14:0:0|a Не забыть про запеканку!
	14048, -- |A:Recurringavailablequesticon:14:14:0:0|a Слишком мало индеек
	8803, -- Подарок в разноцветной упаковке
	8769, -- Тикающий подарок
	8768, -- Подарок в яркой упаковке
	8744, -- Тщательно упакованный подарок
	7043, -- |A:Recurringavailablequesticon:14:14:0:0|a Прохладное чувство юмора
	6983, -- |A:Recurringavailablequesticon:14:14:0:0|a Прохладное чувство юмора
	--72282, -- notitle
	--72692, -- notitle
	--72696, -- notitle
	--72671, -- notitle
	--72673, -- notitle
	--72691, -- notitle
	--72694, -- notitle
	--72284, -- notitle
	--72697, -- notitle
	--72695, -- notitle
	--72682, -- notitle
	--72685, -- notitle
	--72669, -- notitle
	--72672, -- notitle
	--72687, -- notitle
	--72698, -- notitle
	--72689, -- notitle
	--72701, -- notitle
	--72283, -- notitle
	--72702, -- notitle
	--72704, -- notitle
	--72703, -- notitle
	--84446, -- notitle
	--7045, -- notitle
	--6984, -- notitle
	--76318, -- notitle
	--76319, -- notitle
	--76320, -- notitle
	--76321, -- notitle
	--76322, -- notitle
	--76323, -- notitle
	--76324, -- notitle
	--76325, -- notitle
	--76326, -- notitle
	--76327, -- notitle
	--76328, -- notitle
	--76329, -- notitle
	--76330, -- notitle
	--76331, -- notitle
	--76332, -- notitle
	--76333, -- notitle
	--76334, -- notitle
	--76335, -- notitle
	--76336, -- notitle
	--76337, -- notitle
	--76342, -- notitle
	--76343, -- notitle
	--76344, -- notitle
	--76345, -- notitle
	--76347, -- notitle
	--76348, -- notitle
	--76384, -- notitle
	--76385, -- notitle
	--76386, -- notitle
	--76387, -- notitle
	--76388, -- notitle
	--76389, -- notitle
	--76398, -- notitle
	--76401, -- notitle
	--76402, -- notitle
	--76403, -- notitle
	--76416, -- notitle
	--76433, -- notitle
	--76434, -- notitle
	--76435, -- notitle
	--76436, -- notitle
	--76437, -- notitle
	--76441, -- notitle
	--76442, -- notitle
	--76443, -- notitle
	--76532, -- notitle
	--76982, -- notitle
	--77178, -- notitle
	--77283, -- notitle
	--77436, -- notitle
	--77570, -- notitle
	--77818, -- notitle
	--77846, -- notitle
	--77855, -- notitle
	--77856, -- notitle
	--77857, -- notitle
	--77858, -- notitle
	--77859, -- notitle
	--77860, -- notitle
	--77862, -- notitle
	--77863, -- notitle
	--77864, -- notitle
	--77867, -- notitle
	--77872, -- notitle
	--77890, -- notitle
	--77940, -- notitle
	--77941, -- notitle
	--77942, -- notitle
	--77943, -- notitle
	--77944, -- notitle
	--77950, -- notitle
	--77989, -- notitle
	--77990, -- notitle
	--77994, -- notitle
	--78005, -- notitle
	--78006, -- notitle
	--78039, -- notitle
	--78095, -- notitle
	--78107, -- notitle
	--78120, -- notitle
	--78210, -- notitle
	--78211, -- notitle
	--78212, -- notitle
	--78213, -- notitle
	--78214, -- notitle
	--78263, -- notitle
	--78359, -- notitle
	--78360, -- notitle
	--78361, -- notitle
	--78367, -- notitle
	--78368, -- notitle
	--78547, -- notitle
	--78550, -- notitle
	--78551, -- notitle
	--78552, -- notitle
	--78646, -- notitle
	--78831, -- notitle
	--78833, -- notitle
	--78834, -- notitle
	--78835, -- notitle
	--78911, -- notitle
	--13183, -- notitle
	--32295, -- notitle
	--32307, -- notitle
	--32309, -- notitle
	--32310, -- notitle
	--32317, -- notitle
	--32324, -- notitle
	--32325, -- notitle
	--34378, -- notitle
	--40173, -- notitle
	--40786, -- notitle
	--40787, -- notitle
	--45563, -- notitle
	--55498, -- notitle
	--55499, -- notitle
	--55509, -- notitle
	--55511, -- notitle
	--56337, -- notitle
	--56339, -- notitle
	--60242, -- notitle
	--60243, -- notitle
	--60245, -- notitle
	--60246, -- notitle
	--60247, -- notitle
	--60248, -- notitle
	--60249, -- notitle
	--60250, -- notitle
	--60251, -- notitle
	--60252, -- notitle
	--60253, -- notitle
	--60254, -- notitle
	--60255, -- notitle
	--60257, -- notitle
	--60646, -- notitle
	--60762, -- notitle
	--61075, -- notitle
	--61079, -- notitle
	--61088, -- notitle
	--61103, -- notitle
	--61104, -- notitle
	--61765, -- notitle
	--61813, -- notitle
	--61814, -- notitle
	--61815, -- notitle
	--61983, -- notitle
	--61984, -- notitle
	--62214, -- notitle
	--62234, -- notitle
	--62284, -- notitle
	--62285, -- notitle
	--62286, -- notitle
	--62287, -- notitle
	--62288, -- notitle
	--62631, -- notitle
	--62632, -- notitle
	--62633, -- notitle
	--62634, -- notitle
	--62635, -- notitle
	--62636, -- notitle
	--62637, -- notitle
	--62638, -- notitle
	--62639, -- notitle
	--62640, -- notitle
	--62858, -- notitle
	--62859, -- notitle
	--62860, -- notitle
	--62861, -- notitle
	--62862, -- notitle
	--62863, -- notitle
	--62864, -- notitle
	--62865, -- notitle
	--62866, -- notitle
	--62867, -- notitle
	--62868, -- notitle
	--63815, -- notitle
	--63816, -- notitle
	--63817, -- notitle
	--63818, -- notitle
	--63822, -- notitle
	--63823, -- notitle
	--63824, -- notitle
	--63825, -- notitle
	--63826, -- notitle
	--63830, -- notitle
	--63993, -- notitle
	--63995, -- notitle
	--63996, -- notitle
	--63997, -- notitle
	--63998, -- notitle
	--63999, -- notitle
	--64021, -- notitle
	--64027, -- notitle
	--64044, -- notitle
	--64045, -- notitle
	--64055, -- notitle
	--64056, -- notitle
	--64057, -- notitle
	--64058, -- notitle
	--64059, -- notitle
	--64060, -- notitle
	--64061, -- notitle
	--64152, -- notitle
	--64209, -- notitle
	--64232, -- notitle
	--64233, -- notitle
	--64243, -- notitle
	--64245, -- notitle
	--64246, -- notitle
	--64247, -- notitle
	--64251, -- notitle
	--64256, -- notitle
	--64257, -- notitle
	--64258, -- notitle
	--64263, -- notitle
	--64265, -- notitle
	--64269, -- notitle
	--64270, -- notitle
	--64272, -- notitle
	--64276, -- notitle
	--64278, -- notitle
	--64283, -- notitle
	--64284, -- notitle
	--64285, -- notitle
	--64291, -- notitle
	--64300, -- notitle
	--64303, -- notitle
	--64307, -- notitle
	--64313, -- notitle
	--64316, -- notitle
	--64317, -- notitle
	--64318, -- notitle
	--64320, -- notitle
	--64338, -- notitle
	--64339, -- notitle
	--64341, -- notitle
	--64342, -- notitle
	--64343, -- notitle
	--64344, -- notitle
	--64347, -- notitle
	--64348, -- notitle
	--64349, -- notitle
	--64351, -- notitle
	--64354, -- notitle
	--64355, -- notitle
	--64356, -- notitle
	--64357, -- notitle
	--64358, -- notitle
	--64359, -- notitle
	--64360, -- notitle
	--64361, -- notitle
	--64362, -- notitle
	--64363, -- notitle
	--64364, -- notitle
	--64366, -- notitle
	--64367, -- notitle
	--64428, -- notitle
	--64433, -- notitle
	--64434, -- notitle
	--64435, -- notitle
	--64436, -- notitle
	--64439, -- notitle
	--64440, -- notitle
	--64442, -- notitle
	--64455, -- notitle
	--64456, -- notitle
	--64457, -- notitle
	--64470, -- notitle
	--64471, -- notitle
	--64472, -- notitle
	--64564, -- notitle
	--64565, -- notitle
	--64575, -- notitle
	--64709, -- notitle
	--64710, -- notitle
	--64747, -- notitle
	--64748, -- notitle
	--64749, -- notitle
	--64750, -- notitle
	--64751, -- notitle
	--64752, -- notitle
	--64753, -- notitle
	--64754, -- notitle
	--64755, -- notitle
	--64756, -- notitle
	--64757, -- notitle
	--64828, -- notitle
	--65282, -- notitle
	--66133, -- notitle
	--66860, -- notitle
	--66861, -- notitle
	--66862, -- notitle
	--66863, -- notitle
	--66864, -- notitle
	--66865, -- notitle
	--66866, -- notitle
	--66867, -- notitle
	--66868, -- notitle
	--66870, -- notitle
	--66871, -- notitle
	--66873, -- notitle
	--66874, -- notitle
	--66875, -- notitle
	--71026, -- notitle
	--72166, -- notitle
	--72167, -- notitle
	--72168, -- notitle
	--72169, -- notitle
	--72170, -- notitle
	--72171, -- notitle
	--72646, -- notitle
	--72647, -- notitle
	--72648, -- notitle
	--72649, -- notitle
	--72719, -- notitle
	--72720, -- notitle
	--72721, -- notitle
	--72722, -- notitle
	--72723, -- notitle
	--72724, -- notitle
	--72725, -- notitle
	--72726, -- notitle
	--72727, -- notitle
	--72728, -- notitle
	--72810, -- notitle
	--73180, -- notitle
	--73182, -- notitle
	--73928, -- notitle
	--73936, -- notitle
	--74352, -- notitle
	--74569, -- notitle
	--74570, -- notitle
	--74771, -- notitle
	--74843, -- notitle
	--74844, -- notitle
	--74845, -- notitle
	--74871, -- notitle
	--75156, -- notitle
	--75222, -- notitle
	--75234, -- notitle
	--75370, -- notitle
	--75390, -- notitle
	--75393, -- notitle
	--75397, -- notitle
	--75441, -- notitle
	--75450, -- notitle
	--75451, -- notitle
	--75454, -- notitle
	--75455, -- notitle
	--75461, -- notitle
	--75471, -- notitle
	--75478, -- notitle
	--75494, -- notitle
	--75497, -- notitle
	--75506, -- notitle
	--75516, -- notitle
	--75517, -- notitle
	--75611, -- notitle
	--75612, -- notitle
	--75619, -- notitle
	--75620, -- notitle
	--75621, -- notitle
	--75624, -- notitle
	--75627, -- notitle
	--75628, -- notitle
	--75629, -- notitle
	--75630, -- notitle
	--75664, -- notitle
	--75705, -- notitle
	--75996, -- notitle
	--76014, -- notitle
	--76015, -- notitle
	--76016, -- notitle
	--76027, -- notitle
	--76081, -- notitle
	--76084, -- notitle
	--76122, -- notitle
	--76521, -- notitle
	--76544, -- notitle
	--76548, -- notitle
	--77780, -- notitle
	--76276, -- notitle
	--77329, -- notitle
	--77200, -- notitle
	--77201, -- notitle
	--76280, -- notitle
	--76281, -- notitle
	--77781, -- notitle
	--76282, -- notitle
	--76283, -- notitle
	--83443, -- notitle
	--83457, -- notitle
	--83458, -- notitle
	--83460, -- notitle
	--83366, -- notitle
	--83280, -- notitle
	--83281, -- notitle
	--82582, -- notitle
	--82708, -- notitle
	--84127, -- notitle
	--84128, -- notitle
	--84129, -- notitle
	--84130, -- notitle
	--84131, -- notitle
	--84132, -- notitle
	--84133, -- notitle
	--84084, -- notitle
	--84085, -- notitle
	--84086, -- notitle
	--82965, -- notitle
	--82958, -- notitle
	--82916, -- notitle
	--82962, -- notitle
	--82970, -- notitle
	--83105, -- notitle
	--83106, -- notitle
	--83104, -- notitle
	--83103, -- notitle
	--83102, -- notitle
	--83098, -- notitle
	--82993, -- notitle
	--82992, -- notitle
	--83100, -- notitle
	--83097, -- notitle
	--82778, -- notitle
	--83529, -- notitle
	--83530, -- notitle
	--83531, -- notitle
	--83532, -- notitle
	--80671, -- notitle
	--80672, -- notitle
	--84737, -- notitle
	--84736, -- notitle
	--82050, -- notitle
	--83240, -- notitle
	--82291, -- notitle
	--78715, -- notitle
	--78716, -- notitle
	--80500, -- notitle
	--82540, -- notitle
	--83543, -- notitle
	--78529, -- notitle
	--78530, -- notitle
	--78531, -- notitle
	--78532, -- notitle
	--80334, -- notitle
	--78533, -- notitle
	--78534, -- notitle
	--78535, -- notitle
	--78536, -- notitle
	--83548, -- notitle
	--78460, -- notitle
	--78457, -- notitle
	--78459, -- notitle
	--78461, -- notitle
	--78464, -- notitle
	--79553, -- notitle
	--78463, -- notitle
	--78462, -- notitle
	--78470, -- notitle
	--79701, -- notitle
	--79721, -- notitle
	--78471, -- notitle
	--78538, -- notitle
	--80022, -- notitle
	--78539, -- notitle
	--78540, -- notitle
	--78541, -- notitle
	--78542, -- notitle
	--78543, -- notitle
	--78544, -- notitle
	--78545, -- notitle
	--78546, -- notitle
	--78555, -- notitle
	--78557, -- notitle
	--78837, -- notitle
	--78838, -- notitle
	--78839, -- notitle
	--78634, -- notitle
	--78635, -- notitle
	--78637, -- notitle
	--78638, -- notitle
	--78636, -- notitle
	--78640, -- notitle
	--78639, -- notitle
	--79205, -- notitle
	--78641, -- notitle
	--79267, -- notitle
	--78642, -- notitle
	--80082, -- notitle
	--83550, -- notitle
	--80079, -- notitle
	--78685, -- notitle
	--78696, -- notitle
	--78697, -- notitle
	--78700, -- notitle
	--78701, -- notitle
	--78703, -- notitle
	--78704, -- notitle
	--78705, -- notitle
	--78706, -- notitle
	--78738, -- notitle
	--78741, -- notitle
	--78742, -- notitle
	--81798, -- notitle
	--78760, -- notitle
	--78761, -- notitle
	--79354, -- notitle
	--81689, -- notitle
	--78658, -- notitle
	--78659, -- notitle
	--78665, -- notitle
	--79999, -- notitle
	--78666, -- notitle
	--78667, -- notitle
	--78668, -- notitle
	--78669, -- notitle
	--78670, -- notitle
	--82836, -- notitle
	--78671, -- notitle
	--83551, -- notitle
	--78672, -- notitle
	--78929, -- notitle
	--78932, -- notitle
	--78934, -- notitle
	--78936, -- notitle
	--78937, -- notitle
	--78939, -- notitle
	--78951, -- notitle
	--78952, -- notitle
	--81690, -- notitle
	--78954, -- notitle
	--78630, -- notitle
	--78613, -- notitle
	--79297, -- notitle
	--78626, -- notitle
	--78614, -- notitle
	--78615, -- notitle
	--78620, -- notitle
	--78621, -- notitle
	--78624, -- notitle
	--80049, -- notitle
	--79089, -- notitle
	--78627, -- notitle
	--78628, -- notitle
	--78629, -- notitle
	--78384, -- notitle
	--78350, -- notitle
	--78348, -- notitle
	--78352, -- notitle
	--78353, -- notitle
	--79139, -- notitle
	--78354, -- notitle
	--78392, -- notitle
	--78393, -- notitle
	--83552, -- notitle
	--78233, -- notitle
	--80399, -- notitle
	--78236, -- notitle
	--78234, -- notitle
	--78383, -- notitle
	--78237, -- notitle
	--79625, -- notitle
	--79175, -- notitle
	--78249, -- notitle
	--78250, -- notitle
	--78251, -- notitle
	--78254, -- notitle
	--78255, -- notitle
	--78256, -- notitle
	--78226, -- notitle
	--78228, -- notitle
	--78231, -- notitle
	--78232, -- notitle
	--78244, -- notitle
	--78248, -- notitle
	--84022, -- notitle
	--84365, -- notitle
	--79197, -- notitle
	--79333, -- notitle
	--82153, -- notitle
	--83271, -- notitle
	--83286, -- notitle
	--83315, -- notitle
	--79344, -- notitle
	--79328, -- notitle
	--79224, -- notitle
	--79227, -- notitle
	--79230, -- notitle
	--79233, -- notitle
	--79237, -- notitle
	--79239, -- notitle
	--79240, -- notitle
	--79241, -- notitle
	--79243, -- notitle
	--79244, -- notitle
	--79107, -- notitle
	--81914, -- notitle
	--79124, -- notitle
	--79475, -- notitle
	--79476, -- notitle
	--79129, -- notitle
	--79146, -- notitle
	--79140, -- notitle
	--79145, -- notitle
	--81915, -- notitle
	--79477, -- notitle
	--79147, -- notitle
	--81912, -- notitle
	--81913, -- notitle
	--79480, -- notitle
	--79156, -- notitle
	--79157, -- notitle
	--79022, -- notitle
	--79023, -- notitle
	--79024, -- notitle
	--79217, -- notitle
	--79025, -- notitle
	--79324, -- notitle
	--79026, -- notitle
	--79027, -- notitle
	--79325, -- notitle
	--79028, -- notitle
	--80145, -- notitle
	--80517, -- notitle
	--79029, -- notitle
	--79030, -- notitle
	--78941, -- notitle
	--79728, -- notitle
	--78294, -- notitle
	--82768, -- notitle
	--79703, -- notitle
	--78759, -- notitle
	--79342, -- notitle
	--78574, -- notitle
	--83087, -- notitle
	--82801, -- notitle
	--78999, -- notitle
	--83181, -- notitle
	--79282, -- notitle
	--82895, -- notitle
	--79525, -- notitle
	--79546, -- notitle
	--82814, -- notitle
	--81559, -- notitle
	--79565, -- notitle
	--82144, -- notitle
	--79682, -- notitle
	--79266, -- notitle
	--79510, -- notitle
	--81713, -- notitle
	--80516, -- notitle
	--80407, -- notitle
	--81672, -- notitle
	--83162, -- notitle
	--78564, -- notitle
	--79371, -- notitle
	--79944, -- notitle
	--79303, -- notitle
	--80382, -- notitle
	--80179, -- notitle
	--82480, -- notitle
	--78695, -- notitle
	--79168, -- notitle
	--79650, -- notitle
	--82284, -- notitle
	--80316, -- notitle
	--79110, -- notitle
	--79160, -- notitle
	--79222, -- notitle
	--80678, -- notitle
	--83322, -- notitle
	--79154, -- notitle
	--83247, -- notitle
	--79313, -- notitle
	--82848, -- notitle
	--81685, -- notitle
	--79541, -- notitle
	--80572, -- notitle
	--80502, -- notitle
	--79349, -- notitle
	--79715, -- notitle
	--79580, -- notitle
	--83639, -- notitle
	--79357, -- notitle
	--79122, -- notitle
	--83057, -- notitle
	--81963, -- notitle
	--79471, -- notitle
	--79470, -- notitle
	--79469, -- notitle
	--79380, -- notitle
	--79329, -- notitle
	--78657, -- notitle
	--78590, -- notitle
	--76338, -- notitle
	--76600, -- notitle
	--79158, -- notitle
	--79216, -- notitle
	--76997, -- notitle
	--78972, -- notitle
	--88738, -- notitle
	--88739, -- notitle
	--76394, -- notitle
	--78656, -- notitle
	--81632, -- notitle
	--80004, -- notitle
	--80562, -- notitle
	--80186, -- notitle
	--80189, -- notitle
	--81794, -- notitle
	--81795, -- notitle
	--81796, -- notitle
}

E.Octo_Table.OctoTable_QuestID_Paragon = {
	83740, -- Дурная слава у визиря
	83739, -- Дурная слава у генерала
	83738, -- Дурная слава у Прядильщицы
	79220, -- Известность у Ассамблеи глубин
	79219, -- Известность у совета Дорногала
	79218, -- Известность среди Арати Тайносводья
	79196, -- Известность у Отрезанных нитей
	76425, -- Известность у Стражей Сна
	75290, -- Известность среди лоаммских ниффов
	71023, -- Известность в союзе Вальдраккена
	66511, -- Знаменитость среди искарских клыкарров
	66156, -- Известность в Драконьей экспедиции
	65606, -- Знаменитость среди Маруук
	64867, -- Припасы Просветленных
	64267, -- Таинственные подарки Ве'нари
	64266, -- Припасы Кодекса архивариуса
	64012, -- Припасы Легиона Смерти
	61100, -- Припасы Двора Жнецов
	61098, -- Припасы Дикой Охоты
	61097, -- Припасы перерожденных
	61095, -- Припасы Неумирающей армии
	58097, -- Припасы от Ульдумского союза
	58096, -- Припасы от клана Раджани
	55976, -- Припасы Клинков Волн
	55348, -- Припасы от Ржавоболтского сопротивления
	54462, -- Благодарность империи Зандалари
	54461, -- Благодарность жителей Вол'дуна
	54460, -- Благодарность экспедиции Таланджи
	54458, -- Благодарность адмиралтейства Праудмуров
	54457, -- Благодарность ордена Возрождения Шторма
	54456, -- Благодарность ордена Пылающих Углей
	54455, -- Благодарность Армии Чести
	54454, -- Благодарность 7-го легиона
	54453, -- Благодарность Магни
	54451, -- Благодарность тортолланских искателей
	53982, -- Припасы от Освобожденных
	48977, -- Припасы от Армии Света
	48976, -- Припасы от Защитников Аргуса
	46777, -- Награда Армии погибели Легиона
	46749, -- Припасы Стражей
	46748, -- Припасы помраченных
	46747, -- Припасы Ткачей Снов
	46746, -- Припасы валарьяров
	46745, -- Припасы от Двора Фарондиса
	46743, -- Припасы из Крутогорья
}

E.Octo_Table.OctoTable_QuestIDTEST ={
	85947, -- |A:Recurringavailablequesticon:14:14:0:0|a Первозданный путь сквозь время
	83274, -- |A:Recurringavailablequesticon:14:14:0:0|a Первозданный путь сквозь время
}

