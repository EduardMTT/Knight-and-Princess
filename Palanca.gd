extends Area2D

var estado = false
@onready var Anima = $Animacion

# Se llama cuando el nodo entra en el árbol de la escena por primera vez.
func _ready():
	pass

# Se llama cuando un área entra en contacto con la palanca.
func _on_area_entered(area):
	if area.name == "ataque1" or area.name == "ataque2" or area.name == "ataque3":
		print("detecta area")
		if estado==false :
			Anima.play("Activada")
			print ("activada")
			estado = true
		else:
			Anima.play("Desactivada")
			print ("desactivada")
			estado = false

func puerta():
	return estado  # Devuelve el estado actual de la palanca

