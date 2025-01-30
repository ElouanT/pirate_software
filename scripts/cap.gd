extends CharacterBody2D

var speed: float = 2000
var shooted: bool = false
var acceleration = 1

func _process(delta: float) -> void:
	if shooted:
		var collision = move_and_collide(velocity * delta)
		if collision:
			velocity = velocity.lerp(Vector2(0,0), 0.2)
			velocity = velocity.bounce(collision.get_normal())
			rotation = collision.get_angle()
		acceleration += 0.1
		velocity = velocity.lerp(Vector2(0,0), delta * acceleration)
		
		if abs(velocity.y) < 200:
			shooted = false

func shoot():
	shooted = true
	acceleration = 1
	velocity = Vector2(0, -speed).rotated(rotation)
