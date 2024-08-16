extends Node2D
var bpm = 97  # BPM de la canción
var tiempo_entre_eventos = 60.0  / bpm  # Tiempo en segundos entre cada evento

@onready var Musica = $Cancion
@onready var camara=$Camara
@export var VidaMaxima=100
#Secuencia se utiliza para el patron de ejecucion del evento en este caso el (iniciar_temblor) 
var secuencia = [1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0]
var indice_secuencia = 0
var tiempo_acumulado = 0.0

func _ready():
	$Jugador/CanvasLayer.visible = false
	GLOBAL.ObtenerVidaJugador(VidaMaxima)
	Musica.play()
	set_process(true)
	print(tiempo_entre_eventos)

func _process(delta):
	tiempo_acumulado += delta
	while tiempo_acumulado >= tiempo_entre_eventos:
		tiempo_acumulado -= tiempo_entre_eventos
		_trigger_event()

func _trigger_event():
	if(secuencia[indice_secuencia]):
		camara.iniciar_temblor(0.5,20)
	indice_secuencia = (indice_secuencia + 1) % secuencia.size()

func _on_cancion_finished():
	Musica.play()
	indice_secuencia = 0  # Reiniciar la secuencia cuando la canción se reinicia
func iniciar():
	GLOBAL.cambio("res://Niveles/Nivel1.tscn")
	get_tree().change_scene_to_file("res://pantallade_carga.tscn")
func _on_button_pressed():
	iniciar()

func _on_salir_pressed():
	get_tree().quit()
