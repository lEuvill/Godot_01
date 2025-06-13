extends Node2D

@export var customer_scene: PackedScene
@export var spawn_point: Vector2
@export var exit_point: Vector2
@export var spawn_interval := 2.0  # in seconds

@onready var timer: Timer = $Timer

func _ready():
	timer.wait_time = spawn_interval
	timer.timeout.connect(spawn_customer)
	timer.start()

func spawn_customer():
	if not customer_scene:
		push_error("Customer scene not assigned!")
		return

	var customer = customer_scene.instantiate()
	add_child(customer)
	print("spawned")

	
