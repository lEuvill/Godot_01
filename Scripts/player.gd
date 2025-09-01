# Player.gd
extends CharacterBody2D

@export var speed := 20

@onready var animated_sprite = $AnimatedSprite2D

func _physics_process(delta):
	var input_vector = Vector2.ZERO

	# Read normal input
	if Input.is_action_pressed("ui_right"):
		#animated_sprite.flip_h = false
		animated_sprite.play("right")
		input_vector.x += 1
	if Input.is_action_pressed("ui_left"):
		#animated_sprite.flip_h = true
		animated_sprite.play("left")
		input_vector.x -= 1
	if Input.is_action_pressed("ui_down"):
		animated_sprite.play("down")
		input_vector.y += 1
	if Input.is_action_pressed("ui_up"):
		animated_sprite.play("up")
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

	
