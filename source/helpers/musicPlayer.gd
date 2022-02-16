extends AudioStreamPlayer

var audio_path: String

var audio: AudioStream

var choice: String

func _enter_tree() -> void:
	audio = load(audio_path)
	self.stream = audio
	self.play()


func _on_musicPlayer_finished() -> void:
	var audio_dict = {"bus": "music", "choice": choice, "loop": true}
	Event.emit_signal("emit_audio", audio_dict)
