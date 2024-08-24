extends CharacterBody2D

var Bandera:int = 0 
const Friccion:float = 1.8
const Velocidad:float = 350.0
const Fuerza_de_salto:float = -550.0
@onready var QUIETO = $Quieto
@onready var CORRER = $Correr
@onready var SALTAR = $Saltar
@onready var DEFENSA = $Defensa
@onready var HIT = $Hit
@onready var MUERTE = $Muerte
@onready var ATAQUE1 = $Ataque1
@onready var ATAQUE2 = $Ataque2
@onready var ATAQUE3 = $Ataque3
@onready var Animacion = $AnimationPlayer
@onready var COLISIONA1= $Ataque1/ataque1/Ataque1colision
@onready var salto= $Salto
@onready var dolor= $Dolor
@onready var Espada= $Sword
@onready var Golpe = false
@onready var COLISIONA2= $Ataque2/ataque2/Ataque2colision
@onready var COLISIONA3= $Ataque3/ataque3/Ataque3colision
@onready var barradevida = $CanvasLayer/ProgressBar
@onready var Tiempo = $TiempoDaño
@onready var ColisionH = $HitBox/Colision
@onready var Colision = $Colision
var Posicion = Vector2()
var Atacando:bool = false
var Saltando:bool = false
var N_Ataque:int = 1
var Gravedad = ProjectSettings.get_setting("physics/2d/default_gravity")
var ContadorT =0
func _ready():
	barradevida.value = GLOBAL.VidaJugador
	COLISIONA1.disabled = true
	COLISIONA2.disabled = true
	COLISIONA3.disabled = true
#Esta funcion permite cambiar la visibilidad de los nodos Sprite2D
#La funcion podria ser omitida si solo los recursos(Sprites) del guerrero estuviesen en una sola imagen
func cambiar_visibilidad_nodos(Q,S,C,M,D,A1,A2,A3,H):
	QUIETO.visible = Q
	SALTAR.visible = S
	CORRER.visible = C
	MUERTE.visible = M
	DEFENSA.visible = D
	HIT.visible = H
	ATAQUE1.visible = A1
	ATAQUE2.visible = A2
	ATAQUE3.visible = A3
#Esta funcion cambia la orientacion del personaje es decir si va a la derecha o a la izquierda
func Orientacion(Q,S,C,M,D,A1,A2,A3, H):
	QUIETO.flip_h = Q
	SALTAR.flip_h = S
	CORRER.flip_h = C
	MUERTE.flip_h = M
	HIT.flip_h = H
	DEFENSA.flip_h = D
	ATAQUE1.flip_h = A1
	ATAQUE2.flip_h = A2
	ATAQUE3.flip_h = A3
#La funcion atacar evaluara si el jugador esta haciendo ataques multiples ademas de cambiar la visibilidad de nodos
func atacar():
	Atacando = true
	if Input.is_action_pressed("Izquierda"):
			Orientacion(true,true,true,true,true,true,true,true,true)
			if Bandera == 0:
				COLISIONA1.position.x -= 36.0
				COLISIONA2.position.x -= 43.0
				COLISIONA3.position.x -= 56.0
				Bandera = 1
			Posicion.x = -Velocidad+200
	elif Input.is_action_pressed("Derecha"):
			Orientacion(false,false,false,false,false,false,false,false, false)
			if Bandera == 1:
				COLISIONA1.position.x += 36.5
				COLISIONA2.position.x += 43.0
				COLISIONA3.position.x += 56.0
				Bandera = 0
			Posicion.x = Velocidad-200
	match N_Ataque:
		1:
			cambiar_visibilidad_nodos(false, false, false, false, false,true,false,false, false)
			Animacion.play("Ataque1")
		2:
			cambiar_visibilidad_nodos(false, false, false, false, false,false,true,false, false)
			Animacion.play("Ataque2")
		3:
			cambiar_visibilidad_nodos(false, false, false, false, false,false,false,true, false)
			Animacion.play("Ataque3")
	N_Ataque += 1
	if N_Ataque > 3:
		N_Ataque = 1
