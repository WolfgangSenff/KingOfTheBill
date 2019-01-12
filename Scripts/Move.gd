extends Node2D

signal execute(move, use_tween)
signal cancel(move)

export (String) var MoveName
export (String) var AnimationName
export (float, 0.2, 10) var TimeSpan
export (bool) var UseTween

var tracking_actions = false
var all_actions = []
var move_definition = []
var current_time_count = 0.0

func _ready():
    var index = 0
    for child in get_children():
        child.connect("activated", self, "on_action_activated")
        child.set_index(index)
        move_definition.append(child.InputAction)
        index += 1

func _physics_process(delta):
    if tracking_actions:
        current_time_count += delta
        if current_time_count > TimeSpan:
            emit_signal("cancel", self)
            reset_move()

func handle_with_tween(tween):
    pass

func get_current_index():
    return all_actions.size()

func on_action_activated(action):
    if action.InputAction == move_definition[0] and not tracking_actions:
        tracking_actions = true
        
    if tracking_actions:
        if all_actions.find(action) == -1:
            all_actions.append(action)
        
        if all_actions.size() == get_child_count():
            var result = check_correctness()
            if result:
                emit_signal("execute", self, UseTween)
            else:
                emit_signal("cancel", self)
            reset_move()

func check_correctness():
    var correct = true
    for i in get_child_count():
        correct = correct and (all_actions[i].InputAction == move_definition[i])
        if not correct:
            return false
    
    return correct

func reset_move():
    tracking_actions = false
    all_actions = []