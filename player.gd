# Player.gd
extends CharacterBody2D

@export var speed := 20

@onready var animated_sprite = $AnimatedSprite2D

func _physics_process(delta):
	var input_vector = Vector2.ZERO

	# Read normal input
	if Input.is_action_pressed("ui_right"):
		input_vector.x += 1
	if Input.is_action_pressed("ui_left"):
		input_vector.x -= 1
	if Input.is_action_pressed("ui_down"):
		input_vector.y += 1
	if Input.is_action_pressed("ui_up"):
		input_vector.y -= 1

	input_vector = input_vector.normalized()

	# ---- Apply Isometric Transformation ----
	var iso_input = Vector2(
		input_vector.x - input_vector.y,
		(input_vector.x + input_vector.y) / 2
	)
	velocity = iso_input.normalized() * speed
	move_and_slide()
	# -----------------------------------------

	# Animation control
	if input_vector != Vector2.ZERO:
		play_movement_animation(input_vector)
	else:
		animated_sprite.stop()

func play_movement_animation(direction: Vector2):
	# Direction based on normal input
	if direction.x > 0 and direction.y > 0:
		animated_sprite.play("SE") # Southeast
	elif direction.x > 0 and direction.y < 0:
		animated_sprite.play("NE") # Northeast
	elif direction.x < 0 and direction.y > 0:
		animated_sprite.play("SW") # Southwest
	elif direction.x < 0 and direction.y < 0:
		animated_sprite.play("NW") # Northwest
