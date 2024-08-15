extends Node2D
@onready var destino = $PuntoB/ColisionB
# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_punto_a_body_entered(body):
	if body.name == 'Jugador':
		body.global_position  = destino.global_position
