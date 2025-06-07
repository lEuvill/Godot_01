extends CharacterBody2D
@export var speed := 120.0  # speed for both input & pathfinding
@onready var p_2: CharacterBody2D = $"."
@onready var animated_sprite = $AnimatedSprite2D
@onready var agent = $NavigationAgent2D
var is_moving_to_target := false

func _ready():
	# The NavigationAgent2D automatically uses the parent node's navigation map
	# No need to manually set it in Godot 4
	pass

func _physics_process(delta):
	if is_moving_to_target:
		# Follow the path from the agent
		# NavigationAgent2D automatically tracks the parent's position in Godot 4
		if agent.is_navigation_finished():
			is_moving_to_target = false
			velocity = Vector2.ZERO
			animated_sprite.stop()
			return
		
		var next_point = agent.get_next_path_position()
		var direction = (next_point - global_position).normalized()
		velocity = direction * speed
		
		# Move the player (CharacterBody2D)
		move_and_slide()
		
		# Play animation based on direction
		play_animation(direction)
		
		# The NavigationAgent2D automatically advances when close enough
		# No need to manually call advance() in Godot 4
	else:
		# Manual input movement
		var input_vector = Vector2.ZERO
		if Input.is_action_pressed("space"):
			p_2.move_to_position(Vector2(800, 600))
		if Input.is_action_pressed("ui_right"):
			input_vector.x += 1
			
		if Input.is_action_pressed("ui_left"):
			input_vector.x -= 1
		if Input.is_action_pressed("ui_down"):
			input_vector.y += 1
		if Input.is_action_pressed("ui_up"):
			input_vector.y -= 1
		
		input_vector = input_vector.normalized()
		if input_vector != Vector2.ZERO:
			# ---- Apply Isometric Transformation ----
			var iso_input = Vector2(
				input_vector.x - input_vector.y,
				(input_vector.x + input_vector.y) / 2
			)
			velocity = iso_input.normalized() * speed
			move_and_slide()
			play_animation(iso_input.normalized())
		else:
			velocity = Vector2.ZERO
			animated_sprite.stop()

# Helper function to play animation based on movement direction
func play_animation(direction: Vector2):
	# Assuming 'direction' is isometric movement vector (already transformed)
	# We decide animation based on which is dominant axis and the sign
	# Because your iso_input is:
	# x_iso = input_vector.x - input_vector.y
	# y_iso = (input_vector.x + input_vector.y) / 2
	#
	# The directions correspond roughly to:
	# right animation: moving iso right (x_iso > 0)
	# left animation: moving iso left (x_iso < 0)
	# down animation: moving iso down (y_iso > 0)
	# up animation: moving iso up (y_iso < 0)
	if abs(direction.x) > abs(direction.y):
		if direction.x > 0:
			animated_sprite.play("right")
			animated_sprite.flip_h = false
		else:
			animated_sprite.play("left")
			animated_sprite.flip_h = false
	else:
		if direction.y > 0:
			animated_sprite.play("down")
		else:
			animated_sprite.play("up")

# Public method to move player to a target position via navigation path
func move_to_position(target_pos: Vector2):
	agent.set_target_position(target_pos)
	is_moving_to_target = true
