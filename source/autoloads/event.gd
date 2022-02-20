extends Node

signal emit_audio(audio) # send an Dictionary: {"bus": "bus_choice", "choice": "audio_choice", "loop": bool}
signal add_shake(shake_amount)

signal setting_changed(setting_details) # When a setting is changed, this is emitted!
# This way I can have screen space shaders, etc, update on the fly!
signal change_menu(menu_name)
