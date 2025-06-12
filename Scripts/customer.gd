extends CharacterBody2D
@export var speed := 120.0  # speed for both input & pathfinding
@onready var p_2: CharacterBody2D = $"."
@onready var animated_sprite = $AnimatedSprite2D
@onready var agent = $NavigationAgent2D
@onready var player: CharacterBody2D = $"../Neil"
@onready var tile_map: TileMapLayer = $"../NavigationRegion2D/TileMapLayer"

var is_moving_to_target := false
var matching_positions

func _ready():
	var tile_id_to_find = 2
	matching_positions = get_tiles_with_id(tile_id_to_find)
	
	for global_pos in matching_positions:
		print("Found tile with ID 2 at: ", global_pos)

func get_tiles_with_id(tile_id: int) -> Array:
	var result = []
	var used_cells = tile_map.get_used_cells()
	print("Used cells:", used_cells)
	print("Currently in Get tiles func")

	for cell in used_cells:
		var id = tile_map.get_cell_alternative_tile(cell)
		print("ID:", id)
		if id == tile_id:
			var local_pos = tile_map.map_to_local(cell)
			var global_pos = tile_map.to_global(local_pos)
			result.append(global_pos)

	print(result)
	return result


func _physics_process(delta):
	if Input.is_action_pressed("space"):
			print(matching_positions[0])
			p_2.move_to_position(matching_positions[0])
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
