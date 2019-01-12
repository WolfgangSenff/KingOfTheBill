extends Node2D

signal execute_move(move)

export (float, 0.2, 10) var TimeToNextMoveVerification

var current_possible_moves = []
var all_moves = []

func _ready():
    for child in get_children():
        child.connect("execute", self, "on_try_move_execute")
        child.connect("cancel", self, "on_move_canceled")
        all_moves.append(child)

func on_try_move_execute(move):
    current_possible_moves.append(move)
    get_tree().create_timer(TimeToNextMoveVerification).connect("timeout", self, "on_move_executed", [move])

func on_move_executed(move):
    var max_move_count = 0
    var max_move = null
    for move in current_possible_moves:
        var old_move_count = max_move_count
        max_move_count = max(max_move_count, move.get_child_count())
        if old_move_count != max_move_count:
            max_move = move
            
    if max_move != null:
        execute(max_move)
        reset_controller()
        
func execute(move):
    emit_signal("execute_move", move)
    pass
    
func reset_controller():
    current_possible_moves.clear()
    
func on_move_canceled(move):
    var pos = current_possible_moves.find(move)
    if pos != -1:
        current_possible_moves.remove(pos)
    pass
    

    

    
    
    
#    parse_all_moves()
#
#
#func parse_all_moves():
#    for move in get_children():
#        for action in move.get_children():
#            if not all_moves.has(move.MoveName):
#                all_moves[move.MoveName] = {"move": move, "action_list": []}
#                all_moves[move.MoveName]["total_move_time"] = 0
#
#            all_moves[move.MoveName]["action_list"].append({action.InputAction: action})
#            all_moves[move.MoveName]["total_move_time"] += TimePerAction
#
#        all_moves[move.MoveName]
#
#    print("All moves:\n" + str(all_moves))
#
#var current_possible_moves = []
#var current_time_to_next_action
#var current_action_index = 0
#var awaiting_next_action = false
#
#func _physics_process(delta):
#    current_time_to_next_action += delta
#
#    for move in current_possible_moves:
#        if Input.is_action_pressed(move["action_list"][current_action_index].InputAction):
#
#            pass
#        pass
#    pass