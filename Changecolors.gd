extends Node2D
@onready var Fred = $Rojo
@onready var Fblue = $Azul
@onready var Fpurple = $Morado
@onready var Fgreen = $Verde

func Cambiarcolor(color):
	Fred.visible =true if color == "Rojo" else false
	Fblue.visible =true if color == "Azul" else false
	Fpurple.visible =true if color == "Morado" else false
	Fgreen.visible =true if color == "Verde" else false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
