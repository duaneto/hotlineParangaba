extends Camera2D

var ending:bool  = false

@export var fator_mouse : float = 0.35
@export var alcance_maximo : float = 200
@export var shake_intensity: float = 0
@export var shake_decay: float= 5.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if ending == false:
		#Seguir o mouse
		var pos_jogador = get_parent().global_position
		var pos_mouse = get_global_mouse_position()
		var dif = pos_jogador - pos_mouse
		dif = dif * fator_mouse
		dif = dif.limit_length(alcance_maximo)
		global_position = pos_jogador - dif
		#Execuçao do tremor
		if shake_intensity > 0:
			offset = Vector2(randf_range(-shake_intensity,shake_intensity),randf_range(-shake_intensity,shake_intensity))
			shake_intensity = move_toward(shake_intensity,0.0,shake_decay)
func shake(amount:float) -> void:
	shake_intensity = amount
	
func end():
	ending = true
	
	
