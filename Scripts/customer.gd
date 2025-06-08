extends CharacterBody2D
@export var speed := 120.0  # speed for both input & pathfinding
@onready var p_2: CharacterBody2D = $"."
@onready var animated_sprite = $AnimatedSprite2D
@onready var agent = $NavigationAgent2D
@onready var player: CharacterBody2D = $"../p1"
@onready var tile_map: TileMap = $"../NavigationRegion2D/TileMap"

var is_moving_to_target := false


func _ready():
	# The NavigationAgent2D automatically uses the parent node's navigation map
	# No need to manually set it in Godot 4
	pass

func _physics_process(delta):
	if Input.is_action_pressed("space"):
			#p_2.move_to_position(player.global_position)
			for x in tile_map.get_used_cells(0):
				var data = tile_map.get_cell_tile_data(0, x)
				print(data)
				if data and data.get_custom_data("type") == "Shop":
					var target_global_pos = tile_map.to_global(tile_map.map_to_local(x))
					p_2.move_to_position(target_global_pos)
					break
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
