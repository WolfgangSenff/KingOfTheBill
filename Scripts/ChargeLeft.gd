extends "res://Scripts/Move.gd"

export (float) var MovementAmount
export (float) var Duration
export (NodePath) onready var ActorPath

onready var actor = get_node(ActorPath)

func handle_with_tween(tween):
    tween.interpolate_property(actor, "position", actor.position, actor.position - Vector2(MovementAmount, 0.0), Duration, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
    tween.start()