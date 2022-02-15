extends Node

var effect_player = preload("res://source/helpers/soundEffectPlayer.tscn")
var music_player = preload("res://source/helpers/musicPlayer.tscn")

var active_music_players : Array = []

var __volume_max: Dictionary = {
	# key: bus name
	# value: starting volume
}
var __volume_min: float = -40.0


# Lifecylce methods
func _ready() -> void:
	var levels = SettingsManager.get_setting("volume", {})
	for key in levels.keys():
		var index = self.__get_bus_index(key)
		self.__volume_max[key] = AudioServer.get_bus_volume_db(index)
		var value: float = lerp(self.__volume_min, self.__volume_max[key], levels[key])
		AudioServer.set_bus_volume_db(index, value)
	
	Event.connect("emit_audio", self, "play_audio")


# Public methods
func get_volume(name: String) -> float:
	return SettingsManager.get_setting("volume/%s" % name, 1.0)


func get_volume_db(name: String) -> float:
	var volume: float = self.get_volume(name)
	return lerp(self.__volume_min, self.__volume_max[name], volume)


func set_volume(name: String, value: float) -> void:
	var index: int = self.__get_bus_index(name)

	var volume_db: float = -INF
	if value > 0.0:
		volume_db = lerp(self.__volume_min, self.__volume_max[name], value)
	AudioServer.set_bus_volume_db(index, volume_db)

	SettingsManager.set_setting("volume/%s" % name, value, true)


# Private methods
func __get_bus_index(name: String) -> int:
	return AudioServer.get_bus_index(name)

func __play_audio(options: Dictionary) -> void:
	var bus = options["bus"]
	var choice = options["choice"]
	if bus == "music":
		__play_music(choice)
	elif bus == "effect":
		__play_effect(choice)
	else:
		__play_effect("error")

func __play_music(choice: String) -> void:
	pass

func __play_effect(choice: String) -> void:
	pass
