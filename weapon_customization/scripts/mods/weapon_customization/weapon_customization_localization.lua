local mod = get_mod("weapon_customization")

mod:add_global_localize_strings({
	loc_weapon_cosmetics_customization = {
		en = "Customization",
		de = "Anpassung",
		ru = "Настройка",
		["zh-cn"] = "自定义",
	},
	loc_weapon_special_laser_pointer = {
		en = "Laser Pointer",
		de = "Laserpointer",
	},
	loc_stats_special_action_laser_pointer_desc = {
		en = "Turn on or off the weapon mounted laser pointer.\nAlso functions as a torch. Useful in dark areas.",
		-- de = "Schalte die Turn on or off the weapon mounted laser pointer.\nAlso functions as a torch. Useful in dark areas."
	}
})

return {
	mod_title = {
		en = "Extended Weapon Customization",
		de = "Erweiterte Waffenanpassung",
		ru = "Расширенная настройка оружия",
		["zh-cn"] = "武器自定义扩展",
	},
	mod_description = {
		en = "Extends weapon customizations",
		de = "Erweitert Waffenanpassungen",
		ru = "Extended Weapon Customization – значительно расширяет возможности настройки внешнего вида оружия.",
		["zh-cn"] = "武器自定义扩展",
	},
	group_debug = {
		en = "Debug",
		de = "Debug",
		ru = "Отладка",
		["zh-cn"] = "调试",
	},
	mod_option_debug = {
		en = "Debug",
		de = "Debug",
		ru = "Отладка",
		["zh-cn"] = "调试",
	},
	group_weapon_animation = {
		en = "Weapon Animations",
		de = "Waffen Animationen",
		ru = "Анимации оружия",
		["zh-cn"] = "武器动画",
	},
	mod_option_weapon_build_animation = {
		en = "Play Animations",
		de = "Animationen Abspielen",
	},
	mod_option_weapon_build_animation_speed = {
		en = "Speed",
		de = "Geschwindigkeit",
		ru = "Скорость",
		["zh-cn"] = "速度",
	},
	mod_option_weapon_build_animation_wobble = {
		en = "Wobble",
		de = "Wackeln",
		ru = "Покачивание",
	},
	mod_option_weapon_build_animation_speed_unit = {
		en = "Seconds",
		de = "Sekunden",
		ru = "Секунды",
		["zh-cn"] = "秒",
	},
	group_flashlight = {
		en = "Flashlight",
		de = "Taschenlampe",
	},
	mod_option_flashlight_shadows = {
		en = "Flashlight Shadows",
		de = "Taschenlampenschatten",
		ru = "Тень от фонарика",
		["zh-cn"] = "手电筒阴影",
	},
	mod_option_flashlight_flicker = {
		en = "Flashlight Flicker",
		de = "Taschenlampenflimmern",
		ru = "Мерцание света фонарика",
		["zh-cn"] = "手电筒闪烁",
	},
	mod_option_flashlight_flicker_start = {
		en = "Flicker on Activate",
		de = "Filmmern beim Einschalten",
		ru = "Мерцание при включении",
		["zh-cn"] = "开启时闪烁",
	},
	group_laser_pointer = {
		en = "Laser Pointer",
		de = "Laserpointer",
	},
	mod_option_deactivate_crosshair = {
		en = "Deactivate Crosshair",
		de = "Zielkreuz Deaktivieren",
	},
	mod_option_laser_pointer_dot_size = {
		en = "Dot Size",
		de = "Punktgröße",
	},
	mod_option_laser_pointer_wild = {
		en = "Wild Flickering",
		de = "Flimmert Wild",
	},
	mod_option_camera_zoom = {
		en = "Camera Zoom",
		de = "Kamera Zoom",
	},
	loc_weapon_inventory_reset_button = {
		en = "Reset All",
		de = "Alles Zurücksetzen",
		ru = "Сбросить всё",
		["zh-cn"] = "重置所有",
	},
	loc_weapon_inventory_no_reset_button = {
		en = "No Changes",
		de = "Keine Änderungen",
		ru = "Без изменений",
		["zh-cn"] = "无更改",
	},
	loc_weapon_inventory_randomize_button = {
		en = "Randomize",
		de = "Zufällig",
		ru = "Случайно",
		["zh-cn"] = "随机",
	},
	loc_weapon_inventory_demo_button = {
		en = "Demo",
		de = "Demo",
		ru = "Демонстрация",
		["zh-cn"] = "演示",
	},
	loc_weapon_cosmetics_customization_flashlight = {
		en = "Special",
		de = "Spezial",
		ru = "Специальный",
		["zh-cn"] = "特殊",
	},
	loc_weapon_cosmetics_customization_barrel = {
		en = "Barrel",
		de = "Lauf",
		ru = "Ствол",
		["zh-cn"] = "枪管",
	},
	loc_weapon_cosmetics_customization_underbarrel = {
		en = "Underbarrel",
		de = "Unterlauf",
		ru = "Подствольник",
		["zh-cn"] = "枪管下挂",
	},
	loc_weapon_cosmetics_customization_muzzle = {
		en = "Muzzle",
		de = "Mündung",
		ru = "Дуло",
		["zh-cn"] = "枪口",
	},
	loc_weapon_cosmetics_customization_receiver = {
		en = "Receiver",
		de = "Gehäuse",
		ru = "Ствольная коробка",
		["zh-cn"] = "机匣",
	},
	loc_weapon_cosmetics_customization_magazine = {
		en = "Magazine",
		de = "Magazin",
		ru = "Магазин",
		["zh-cn"] = "弹匣",
	},
	loc_weapon_cosmetics_customization_grip = {
		en = "Grip",
		de = "Griff",
		ru = "Рукоять",
		["zh-cn"] = "握把",
	},
	loc_weapon_cosmetics_customization_bayonet = {
		en = "Bayonet",
		de = "Bajonett",
		ru = "Штык",
		["zh-cn"] = "刺刀",
	},
	loc_weapon_cosmetics_customization_handle = {
		en = "Handle",
		de = "Handgriff",
		ru = "Ручка",
		["zh-cn"] = "握柄",
	},
	loc_weapon_cosmetics_customization_stock = {
		en = "Stock",
		de = "Schaft",
		ru = "Приклад",
		["zh-cn"] = "枪托",
	},
	loc_weapon_cosmetics_customization_ventilation = {
		en = "Ventilation",
		de = "Ventilation",
		ru = "Охлаждение",
		["zh-cn"] = "通气孔",
	},
	loc_weapon_cosmetics_customization_stock_2 = {
		en = "Stock",
		de = "Schaft",
		ru = "Приклад",
		["zh-cn"] = "枪托",
	},
	loc_weapon_cosmetics_customization_stock_3 = {
		en = "Stock",
		de = "Schaft",
		ru = "Приклад",
		["zh-cn"] = "枪托",
	},
	loc_weapon_cosmetics_customization_sight = {
		en = "Sight",
		de = "Visier",
		ru = "Прицел",
		["zh-cn"] = "瞄具",
	},
	loc_weapon_cosmetics_customization_sight_2 = {
		en = "Sight",
		de = "Visier",
		ru = "Прицел",
		["zh-cn"] = "瞄具",
	},
	loc_weapon_cosmetics_customization_body = {
		en = "Body",
		de = "Aufbau",
		ru = "Основа",
		["zh-cn"] = "主体",
	},
	loc_weapon_cosmetics_customization_rail = {
		en = "Rail",
		de = "Schiene",
		ru = "Рельса",
		["zh-cn"] = "导轨",
	},
	loc_weapon_cosmetics_customization_pommel = {
		en = "Pommel",
		de = "Knauf",
		ru = "Навершие",
		["zh-cn"] = "柄头",
	},
	loc_weapon_cosmetics_customization_hilt = {
		en = "Hilt",
		de = "Heft",
		ru = "Эфес",
		["zh-cn"] = "握柄",
	},
	loc_weapon_cosmetics_customization_head = {
		en = "Head",
		de = "Kopf",
		ru = "Оголовье",
		["zh-cn"] = "头部",
	},
	loc_weapon_cosmetics_customization_blade = {
		en = "Blade",
		de = "Klinge",
		ru = "Клинок",
		["zh-cn"] = "刃部",
	},
	loc_weapon_cosmetics_customization_teeth = {
		en = "Teeth",
		de = "Zähne",
		ru = "Зубья",
		["zh-cn"] = "锯齿",
	},
	loc_weapon_cosmetics_customization_chain = {
		en = "Chain",
		de = "Kette",
		ru = "Цепь",
		["zh-cn"] = "链条",
	},
	loc_weapon_cosmetics_customization_shaft = {
		en = "Shaft",
		de = "Schaft",
		ru = "Рукоять",
		["zh-cn"] = "杆部",
	},
	loc_weapon_cosmetics_customization_connector = {
		en = "Connector",
		de = "Verbindung",
		ru = "Соединитель",
		["zh-cn"] = "接头",
	},
	loc_weapon_cosmetics_customization_left = {
		en = "Shield",
		de = "Schild",
		ru = "Щит",
		["zh-cn"] = "盾牌",
	},
	loc_weapon_cosmetics_customization_emblem_right = {
		en = "Emblem Right",
		de = "Wappen Rechts",
		ru = "Эмблема правая",
		["zh-cn"] = "右侧装饰",
	},
	loc_weapon_cosmetics_customization_emblem_left = {
		en = "Emblem Left",
		de = "Wappen Links",
		ru = "Эмблема левая",
		["zh-cn"] = "左侧装饰",
	},
	loc_weapon_cosmetics_customization_shaft_lower = {
		en = "Lower Shaft",
		de = "Unterer Schaft",
		ru = "Нижняя часть рукояти",
		["zh-cn"] = "杆底",
	},
	loc_weapon_cosmetics_customization_shaft_upper = {
		en = "Upper Shaft",
		de = "Oberer Schaft",
		ru = "Верхняя часть рукояти",
		["zh-cn"] = "杆顶",
	},
	loc_weapon_cosmetics_customization_trinket_hook = {
		en = "Trinket Hook",
		de = "Trinket Haken",
		ru = "Кольцо для брелка",
		["zh-cn"] = "饰品钩",
	},
}
