extends CanvasLayer

@onready var animation_player: AnimationPlayer = $Control/AnimationPlayer

func _ready() -> void:
	visible = false
	
func fade_out() -> bool:
	visible = true
	animation_player.play("fade_out")
	await animation_player.animation_finished
	return true
	
func fade_in() -> bool:
	animation_player.play("fade_in")
	await animation_player.animation_finished
	visible = false
	return true
