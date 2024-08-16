extends CharacterBody2D
@onready var Anima = $Animacion
@onready var Colision = $Colision
@onready var ColisionHit = $HitBox/ColisionHit
@onready var EffectoA = $AttackEffect
@onready var EffectoH = $HitEffect
@onready var EffectoD = $DeadEffect
@onready var ColisionAtaque = $Ataque/Ataque1Colision
@onready var raycast_derecha = $Derecha
@onready var raycast_izquierda = $Izquierda
@onready var Tiempo = $TiempoAtacando
var Posicion = Vector2()
var direccion: String = 'Izquierda'
var bandera: bool 
var Atacando: bool = false
var ContadorT = 0
@export var DañoPig =1
var Gravedad = ProjectSettings.get_setting("physics/2d/default_gravity")
@export var Vida = 30
const VelocidadPig:float = 120.0
func _ready():
	Posicion.x = -VelocidadPig
	Anima.play("Corriendo")
func _physics_process(delta):
	if Vida>=1:
		if Atacando == true:
			EffectoA.play()
			
		if Atacando == false:
			if direccion == 'Derecha' and bandera == false:
				Colision.position.x = Anima.position.x-0.6
				ColisionHit.position.x = Anima.position.x-0.6
				ColisionAtaque.position.x += 20
				bandera = true
			if direccion == 'Izquierda' and bandera == true:
				Colision.position.x = Anima.position.x+0.6
				ColisionHit.position.x = Anima.position.x+0.6
				ColisionAtaque.position.x -= 20
				bandera = false
			if not is_on_floor():
				Posicion.y += Gravedad*delta
				Anima.play("Callendo")
			else:
				if not raycast_derecha.is_colliding() or not raycast_izquierda.is_colliding():
					if direccion == 'Derecha':
						Anima.flip_h = false
						Posicion.x = -VelocidadPig
						direccion = 'Izquierda'
					elif direccion == 'Izquierda':
						Anima.flip_h = true
						Posicion.x = VelocidadPig
						direccion = 'Derecha'
				Anima.play("Corriendo")
			if is_on_wall():
				if !Anima.flip_h:
					Posicion.x = VelocidadPig
					direccion = 'Derecha'
				else:
					Posicion.x = -VelocidadPig
					direccion = 'Izquierda'
				if Posicion.x <0:
					Anima.flip_h = false
				elif Posicion.x > 0:
					Anima.flip_h = true
		set_velocity(Posicion)
		move_and_slide()
	else:
		ColisionAtaque.disabled = true
		ColisionHit.disabled = true
		if Anima.animation != "Muerto":
			Anima.play("Muerto")
			EffectoD.play()
		ContadorT += delta
		if ContadorT >= 0.5:
			Anima.stop()
			set_physics_process(false)
			queue_free()
			
		
		


func _on_ataque_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if Vida >=1:
		if body.is_in_group('Jugador'):
			Tiempo.start()
			Anima.play("Atacando")
			Atacando = true
			set_physics_process(false)
	else:
		ColisionAtaque.disabled = true
	


func _on_ataque_body_shape_exited(body_rid, body, body_shape_index, local_shape_index):
	if Vida >=1:
		if body.is_in_group("Jugador"):
			Tiempo.stop()
			Atacando = false
			set_physics_process(true)
			EffectoA.stop()
	else:
		ColisionAtaque.disabled = true

func _on_attack_effect_finished():
	EffectoA.play()



func _on_hit_box_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	if Vida >=1:
		if area.is_in_group("AtaqueJugador"):
			ColisionAtaque.disabled = true
			set_physics_process(false)
			Anima.play("Hit")
			EffectoH.play()
			Vida -= GLOBAL.FuerzaJugador


func _on_hit_box_area_shape_exited(area_rid, area, area_shape_index, local_shape_index):
	if area.is_in_group("AtaqueJugador"):
		ColisionAtaque.disabled = false
		set_physics_process(true)
		Anima.play("Corriendo")


func _on_animacion_animation_finished():
	get_tree().paused = true


func _on_tiempo_atacando_timeout():
	GLOBAL.VidaJugador -= DañoPig
	Anima.play("Atacando")
	EffectoA.play()
