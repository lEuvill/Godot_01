extends Area2D

@onready var game_manager: GameManager = %Game_Manager


func _on_body_entered(body: Node2D) -> void:
	var rice_data = game_manager.get_item("Rice")
	print(rice_data["count"])  # prints 10
	print(rice_data["price"])  # prints 100 (if quality is High)

	print("Interact")
	
