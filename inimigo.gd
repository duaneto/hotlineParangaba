extends CharacterBody2D

@export var velocidade: float = 100.0
@export var distancia_visao: float = 150.0
@export var bulletSpeed: int = 500
@export var vivo: bool = true
var bullet_scene = preload("res://Bala.tscn")



var jogador = null
var pode_atirar = true


func _ready() -> void:
	jogador = get_tree().get_first_node_in_group("jogador")

func _physics_process(delta: float) -> void:

	if vivo == true:

		if jogador != null:

			var distancia = global_position.distance_to(jogador.global_position)

			if distancia <= distancia_visao:

				print("VIU O JOGADOR!")

				# Faz o inimigo olhar para o jogador
				look_at(jogador.global_position)

				var direcao = (jogador.global_position - global_position).normalized()

				if global_position.distance_to(jogador.global_position) < 100:
					velocity = direcao * velocidade
					await get_tree().create_timer(0.5).timeout
					velocity = global_position
				else:
					velocity = direcao * velocidade

				if pode_atirar:
					shoot(jogador.global_position)

			else:

				velocity.x = velocidade
				velocity.y = 0

		else:

			velocity.x = velocidade
			velocity.y = 0

		move_and_slide()
		

func shoot(target_position: Vector2) -> void:

	pode_atirar = false
	var bullet = bullet_scene.instantiate() as RigidBody2D
	bullet.global_position = global_position
	
	var direction: Vector2 = (target_position - global_position).normalized()
	bullet.linear_velocity = direction * bulletSpeed
	
	var angle: float = direction.angle()
	bullet.rotation = angle
	
	get_parent().add_child(bullet)
	
	await get_tree().create_timer(1.0).timeout

	pode_atirar = true


func receber_dano() -> void:

	print("INIMIGO MORREU!")

	queue_free()
