extends Camera2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var cameraMoving = false
onready var width = ProjectSettings.get_setting('display/window/size/width') 
onready var height = ProjectSettings.get_setting('display/window/size/height')
# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
func _on_BottomArea_area_entered(_area):
	position.y += height

func _on_TopArea_area_entered(_area):
	position.y -= height
	
func _on_LeftArea_area_entered(_area):
	position.x -= width
	
func _on_RightArea_area_entered(_area):
	position.x += width
	

