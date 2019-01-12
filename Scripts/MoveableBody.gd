extends KinematicBody2D

var current_velocity = Vector2(0.0, 0.0)

func _physics_process(delta):
    if Input.is_action_pressed("ui_left"):
        current_velocity = handle_left(delta)
    elif Input.is_action_pressed("ui_right"):
        current_velocity = handle_right(delta)
        
    if Input.is_action_just_released("ui_left"):
        current_velocity = Vector2(0, 0)
    elif Input.is_action_just_released("ui_right"):
        current_velocity = Vector2(0, 0)
        
    if Input.is_action_pressed("ui_up"):
        current_velocity = handle_up(delta)
    elif Input.is_action_pressed("ui_down"):
        current_velocity = handle_down(delta)
            
    move_and_slide(current_velocity)
    
func handle_left(delta):
    pass
    
func handle_right(delta):
    pass
    
func handle_up(delta):
    return current_velocity
    pass
    
func handle_down(delta):
    return current_velocity
    pass