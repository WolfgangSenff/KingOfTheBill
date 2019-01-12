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

func on_try_move_execute(move, use_tween):
    current_possible_moves.append(move)
    get_tree().create_timer(TimeToNextMoveVerification).connect("timeout", self, "on_move_executed", [move, use_tween])

func on_move_executed(move, use_tween):
    var max_move_count = 0
    var max_move = null
    for move in current_possible_moves:
        var old_move_count = max_move_count
        max_move_count = max(max_move_count, move.get_child_count())
        if old_move_count != max_move_count:
            max_move = move
            
    if max_move != null:
        execute(max_move, use_tween)
        reset_controller()
        
func execute(move, use_tween):
    emit_signal("execute_move", move, use_tween)
    pass
    
func reset_controller():
    current_possible_moves.clear()
    
func on_move_canceled(move):
    var pos = current_possible_moves.find(move)
    if pos != -1:
        current_possible_moves.remove(pos)
    pass