extends Control

class_name FighterCell

signal cell_entered(cell: int)
signal cell_pressed(cell: int)
signal cell_released()

var cell_index: int = -1:
	set(value): cell_index = clamp(value, 0, 8)
var fighter: Fighter:
	set(value):
		fighter = value
#		_update_visuals()

var _style: StyleBoxFlat

func set_highlight(color: Color) -> void:
	_style.bg_color = color

func clear_highlight() -> void:
	_style.bg_color = Color.TRANSPARENT

func _ready() -> void:
	_style = StyleBoxFlat.new()
	_style.bg_color = Color.TRANSPARENT
	_style.border_color = Color.WHITE
	_style.set_border_width_all(2)
	_style.set_corner_radius_all(8)
	$Background.add_theme_stylebox_override("panel", _style)

#func _update_visuals() -> void:
	#match fighter.type:
		#Fighter.FighterType.ATTACKER: set_highlight(Color.YELLOW)
		#Fighter.FighterType.DEFENDER: set_highlight(Color.ORANGE)
		#Fighter.FighterType.HEALER: set_highlight(Color.GREEN)

func _gui_input(event: InputEvent) -> void:
	if not event is InputEventMouseButton:
		return
	
	if event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			cell_pressed.emit(cell_index)
		
		if event.is_released():
			cell_released.emit()

func _on_mouse_entered() -> void:
	cell_entered.emit(cell_index)
