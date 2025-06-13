extends CharacterBody2D

@onready var tile_map: TileMapLayer = $"../../TileMapLayer"

@export var speed := 80  # speed for both input & pathfinding
@onready var p_2: CharacterBody2D = $"."
@onready var animated_sprite = $AnimatedSprite2D
@onready var agent = $NavigationAgent2D

var is_moving_to_target := false
var matching_positions
var blocked_by_object := false

func _ready(): 
	var tile_id_to_find = 3
	matching_positions = get_tiles_with_id(tile_id_to_find)

	if matching_positions.is_empty():
		push_error("No matching tiles found!")
		return

	move_to_position(matching_positions[0])

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
	move_to_position(matching_positions[0])
	if Input.is_action_pressed("space"):
		print(matching_positions[0])
		move_to_position(matching_positions[0])

	if is_moving_to_target:
		if agent.is_navigation_finished():
			is_moving_to_target = false
			velocity = Vector2.ZERO
			animated_sprite.stop()
			return

		var next_point = agent.get_next_path_position()
		var direction = (next_point - global_position).normalized()
		var new_velocity = direction * speed
		_on_navigation_agent_2d_velocity_computed(new_velocity)
		move_and_slide()
		play_animation(direction)
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


func _on_navigation_agent_2d_velocity_computed(safe_velocity: Vector2) -> void:
	velocity = safe_velocity
	pass # Replace with function body.
