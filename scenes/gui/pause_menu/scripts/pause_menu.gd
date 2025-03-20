extends CanvasLayer

@onready var button_save: Button = $VBoxContainer/Button_Save
@onready var button_load: Button = $VBoxContainer/Button_Load

var is_paused : bool = false

func _ready() -> void:
	hide_pause_menu()
	button_save.pressed.connect(_on_save_pressed) # Si bouton pressé (signal), envoie la fonciton
	button_load.pressed.connect(_on_load_pressed)
	pass
	
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		if is_paused == false:
			show_pause_menu()
		else:
			hide_pause_menu()
		get_viewport().set_input_as_handled()

func show_pause_menu() -> void:
	get_tree().paused = true # met le jeu entier en pause (sauf menu pcq process mode always)
	visible = true
	is_paused = true
	button_save.grab_focus() # met la prio sur le bouton save

func hide_pause_menu() -> void:
	get_tree().paused = false
	visible = false
	is_paused = false
	
func _on_save_pressed() -> void:
	if is_paused == false:
		return
	SaveManager.save_game()
	hide_pause_menu()
	
func _on_load_pressed() -> void:
	if is_paused == false:
		return
	SaveManager.load()
	await LevelManager.level_load_started # Attend que l'écran soit noir pour enlever l'écran
	hide_pause_menu()
