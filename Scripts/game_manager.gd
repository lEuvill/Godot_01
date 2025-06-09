extends Node2D

# Singleton: This will persist across scenes
class_name GameManager

# Dictionary to store inventory
var inventory := {}
var entity := {}
var inventories := {}  # e.g. { "player": {}, "npc_1": {}, "enemy_2": {} }
# Called when the game starts
func _ready():
	# Example item: Rice
	#add_item_to("p1","Rice", 10, "High")
	pass

# Adds or updates an item in inventory


func add_item_to(character_id: String, item_name: String, count: int, quality: String) -> void:
	if !inventories.has(character_id):
		inventories[character_id] = {}
	var inventory = inventories[character_id]

	if inventory.has(item_name):
		inventory[item_name]["count"] += count
	else:
		inventory[item_name] = {
			"count": count,
			"quality": quality,
			"price": get_price_based_on_quality(quality)
		}

func name():
	print(inventories)

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
	
func get_item_from(character_id: String, item_name: String) -> Dictionary:
	if !inventories.has(character_id):
		return {}
	return inventories[character_id].get(item_name, {})

# Called when the node enters the scene tree for the first time.
