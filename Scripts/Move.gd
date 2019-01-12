extends Node2D

export (float, 0.2) var MoveTimeToExecute
export (String) var MoveAnimationName
signal execute(move)
signal begin_tracking(move)
signal cancel(move)

var current_actions = []
var all_actions = []

var last_action = null setget ,get_last_action

var begun_move = false

func _ready():
    all_actions = get_children().invert()
    reset_move(false)
    
func disconnect_from_last_action():
    self.last_action.disconnect("begin", self, "on_action_begun")
    self.last_action.disconnect("end", self, "on_action_ended")
    self.last_action.disconnect("cancel", self, "on_action_canceled")
    
func reconnect_to_last_action():
    self.last_action.connect("begin", self, "on_action_begun")
    self.last_action.connect("end", self, "on_action_ended")
    self.last_action.connect("cancel", self, "on_action_canceled")
    
func on_action_canceled():
    reset_move(true)

func on_action_begun():
    if not begun_move:
        begun_move = true
        emit_signal("begin_tracking", self)

func go_to_next_action():
    disconnect_from_last_action()
    current_actions.pop_back()
    if current_actions.size() > 0:
        reconnect_to_last_action()
    else:
        emit_signal("execute", self)
        reset_move(false)

func on_action_ended():
    go_to_next_action()
    
func reset_move(cancel):
    disconnect_from_last_action()
    for action in all_actions:
        action.action_executed = false
    current_actions = all_actions.duplicate(true)
    reconnect_to_last_action()
    if cancel:
        emit_signal("cancel", self)
    
func get_last_action():
    return current_actions[current_actions.size() - 1]
