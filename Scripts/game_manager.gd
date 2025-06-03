extends Node2D

# Singleton: This will persist across scenes
class_name GameManager

# Dictionary to store inventory
var inventory := {}

# Called when the game starts
func _ready():
	# Example item: Rice
	add_item("Rice", 10, "High")

# Adds or updates an item in inventory
func add_item(name: String, count: int, quality: String) -> void:
	var price := get_price_based_on_quality(quality)
	inventory[name] = {
		"count": count,
		"quality": quality,
		"price": price
	}

# Returns price based on quality
func get_price_based_on_quality(quality: String) -> int:
	match quality:
		"Low":
			return 30
		"Medium":
			return 60
		"High":
			return 100
		_:
			return 0

# Returns item data
func get_item(name: String) -> Dictionary:
	return inventory.get(name, {})

# Called when the node enters the scene tree for the first time.
