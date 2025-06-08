extends Area2D

# Add these export variables for custom shop data
@export var shop_type: String = "general_store"
@export var shop_name: String = "Village Shop"
@export var available_items: Array[String] = ["Rice", "Wheat", "Corn"]
@export var shop_keeper_name: String = "Merchant"
@export var shop_level: int = 1

@onready var game_manager: GameManager = %Game_Manager
@onready var shop_ui: Panel = $Panel

func _ready() -> void:
	shop_ui.visible = false
	print("Shop initialized: ", shop_name, " (", shop_type, ")")

func _on_body_entered(body: Node2D) -> void:
	if body.name == "p1":
		# Use your custom shop data
		print("Entered ", shop_name, " - Type: ", shop_type)
		print("Available items: ", available_items)
		
		# You can customize behavior based on shop type
		match shop_type:
			"rice_shop":
				display_rice_shop()
			"weapon_shop":
				display_weapon_shop()
			"general_store":
				display_general_shop()
		
		shop_ui.visible = true

func _on_body_exited(body: Node2D) -> void:
	if body.name == "p1":
		shop_ui.visible = false
		print("Exited ", shop_name)

# Custom functions based on shop type
func display_rice_shop():
	var rice_data = Game_Manager.get_item("Rice")
	print("Rice shop - Count: ", rice_data["count"], " Price: ", rice_data["price"])

func display_weapon_shop():
	print("Welcome to the weapon shop!")
	# Show weapon-specific items

func display_general_shop():
	print("Welcome to the general store!")
	# Show all available items

# Helper function to get all shop data
func get_shop_info():
	return {
		"type": shop_type,
		"name": shop_name,
		"items": available_items,
		"keeper": shop_keeper_name,
		"level": shop_level
	}
