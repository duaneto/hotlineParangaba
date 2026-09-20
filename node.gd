extends Node

signal death_to_enemies

var tamTela: Vector2
@export var cena_inimigo: PackedScene
@export var quantidade_inimigos = 10

func _ready() -> void:
	$End.hide()
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
		death_to_enemies.connect(inimigo.despawn)
func _process(delta: float) -> void:
	$VideoStreamPlayer.position.x = $Jogador.position.x - 310
	$VideoStreamPlayer.position.y = $Jogador.position.y - 200

func _on_jogador_dead() -> void:
	death_to_enemies.emit()
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
		death_to_enemies.connect(inimigo.despawn)
		


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("jacket"):
		$Jogador.end()
		$End.position.x = $Jogador.position.x - 350
		$End.position.y = $Jogador.position.y - 200
		$End.show()
		$End/Label2.text = $HUD.time()
		$AudioStreamPlayer.stop()
		$AudioStreamPlayer2.play()
		
		
		
