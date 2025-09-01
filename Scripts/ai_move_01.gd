# agent_mover.gd
extends NavigationAgent2D

@export var speed: float = 100.0

func _ready():
	set_navigation_map(get_world_2d().navigation_map)

func _physics_process(delta):
	if is_navigation_finished():
		return

	var next_path_point = get_next_path_position()
	var direction = (next_path_point - global_position).normalized()
	var velocity = direction * speed

	# Move the parent (the actual Player)
	if owner:
		owner.global_position += velocity * delta

	set_velocity(velocity)

	if global_position.distance_to(next_path_point) < 4.0:
		advance()
