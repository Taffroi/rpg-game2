extends CanvasLayer

signal inventory_gui_shown
signal inventory_gui_hidden

@onready var button_save: Button = $Control/VBoxContainer/Button_Save
@onready var button_load: Button = $Control/VBoxContainer/Button_Load
@onready var inventory: GridContainer = $Control/PanelContainer/GridContainer
@onready var item_description: Label = $Control/ItemDescription
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

var gui_open : bool = false

func _ready() -> void:
	hide_gui()
	button_save.pressed.connect(_on_save_pressed) # Si bouton pressé (signal), envoie la fonciton
	button_load.pressed.connect(_on_load_pressed)
	pass
	
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("inventory"):
		if gui_open == false:
			show_gui()
		else:
			hide_gui()
		get_viewport().set_input_as_handled() # met l'input GUI en priorité ? je crois

func show_gui() -> void:
	pause_game(false)
	visible = true
	gui_open = true
	inventory_gui_shown.emit()

func hide_gui() -> void:
	pause_game(false)
	visible = false
	gui_open = false
	inventory_gui_hidden.emit()
	
func _on_save_pressed() -> void:
	if gui_open == false:
		return
	SaveManager.save_game()
	hide_gui()
	
func _on_load_pressed() -> void:
	if gui_open == false:
		return
	SaveManager.load()
	await LevelManager.level_load_started # Attend que l'écran soit noir pour enlever l'écran
	hide_gui()
	
func pause_game(state : bool) -> void:
	if state == true:
		get_tree().paused = true # met le jeu entier en pause (sauf menu pcq process mode always)
	if state == false:
		get_tree().paused = false
	pass
	
func update_item_description(new_text : String) -> void:
	item_description.text = new_text
	
func play_audio(audio : AudioStream) -> void:
	audio_stream_player.stream = audio
	audio_stream_player.play()
