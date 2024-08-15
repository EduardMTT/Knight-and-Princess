extends Camera2D

# Referencia al nodo del jugador (puedes asignarlo en el editor)
var margen = 50
# Margen para seguir al jugador (opcional)
func _ready():
	make_current()

func _process(delta):
	if jugador:
		# Obtener la posición del jugador
		var posicion_jugador = jugador.position
		# Seguir al jugador en el eje X solamente
		position.x = posicion_jugador.x
		# Opcional: Mantener la posición vertical en un rango alrededor del jugador
		# Puedes ajustar el margen si lo necesitas
		position.y = clamp(position.y, posicion_jugador.y - margen, posicion_jugador.y + margen)
