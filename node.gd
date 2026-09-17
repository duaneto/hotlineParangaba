extends Node

var tamTela: Vector2


func _ready() -> void:
	$Jogador.position.x = 1200
	$Jogador.position.y = 1200


func _process(delta: float) -> void:
	$VideoStreamPlayer.position.x = $Jogador.position.x - 310
	$VideoStreamPlayer.position.y = $Jogador.position.y - 200
	
