extends Node

var score = 0

@export var level_1scene: PackedScene
@export var level_2scene: PackedScene
@export var level_3scene: PackedScene
@onready var score_label = $CanvasLayer/ScoreLabel
@onready var level_completed = $"../CanvasLayer/LevelCompleted"

func _input(event):
	if Input.is_action_just_pressed("answer"):
		var current_scene_name = get_tree().get_current_scene().get_name()
		
		if current_scene_name == "level1" and score == 4:
			Events.level_completed.emit()
		elif current_scene_name == "level2" and score == 3:
			Events.level_completed.emit()
		elif current_scene_name == "level3" and score == 6:
			Events.level_completed.emit()
		elif current_scene_name == "level4" and score == 7:
			Events.level_completed.emit()

func add_point():
	score += 1
	score_label.text = "Your Answer is: " + str(score)

func _ready():
	Events.level_completed.connect(show_level_completed)
	
func show_level_completed():
	var current_scene_name = get_tree().get_current_scene().get_name()
	level_completed.show()
	get_tree().paused = true
	await get_tree().create_timer(2).timeout
	get_tree().paused = false
	if current_scene_name == "level1":
		get_tree().change_scene_to_file("res://level2.tscn")
	elif current_scene_name == "level2":
		get_tree().change_scene_to_file("res://scenes/level3.tscn")
	elif current_scene_name == "level3":
		get_tree().change_scene_to_file("res://scenes/level4.tscn")	
	elif current_scene_name == "level4":
		get_tree().change_scene_to_file("res://victory_screen.tscn")	

		
