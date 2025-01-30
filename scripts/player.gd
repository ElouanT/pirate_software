extends CharacterBody2D

@export var speed: int = 500
@export var rotation_speed: float = 5
@export var stoping_speed: float = 5
@export var current_cap: CharacterBody2D = null

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("ui_right"):
		rotation += rotation_speed * delta
	if Input.is_action_pressed("ui_left"):
		rotation -= rotation_speed * delta
	
	var mooving = false
	if current_cap != null:
		current_cap.position = $Bottle/CapPosition.global_position
		current_cap.rotation = $Bottle/CapPosition.global_rotation
		
		if Input.is_action_just_pressed("fire"):
			velocity = Vector2(0, speed).rotated(rotation)
			current_cap.shoot()
			current_cap = null
		
		velocity = velocity.lerp(Vector2(0, 0), delta * 5)
	else:
		if Input.is_action_pressed("ui_up"):
			velocity = Vector2(0, speed).rotated(rotation)
			mooving = true
		
		else:
			velocity = velocity.lerp(Vector2(0, 0), delta * 5)

	$Bottle/CPUParticles2D.emitting = mooving
	move_and_slide()

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.get_parent().is_in_group("cap"):
		var cap = area.get_parent()
		if !cap.shooted:
			current_cap = cap
			
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("cap"):
		var cap = body
		if cap.shooted:
			print("outch!")
			pass #take damage
