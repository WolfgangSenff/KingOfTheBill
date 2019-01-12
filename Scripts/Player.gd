extends "res://Scripts/MoveableBody.gd"

export (float, 1, 100) var left_right_speed

onready var weapon = $Weapon
var moving_right = false

func _ready():
    $MoveController.connect("execute_move", self, "on_move_executed")
    
func on_move_executed(move):
    $AnimationPlayer.play(move.AnimationName)

func handle_left(delta):
    if moving_right:
        moving_right = false
        scale = Vector2(-scale.x, scale.y)
    return Vector2(-1.0, 0) * left_right_speed
    
func handle_right(delta):
    if not moving_right:
        moving_right = true
        scale = Vector2(-scale.x, scale.y)
    return Vector2(1.0, 0) * left_right_speed
    
func handle_up(delta):
    return Vector2(0, 0)
    
func handle_down(delta):
    return Vector2(0, 0)
