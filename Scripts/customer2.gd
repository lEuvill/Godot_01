extends CharacterBody2D
@export var speed := 120.0  # speed for both input & pathfinding
@onready var p_2: CharacterBody2D = $"."
@onready var animated_sprite = $AnimatedSprite2D
@onready var agent = $NavigationAgent2D
@onready var player: CharacterBody2D = $"../Neil"
@onready var tile_map: TileMapLayer = $"../TileMapLayer"


var is_moving_to_target := false
var matching_positions

func _ready():
	var tile_id_to_find = 2
	




func _physics_process(delta):
	if Input.is_action_pressed("space"):
			
			pass
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
		
		# The NavigationAgent2D automatically advances when close enoug
	else:
		velocity = Vector2.ZERO
		animated_sprite.stop()

# Helper function to play animation based on movement direction
func play_animation(direction: Vector2):
	# Assuming 'direction' is isometric movement vector (already transformed)
	if direction.x > 0 and direction.y < 0:
		animated_sprite.play("up")
		animated_sprite.flip_h = false
	elif direction.x < 0 and direction.y > 0:
		animated_sprite.play("down")
		animated_sprite.flip_h = false
	elif direction.x > 0 and direction.y > 0:
		animated_sprite.play("right")
	elif direction.x < 0 and direction.y < 0:
		animated_sprite.play("left")


# Public method to move player to a target position via navigation path
func move_to_position(target_pos: Vector2):
	agent.set_target_position(target_pos)
	is_moving_to_target = true
