extends Node


var __screenshot_count = 0

var __is_debug_mode = false

# Lifecycle methods
func _ready() -> void:
	if !OS.is_debug_build():
		self.call_deferred("queue_free")

	self.pause_mode = Node.PAUSE_MODE_PROCESS


func _process(delta: float) -> void:
	if Input.is_key_pressed(KEY_A) && Input.is_key_pressed(KEY_B):
		self.__screenshot()

# Put this into _input to prevent key from being registered multiple times because delta is super fast
func _input(event: InputEvent) -> void:
	if Input.is_key_pressed(KEY_F1):
		if !__is_debug_mode:
			self.__show_debug_info()
		__is_debug_mode = !__is_debug_mode

# Private methods
func __screenshot():
	var capture: Image = self.get_viewport().get_texture().get_data()
	capture.flip_y()
	capture.save_png("user://screenshot_%d.png" % self.__screenshot_count)
	self.__screenshot_count += 1
	OS.shell_open(OS.get_user_data_dir())

func __show_debug_info():
	Logger.info("Debug info showing.")
	# TODO: Add cursor position, FPS, CPU, RAM, GPU utilisation
