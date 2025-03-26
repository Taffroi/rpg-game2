class_name ItemEffectHeal extends ItemEffect

@export var heal_amount : int = 1
@export var audio : AudioStream

func use() -> void:
	GlobalPlayerManager.player.update_hp(heal_amount)
	InventoryMenu.play_audio(audio)
