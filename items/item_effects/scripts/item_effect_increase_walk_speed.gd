class_name ItemEffectIncreaseSpeedWalk extends ItemEffect

@export var factor : float = 0.1
@export var duration : float = 10.0
@export var audio : AudioStream
var use_description : String

func use() -> void:
	GlobalPlayerManager.player.adjust_speed(factor,duration)
	InventoryMenu.play_audio(audio)
