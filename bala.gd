extends RigidBody2D

func _ready() -> void:
	# Garante que a colisão comece ativa de forma segura
	$CollisionShape2D.set_deferred("disabled", false)

func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	if linear_velocity != Vector2.ZERO:
		rotation = linear_velocity.angle()

func _process(delta: float) -> void:
	# Se a bala sair da tela, destrói sem esperar som
	if not get_viewport_rect().has_point(global_position):
		queue_free()

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("jacket"):
		body.die()
	else:
		# 1. Esconde a bala e desativa a colisão usando set_deferred
		$Sprite2D.hide()
		$CollisionShape2D.set_deferred("disabled", true)
	
		# 2. Para a bala para o som não andar
		linear_velocity = Vector2.ZERO
	
		# 3. Espera o som (0.5s) e remove do jogo
		await get_tree().create_timer(0.5).timeout
		queue_free()
	
