extends Node2D

signal activated(action)

export (String) var InputAction
export (float) var MinChargeTime
export (float) var MaxChargeTime

var index
var current_charge_time = 0.0

func set_index(value):
    index = value

func _physics_process(delta):
    if Input.is_action_pressed(InputAction) and index == get_parent().get_current_index():
        current_charge_time += delta
        
    if Input.is_action_just_released(InputAction) and index == get_parent().get_current_index():
        print("Action: " + InputAction)        
        print("Charged for: " + str(current_charge_time))
        if current_charge_time <= MaxChargeTime and current_charge_time >= MinChargeTime:        
            emit_signal("activated", self)
            current_charge_time = 0.0
        else:
            current_charge_time = 0.0