extends Node


signal setting_changed(name, value)

const SETTINGS_PATH = "settings.json"
enum COLORBLIND_SETTINGS {NONE, PROTANOPIA, DEUTRANOPIA, TRITANOPIA}

var __settings: Dictionary = {}
var __settings_default: Dictionary = {
	"volume": {
		"Master": 1.0,
		"Music": 1.0,
		"Sound Effects": 1.0
	},
	"input": {},
	"graphics":{
		"Particles": 1.0,
		"Fullscreen": false
	},
	"gameplay":{
		"Colorblind Shader": {
			"Type": 0,
			"Intensity": 1.0
			},
		"CRT Shader": true,
		"Shake Intensity": 1.0
	}
}


# Lifecycle methods
func _ready() -> void:
	self.connect("setting_changed", self, "__setting_changed")
	self.__settings = self.__settings_default

	if FileManager.file_exists(self.SETTINGS_PATH):
		self.__settings = FileManager.load_json(self.SETTINGS_PATH)
		merge_settings(__settings, __settings_default)
		Logger.info("Loading settings")
	else:
		FileManager.save_json(self.SETTINGS_PATH, self.__settings)
		Logger.info("Creating settings")


func merge_settings(a: Dictionary, b: Dictionary) -> void:
	for key in b:
		if !a.has(key) || typeof(a[key]) != typeof(b[key]):
			a[key] = b[key]
		elif b[key] is Dictionary:  # Lil'Oni should stop writing here and actually do some art stuff.... - Lil'Oni
			merge_settings(a[key], b[key])


# Public methods
func get_setting(name, default = null):
	var path: Array = name.split("/")
	var location: Dictionary = self.__settings

	for index in range(path.size() - 1):
		var part: String = path[index]

		if location.has(part):
			location = location.get(part)
		else:
			Logger.warn("Could not get setting '%s'" % name)
			return default

	var setting_name: String = path[path.size() - 1]
	if location.has(setting_name):
		return location.get(setting_name)
	else:
		Logger.warn("Could not get setting '%s'" % name)
		return default


func save_settings() -> void:
	FileManager.save_json(self.SETTINGS_PATH, self.__settings)


func set_setting(name: String, value, save: bool = false) -> void:
	self.__setting_changed(name, value)
	if save:
		self.save_settings()


# Private methods
func __setting_changed(name: String, value) -> void:
	var path: Array = name.split("/")
	var location: Dictionary = self.__settings

	for index in range(path.size() - 1):
		var part: String = path[index]

		if location.has(part):
			location = location.get(part)
		else:
			Logger.warn("Could not update setting '%s'" % name)
			return

	var setting_name: String = path[path.size() - 1]
	if location.has(setting_name):
		location[setting_name] = value
		Event.emit_signal("setting_changed", [name, value])
	else:
		Logger.warn("Could not update setting '%s'" % name)
		return
