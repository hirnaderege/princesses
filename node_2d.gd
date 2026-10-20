extends Node2D

var currentLine: Line2D
var brushColor: Color = Color.HOT_PINK
var brushWidth: float = 14.0

@onready var palette: HBoxContainer = $Palette

func _ready():
	$Palette/pink.pressed.connect(func(): brushColor = Color.HOT_PINK)
	$Palette/purple.pressed.connect(func(): brushColor = Color.MEDIUM_PURPLE)
	$Palette/blue.pressed.connect(func(): brushColor = Color.DEEP_SKY_BLUE)
	$Palette/yello.pressed.connect(func(): brushColor = Color.GOLD)
	$Palette/eraser.pressed.connect(func(): brushColor = Color.WHITE)

# comment
	
func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			if palette.get_global_rect().has_point(event.position):
				return
			currentLine = Line2D.new()
			currentLine.default_color = brushColor
			currentLine.width = brushWidth
			currentLine.begin_cap_mode = Line2D.LINE_CAP_ROUND
			currentLine.end_cap_mode = Line2D.LINE_CAP_ROUND
			currentLine.joint_mode = Line2D.LINE_JOINT_ROUND
			add_child(currentLine)
			currentLine.add_point(event.position)
		else:
			currentLine = null
	elif event is InputEventMouseMotion and currentLine:
		currentLine.add_point(event.position)
