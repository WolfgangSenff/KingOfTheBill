extends Node2D

signal activated(action)

export (String) var InputAction

var index

func set_index(value):
    index = value

func _physics_process(delta):
    if Input.is_action_just_pressed(InputAction) and index == get_parent().get_current_index():
        print("Action: " + InputAction)
        emit_signal("activated", self)