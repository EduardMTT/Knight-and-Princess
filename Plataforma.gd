extends Node2D

var Posicion = Vector2()
var moviendo_arriba = false
var moviendo_abajo = false
var velocidad = 200  # La velocidad del movimiento en píxeles por segundo

# Función para empezar a mover hacia arriba
func subir():
	moviendo_arriba = true
	moviendo_abajo = false

# Función para empezar a mover hacia abajo
func bajar():
	moviendo_abajo = true
	moviendo_arriba = false

# Detener el movimiento
func detener():
	moviendo_arriba = false
	moviendo_abajo = false

# Se llama cuando el nodo entra en el árbol de la escena por primera vez.
func _ready():
	Posicion = position  # Inicializa Posicion con la posición actual del nodo

# Se llama cada frame. 'delta' es el tiempo transcurrido desde el frame anterior.
func _process(delta):
	if moviendo_arriba:
		Posicion.y -= velocidad * delta  # Mueve hacia arriba de manera suave
	elif moviendo_abajo:
		Posicion.y += velocidad * delta  # Mueve hacia abajo de manera suave

	position = Posicion  # Actualiza la posición del nodo

# Se llama cuando se presiona el primer botón
func _on_button_pressed():
	subir()

# Se llama cuando se presiona el segundo botón
func _on_button_2_pressed():
	bajar()

# Se llama cuando se suelta un botón
func _on_button_released():
	detener()

# Se llama cuando se suelta el segundo botón
func _on_button_2_released():
	detener()
