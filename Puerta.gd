extends StaticBody2D

var Estado: bool = false
@onready var animacion = $Animacion
@onready var puerta = $EfectoPuerta
@onready var colision = $Colision
var sonido_reproducido: bool = false

# Cambia el estado de la puerta y maneja la animación y el efecto de sonido
func CambiarEstadoPuerta(cambio: bool):
	Estado = cambio
	if Estado == false:
		animacion.play("Cerrada")
		colision.disabled = false
		sonido_reproducido = false  # Resetea el sonido al cerrar
	else:
		animacion.play("Abierta")
		colision.disabled = true
		if not sonido_reproducido:
			puerta.play()
			sonido_reproducido = true  # Marca que el sonido ya se ha reproducido
		await(get_tree().create_timer(2.0).timeout)
		puerta.stop()

func _ready():
	pass # Puedes conectar el botón aquí si es necesario

func _on_cambiarestado_pressed():
	if Estado == false:
		CambiarEstadoPuerta(true)
	else:
		CambiarEstadoPuerta(false)
