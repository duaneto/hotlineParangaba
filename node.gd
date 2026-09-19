extends Node

var tamTela: Vector2
@export var cena_inimigo: PackedScene
@export var quantidade_inimigos = 10

func _ready() -> void:
	$Jogador.position.x = 1200
	$Jogador.position.y = 1200

	var pontos = $pontosSpawn.get_children()
	print("Quantidade de pontos: ", pontos.size())

	pontos.shuffle()

	for ponto in pontos:
		var inimigo = cena_inimigo.instantiate()
		print("Inimigo criado!")
		add_child(inimigo)
		inimigo.global_position = ponto.global_position
func _process(delta: float) -> void:
	$VideoStreamPlayer.position.x = $Jogador.position.x - 310
	$VideoStreamPlayer.position.y = $Jogador.position.y - 200
	