func _physics_process(delta):
	if barradevida.value>0:
		# Aplicar gravedad si no esta en el suelo
		if not is_on_floor():
			Posicion.y += Gravedad * delta
		if Atacando == false:
			if is_on_floor():
				Saltando = false
				if Input.is_action_just_pressed("Salto"):
					if Golpe == false:
						cambiar_visibilidad_nodos(false,true,false,false,false,false,false,false, false)
						Animacion.play("Salto")
						salto.play()
					Posicion.y = Fuerza_de_salto
					Saltando = true
			if Input.is_action_pressed("Izquierda"):
				if Saltando == false:
					if Golpe == false:
						cambiar_visibilidad_nodos(false,false,true,false,false,false,false,false, false)
						Animacion.play("Correr")
				Orientacion(true,true,true,true,true,true,true,true,true)
				if Bandera == 0:
					COLISIONA1.position.x -= 36.0
					COLISIONA2.position.x -= 43.0
					COLISIONA3.position.x -= 56.0
					Bandera = 1
				Posicion.x = -Velocidad
			elif Input.is_action_pressed("Derecha"):
				if Saltando == false:
					if Golpe == false:
						cambiar_visibilidad_nodos(false,false,true,false,false,false,false,false, false)
						Animacion.play("Correr")
				Orientacion(false,false,false,false,false,false,false,false, false)
				if Bandera == 1:
					COLISIONA1.position.x += 36.0
					COLISIONA2.position.x += 43.0
					COLISIONA3.position.x += 56.0
					Bandera = 0
				Posicion.x = Velocidad
			else:
				if Golpe == false:
					if Saltando == false:
						cambiar_visibilidad_nodos(true,false,false,false,false,false,false,false, false)
						COLISIONA1.disabled = true
						COLISIONA2.disabled = true
						COLISIONA3.disabled = true
					else:
						cambiar_visibilidad_nodos(false,true,false,false,false,false,false,false, false)
				Posicion.x=0
		if Input.is_action_just_pressed("Ataque"):
			atacar()
		set_velocity(Posicion)
		move_and_slide()
		if is_on_ceiling():
			Posicion.y = 0  # Detener el movimiento vertical hacia arriba
	else:
		Colision.disabled = true
		COLISIONA1.disabled = true
		COLISIONA2.disabled = true
		COLISIONA3.disabled = true
		ColisionH.disabled = true
		cambiar_visibilidad_nodos(false,false,false,true,false,false,false,false,false)
		Animacion.play("Muerte")
		ContadorT += delta
		if ContadorT >= 1.0:
			Animacion.pause()
			get_tree().paused = true
			set_physics_process(false)

func Cuando_saltoanimacion_termine(Salto):
	Animacion.pause()


func Cuandoataque1acabe(Ataque1):
	Atacando = false


func Cuandoataque2acabe(Ataque2):
	Atacando = false


func Cuandoataque3acabe(Ataque3):
	Atacando = false
	

func _on_hit_box_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	if area.is_in_group("AtaqueEnemigo"):
		Tiempo.start()
		Golpe=true
		if Atacando == false:
			cambiar_visibilidad_nodos(false, false, false, false, false, false, false, false, true)



func _on_hit_box_area_shape_exited(area_rid, area, area_shape_index, local_shape_index):
	if area.is_in_group("AtaqueEnemigo"):
		Tiempo.stop()
		Golpe=false
		cambiar_visibilidad_nodos(true, false, false, false, false, false, false, false, false)
	else:
		print("no detecto nada")


func _on_tiempo_daño_timeout():
	barradevida.value=GLOBAL.VidaJugador


func _on_ataque_1_body_entered(body):
	if body.is_in_group("Paredes"):
		if Bandera == 1:
			Posicion.x += Velocidad + GLOBAL.FuerzaJugador
		elif Bandera == 0:
			Posicion.x -= Velocidad+ GLOBAL.FuerzaJugador
		Espada.play()


func _on_ataque_2_body_entered(body):
	if body.is_in_group("Paredes"):
		if Bandera == 1:
			Posicion.x += Velocidad + GLOBAL.FuerzaJugador
		elif Bandera == 0:
			Posicion.x -= Velocidad+ GLOBAL.FuerzaJugador
		Espada.play()


func _on_ataque_3_body_entered(body):
	if body.is_in_group("Paredes"):
		if Bandera == 1:
			Posicion.x += Velocidad + GLOBAL.FuerzaJugador
		elif Bandera == 0:
			Posicion.x -= Velocidad+ GLOBAL.FuerzaJugador
		Espada.play()
