extends CharacterBody2D

var ending: bool = false
var shotgun: bool = false
@export var speed: float = 300.0
@export var acceleration: float = 1500.0
@export var friction: float = 1200.0
@export var rotation_speed: float = 12.0

signal dead

@export var bullet_scene: PackedScene
@export var bulletSpeed: int= 900

var last_direction: Vector2 = Vector2.RIGHT

func _ready() -> void:
	$Sprite2D2.hide()
	$Sprite2D3.hide()
	$Sprite2D4.hide()

func _unhandled_input(event: InputEvent) -> void:
	if ending == false:
		if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			shoot(get_global_mouse_position())
			$Camera2D.shake(8)
			if shotgun:
				$Sprite2D3.show()
				$Sprite2D4.hide()
				await get_tree().create_timer(0.15).timeout
				$Sprite2D4.show()
				$Sprite2D3.hide()
			else:
				$Sprite2D2.show()
				$Sprite2D.hide()
				await get_tree().create_timer(0.15).timeout
				$Sprite2D.show()
				$Sprite2D2.hide()
		
		
func shoot(target_position: Vector2) -> void:
	# 1. Descobre a direção base (em direção ao mouse)
	var base_direction: Vector2 = (target_position - global_position).normalized()
	
	# 2. Define os ângulos de tiro (em graus). 
	# Se for shotgun, atira em -15, 0 e +15 graus. Se não, atira só reto (0).
	var spread_angles = [0.0]
	if shotgun:
		spread_angles = [-7.0, 0.0, 7.0]
		
	# 3. Cria uma bala para cada ângulo na lista
	for angle_deg in spread_angles:
		var bullet = bullet_scene.instantiate() as RigidBody2D
		bullet.global_position = global_position
		
		# Gira a direção base usando o ângulo atual (convertido para radianos)
		var fire_direction = base_direction.rotated(deg_to_rad(angle_deg))
		
		# Define a velocidade e a rotação correta da bala
		bullet.linear_velocity = fire_direction * bulletSpeed
		bullet.rotation = fire_direction.angle()
		
		# Adiciona a nova bala na cena
		get_parent().add_child(bullet)

func _physics_process(delta: float) -> void:
	if ending == false:
		var direction := Input.get_vector("left", "right", "up", "down")

		if direction != Vector2.ZERO:
			velocity = velocity.move_toward(direction * speed, acceleration * delta)
			# Atualiza a última direção válida apenas quando há input
			last_direction = direction
		else:
			velocity = velocity.move_toward(Vector2.ZERO, friction * delta)

		# Gira continuamente em direção à última direção registrada
		look_at(get_global_mouse_position())

		move_and_slide()

func die():
	dead.emit()
	
func end():
	ending = true
	$Camera2D.end()

func shotgunMode() -> void:
	shotgun = true
	$Sprite2D.hide()
	$Sprite2D4.show()
