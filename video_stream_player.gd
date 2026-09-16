extends VideoStreamPlayer

@onready var jogador: CharacterBody2D = $"../.."

@onready var camera_2d: Camera2D = $".."

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass 


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if is_instance_valid(camera_2d):
		pass
	else:
		print("Erro")
		
