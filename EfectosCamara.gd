extends Camera2D
#Parametros de temblor
var duracion_temblor: float = 0
var fuerza_temblor: float = 0
var tiempo_temblor: float = 0
var tiempo_inicial: float = 0
#Parametros de zoom
var zoom_minimo: Vector2 = Vector2(1,1)
var zoom_maximo: Vector2 = Vector2(1.7,1.7)
var velocidad_zoom: Vector2 = Vector2 (0.1,0.1)
var tiempo_zoom_acercar: float = 0
var tiempo_zoom_alejar: float = 0
func iniciar_acerca_zoom(tiempo: float,velocidad: Vector2):
	tiempo_zoom_acercar = tiempo
	velocidad_zoom = velocidad
func iniciar_alejar_zoom(tiempo: float,velocidad: Vector2):
	tiempo_zoom_alejar = tiempo
	velocidad_zoom = velocidad
func iniciar_temblor(Duracion: float, Magnitud: float):
	duracion_temblor = Duracion
	fuerza_temblor = Magnitud
	tiempo_temblor = Duracion
	tiempo_inicial = Duracion
func _process(delta):
	# Condición para el efecto de sacudida
	if tiempo_temblor > 0:
		tiempo_temblor -= delta
		# Generar un desplazamiento armónico simple amortiguado
		var decaimiento = exp(-5.0 * (1.0 - tiempo_temblor / tiempo_inicial)) # Factor de amortiguamiento
		var offset_y = randf_range(-fuerza_temblor, fuerza_temblor) * decaimiento
		var offset_x = randf_range(0, 0) * decaimiento
		# Aplicar el desplazamiento a la posición de la cámara
		offset = Vector2(offset_x, offset_y)
	else:
		# Restablecer la posición de la cámara cuando la sacudida termine
		offset = Vector2.ZERO
	if tiempo_zoom_acercar > 0:
		if zoom != zoom_maximo:
			tiempo_zoom_acercar -= delta
			zoom += velocidad_zoom
		else:
			tiempo_zoom_acercar = 0
	if tiempo_zoom_alejar > 0:
		if zoom != zoom_minimo:
			tiempo_zoom_alejar -= delta
			zoom -= velocidad_zoom
		else:
			tiempo_zoom_alejar = 0
