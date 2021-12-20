extends Node

var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func random_int(var maxInt := 0, var minInt := 0):
	rng.randomize()
	return rng.randi_range(minInt,maxInt)
	
func random_probability(var prob := 100.0):
	rng.randomize()
	var result = rng.randf() * 100.0
	if result <= prob:
		return true
	else:
		return false
	
func random_cordinate(maxV := 1, minV := 0):
	var cord = Vector2()
	cord.x = random_int(maxV, minV)
	cord.y = random_int(maxV, minV)
	return cord

func random_room_type(var prob := 30.0):
	var roomType = 0
	
	if random_probability(prob):
		roomType += 1
	if random_probability(prob):
		roomType += 2
	if random_probability(prob):
		roomType += 4
	if random_probability(prob):
		roomType += 8
		
	return roomType
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
