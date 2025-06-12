extends Area2D

@onready var shop_ui: Panel = $Panel

@onready var buy_panel: Panel = $Panel2

@onready var buy_button: MenuButton = $Panel/MenuButton

@onready var cancel_button: MenuButton = $Panel/MenuButton2

@onready var player

@onready var buy_rice_button: Button = $Panel2/RICE

func _ready() -> void:
	shop_ui.visible = false
	buy_panel.visible = false
	buy_button.pressed.connect(_on_buy_pressed)
	cancel_button.pressed.connect(_on_cancel_pressed)
	buy_rice_button.pressed.connect(_on_buy_rice_pressed)

func _on_body_entered(body: Node2D) -> void:
	player = str(body.name)
	if body.name != "CharacterBody2D":
		shop_ui.visible = true
		print("body entered ",str(shop_ui))
		
		#process ORDER
		#-check desire
		#-check money
		
		
		

func _on_body_exited(body: Node2D) -> void:
	if body.name == "p1":
		shop_ui.visible = false
		buy_panel.visible = false
		print("body exited ",str(shop_ui))
		
func _on_buy_pressed() -> void:
	buy_panel.visible = true
	print("Buy pressed — opening Buy Panel")
	
func _on_cancel_pressed() -> void:
	shop_ui.visible = false
	buy_panel.visible = false  # Optional: just in case
	print("Cancel pressed — closing Shop Panel")

func _on_buy_rice_pressed() -> void:
	Game_Manager.add_item_to(str(player),"Rice", 1, "High")
	var rice_data = Game_Manager.get_item_from(str(player),"Rice")
	print("Another Rice purchased. Total now: %d" % rice_data["count"])
	print(rice_data["quality"])
	Game_Manager.name()
