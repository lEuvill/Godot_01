extends Camera2D

@export var edge_scroll_margin : int = 20
@export var scroll_speed : float = 600.0
@export var drag_speed : float = 1.0
@export var zoom_speed : float = 0.1
@export var min_zoom : float = 0.5
@export var max_zoom : float = 2.0

var dragging : bool = false
var drag_button : int = 0
var last_mouse_position : Vector2

func _ready():
	position_smoothing_enabled = true
	position_smoothing_speed = 5.0

func _process(delta):
	var viewport_size = get_viewport_rect().size
	var mouse_pos = get_viewport().get_mouse_position()
	var direction = Vector2.ZERO

	if mouse_pos.x <= edge_scroll_margin:
		direction.x = -1
	elif mouse_pos.x >= viewport_size.x - edge_scroll_margin:
		direction.x = 1

	if mouse_pos.y <= edge_scroll_margin:
		direction.y = -1
	elif mouse_pos.y >= viewport_size.y - edge_scroll_margin:
		direction.y = 1

	# Edge scrolling
	if direction != Vector2.ZERO:
		position += direction.normalized() * scroll_speed * delta

	# Dragging
	if dragging:
		var mouse_delta = last_mouse_position - mouse_pos
		position += mouse_delta * drag_speed
		last_mouse_position = mouse_pos

func _unhandled_input(event):
	if event is InputEventMouseButton:
		

		if event.button_index == MOUSE_BUTTON_MIDDLE:
			if event.pressed:
				dragging = true
				drag_button = MOUSE_BUTTON_MIDDLE
				last_mouse_position = get_viewport().get_mouse_position()
			else:
				if drag_button == MOUSE_BUTTON_MIDDLE:
					dragging = false

		# Zoom with mouse wheel
		elif event.button_index == MOUSE_BUTTON_WHEEL_UP and event.pressed:
			zoom_camera(zoom_speed)
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN and event.pressed:
			zoom_camera(-zoom_speed)

func zoom_camera(amount: float):
	var new_zoom = zoom + Vector2(amount, amount)
	new_zoom.x = clamp(new_zoom.x, min_zoom, max_zoom)
	new_zoom.y = clamp(new_zoom.y, min_zoom, max_zoom)
	zoom = new_zoom
