extends Node2D
var bpm = 68
var tiempo_entre_eventos = 60.0  / bpm 
@onready var Musica = $Cancion
@onready var color = $Jugador/Colores
@onready var camara = $Jugador/Camara
@onready var puerta1 = $Puerta1
@onready var palanca1 =$Palanca1
@onready var puerta2 = $Puerta2
@onready var palanca2 =$Palanca2
@onready var estallar = $Jugador/Estallido/Animacion
var secuenciacolores = [1, 1, 1, 1]
var secuenciacamara = [1,0,0]
var secuenciacamaraz = [1,1,1,0]
var indice_secuenciaco = 0
var indice_secuenciaca = 0
var indice_secuenciacaz = 0
var tiempo_acumulado = 0.0
var tiempo_cancion =0.0
var Colores = ['Rojo', 'Azul','Verde','Morado']
func _ready():
	Musica.play()
	set_process(true)
func _song_event():
	if(secuenciacolores[indice_secuenciaco]):
		color.Cambiarcolor(Colores[indice_secuenciaco])
	if(secuenciacamara[indice_secuenciaca]):
		camara.iniciar_temblor(0.5,20)
	if tiempo_cancion < 7.74273699999998:
		if(secuenciacamaraz[indice_secuenciacaz]):
			camara.iniciar_acerca_zoom(0.5,Vector2(0.01,0.01))
		else:
			camara.iniciar_alejar_zoom(0.5,Vector2(0.03,0.03))
		if tiempo_cancion > 7:
			estallar.play("Estallar")
		indice_secuenciacaz = (indice_secuenciacaz + 1) % secuenciacamaraz.size()
		
	indice_secuenciaco = (indice_secuenciaco + 1) % secuenciacolores.size()
	indice_secuenciaca = (indice_secuenciaca + 1) % secuenciacamara.size()
func _process(delta):
	print(tiempo_cancion)
	puerta1.CambiarEstadoPuerta(palanca1.estado)
	puerta2.CambiarEstadoPuerta(palanca2.estado)
	tiempo_acumulado += delta
	tiempo_cancion += delta
	while tiempo_acumulado >= tiempo_entre_eventos:
		tiempo_acumulado -= tiempo_entre_eventos
		_song_event()


func _on_cancion_finished():
	Musica.play()
	tiempo_cancion =0
	indice_secuenciaco = 0 
	indice_secuenciaca = 0  # Reiniciar la secuencia cuando la canción se reinicia
