extends Node2D

export (String) var Action
export (bool) var Chargeable
export (float, 0.2) var ChargeTime
export (float, 0.2) var ChargeEpsilon
signal begin(action)
signal cancel(action, charged_time)
signal complete(action, charged_time)

var action_executed = false
var current_charge_time = 0.0

func _physics_process(delta):
    if not action_executed and Input.is_action_pressed(Action):
        if Chargeable:
            current_charge_time += delta
            if current_charge_time > ChargeTime:
                emit_signal("cancel", self, current_charge_time)
            
        pass
    pass