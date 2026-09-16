extends Node

var tamTela: Vector2


func _ready() -> void:
	$Jogador.position.x = 600
	$Jogador.position.y = 400


func _process(delta: float) -> void:
	$VideoStreamPlayer.position.x = $Jogador.position.x - 250
	$VideoStreamPlayer.position.y = $Jogador.position.y - 200
	
