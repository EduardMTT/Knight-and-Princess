extends Control

@onready var progreso: Array
@onready var TextoCarga = $TextoCarga
@onready var estadodecarga : int
@onready var progress_bar = $MarginContainer/ProgressBar  # Asumiendo que ProgressBar está directamente bajo el nodo actual

# Se llama cuando el nodo entra en el árbol de la escena por primera vez.
func _ready():
	if GLOBAL.escena_a_cargar != "":
		ResourceLoader.load_threaded_request(GLOBAL.escena_a_cargar)
		TextoCarga = "Cargando..."
# Se llama en cada frame. 'delta' es el tiempo transcurrido desde el frame anterior.
func _process(delta):
	if progreso.size() != 100:
		estadodecarga = ResourceLoader.load_threaded_get_status(GLOBAL.escena_a_cargar, progreso)
		print("Progreso:", progreso)
	if progreso.size() > 0:
		progress_bar.value = progreso[0] * 100
# Se llama cuando el valor de la barra de progreso cambia.
func _on_progress_bar_value_changed(value):
	if value == 100 and estadodecarga == ResourceLoader.THREAD_LOAD_LOADED:
		get_tree().call_deferred("change_scene_to_packed",ResourceLoader.load_threaded_get(GLOBAL.escena_a_cargar))
		 
		
