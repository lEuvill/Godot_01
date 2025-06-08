extends Area2D

@onready var game_manager: GameManager = %Game_Manager

@onready var shop_ui: Panel = $Panel

func _ready() -> void:
	shop_ui.visible = false
	
	
	

func _on_body_entered(body: Node2D) -> void:
	if body.name == "p1":
		var rice_data = Game_Manager.get_item("Rice")
		print(rice_data["count"])  # prints 10
		print(rice_data["price"])  # prints 100 (if quality is High)

		
		shop_ui.visible = true
		print("body entered ",str(shop_ui))

func _on_body_exited(body: Node2D) -> void:
	if body.name == "p1":
		shop_ui.visible = false
		print("body exited ",str(shop_ui))
