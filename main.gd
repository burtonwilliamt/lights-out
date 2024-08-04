extends Node2D

@export var on_theme: Theme
@export var off_theme: Theme

var cells: Array[Array]
var buttons: Array[Array]
var width = 5
var height = 5


func update_buttons():
	for x in width:
		for y in height:
			var b: Button = buttons[x][y]
			b.text = str(cells[x][y])
			if cells[x][y]:
				b.theme = on_theme
			else:
				b.theme = off_theme

func toggle_cell(x: int, y: int):
	for offset in [Vector2(-1,0), Vector2(0,-1), Vector2(0,0), Vector2(1,0), Vector2(0,1)]:
		var lx = x + offset.x
		var ly = y + offset.y
		if lx < 0 or lx >= width:
			continue
		if ly < 0 or ly >= height:
			continue
		cells[lx][ly] = !cells[lx][ly]
	update_buttons()

# Called when the node enters the scene tree for the first time.
func _ready():
	# Initialize world state.
	for x in width:
		cells.append([])
		for y in height:
			cells[x].append(false)

	var vbox = VBoxContainer.new()
	for x in width:
		buttons.append([])
		var hbox = HBoxContainer.new()
		vbox.add_child(hbox)
		for y in height:
			var b = Button.new()
			b.custom_minimum_size = Vector2(64,64)
			b.pressed.connect(self.toggle_cell.bind(x, y))
			buttons[x].append(b)
			hbox.add_child(b)
	update_buttons()
	self.add_child(vbox)


