extends GridContainer

const FighterCellScene = preload("res://scenes/fighter_cell.tscn")

const VALID_LINES: Array[Array] = [
	[0, 1, 2], [3, 4, 5], [6, 7, 8], # grid rows
	[0, 3, 6], [1, 4, 7], [2, 5, 8], # grid columns
	[0, 4, 8], [2, 4, 6]             # grid diagonals
]
const LINE_COLORS: Array[Color] = [Color.YELLOW, Color.ORANGE, Color.GREEN]

var is_selecting: bool = false
var select_start: int = -1
var select_end: int = -1
var selected_lines: Array[Array] = []

func start_select() -> void:
	is_selecting = true
	select_start = -1
	select_end = -1

func get_cell(index: int) -> FighterCell:
	return get_child(index) as FighterCell

func get_fighters_in_line(line: int) -> Array[Fighter]:
	var fighters: Array[Fighter] = []
	
	for fighter_cell in selected_lines[line]:
		fighters.append(get_cell(fighter_cell).fighter)
	
	return fighters

func select_line() -> Array:
	if not select_start == select_end and selected_lines.size() < 3:
		var possible_lines = VALID_LINES.filter(func(line): return line.has(select_start) and line.has(select_end))
		
		if possible_lines.size() <= 0:
			return []
		
		var selected_line = possible_lines.get(0)
		
		if selected_lines.has(selected_line):
			return []
		
		selected_lines.append(selected_line)
		return selected_line
	
	return []

func highlight_line(line: Array, color: Color) -> void:
	for cell_index in line:
		get_cell(cell_index).set_highlight(color)

func highlight_lines() -> void:
	for cell_index in 9:
		get_cell(cell_index).clear_highlight()
	for line in min(selected_lines.size(), 3):
		highlight_line(selected_lines[line], LINE_COLORS[line])

func _ready() -> void:
	for i in 9:
		var cell = FighterCellScene.instantiate()
		cell.cell_index = i
		add_child(cell)
		
		cell.cell_entered.connect(_on_cell_entered)
		cell.cell_pressed.connect(_on_cell_pressed)
		cell.cell_released.connect(_on_cell_released)
		
		var fighter_type_rand = randi_range(0, 2)
		match fighter_type_rand:
			0: cell.fighter = Attacker.new()
			1: cell.fighter = Defender.new()
			2: cell.fighter = Healer.new()

func _on_cell_entered(cell_index: int) -> void:
	select_end = cell_index
	print("Mouse last entered cell ", cell_index)
	print("Selecting: ", is_selecting)

func _on_cell_pressed(cell_index: int) -> void:
	start_select()
	select_start = cell_index
	print("Left mouse button was pressed in cell ", cell_index)

func _on_cell_released() -> void:
	is_selecting = false
	select_line()
	highlight_lines()
	print("Left mouse button was released")
	print("Selected lines: ", selected_lines)
