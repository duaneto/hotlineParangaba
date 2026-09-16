extends CharacterBody2D

@export var speed: float = 300.0
@export var acceleration: float = 1500.0
@export var friction: float = 1200.0
@export var rotation_speed: float = 12.0

@export var bullet_scene: PackedScene
@export var bulletSpeed: int= 900

var last_direction: Vector2 = Vector2.RIGHT

func _ready() -> void:
	$Sprite2D2.hide()

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		shoot(get_global_mouse_position())
		$Camera2D.shake(8)
		$Sprite2D2.show()
		$Sprite2D.hide()
		await get_tree().create_timer(0.15).timeout
		$Sprite2D.show()
		$Sprite2D2.hide()
		
		
func shoot(target_position: Vector2) -> void:
	var bullet = bullet_scene.instantiate() as RigidBody2D
	bullet.global_position = global_position
	
	var direction: Vector2 = (target_position - bullet.position).normalized()
	bullet.linear_velocity = direction * bulletSpeed
	
	var angle: float = direction.angle()
	bullet.rotation = angle
	
	get_parent().add_child(bullet)
	

func _physics_process(delta: float) -> void:
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
