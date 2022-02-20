extends AudioStreamPlayer

var audio_path: String

var audio: AudioStream

func _enter_tree() -> void:
	audio = load(audio_path)
	self.stream = audio
	self.play()


func _on_voicePlayer_finished() -> void:
	self.queue_free()
