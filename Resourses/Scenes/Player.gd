extends KinematicBody2D

var stopSpeed = PlayerStats.stopSpeed
var maxSpeed = PlayerStats.maxSpeed
var acceleration = PlayerStats.acceleration
var jumpSpeed = PlayerStats.jumpSpeed
var maxJumps = PlayerStats.maxJumps
var speed = 0
var velocity = Vector2()
var storedJumps = 0
var airTime = 0
var floorState = false


onready var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func update_status():
	stopSpeed = PlayerStats.stopSpeed
	maxSpeed = PlayerStats.maxSpeed
	acceleration = PlayerStats.acceleration
	jumpSpeed = PlayerStats.jumpSpeed
	maxJumps = PlayerStats.maxJumps	


func _physics_process(delta):
	
	
	if Input.is_action_pressed("PlayerRight"):
		if velocity.x < maxSpeed:
			velocity.x += acceleration
		else:
			velocity.x = maxSpeed
	elif velocity.x > 0:
		if velocity.x > stopSpeed:
			velocity.x -= stopSpeed
		else:
			velocity.x = 0
		
	if Input.is_action_pressed("PlayerLeft"):
		if velocity.x > -maxSpeed:
			velocity.x -= acceleration
		else:
			velocity.x = -maxSpeed
	elif velocity.x < 0:
		if velocity.x < stopSpeed:
			velocity.x += stopSpeed
		else:
			velocity.x = 0
	

	# Vertical movement code. Apply gravity.
	velocity.y += gravity * delta
	velocity.y += airTime
	#if 0 < velocity.y and velocity.y < 1000:
	#	velocity.y += velocity.y / 10
	# Move based on the velocity and snap to the ground.
	velocity = move_and_slide(velocity, Vector2.UP)
	
	floorState = is_on_floor()
	if floorState:
		airTime = 0
		if storedJumps < maxJumps:
			storedJumps = maxJumps
	else:
		if airTime < 100:
			airTime += 1
	if Input.is_action_just_pressed("PlayerUp"):
		if storedJumps > 0 or floorState:
			velocity.y = -jumpSpeed
			if storedJumps > 0 and !floorState:
				storedJumps -= 1
				airTime -= 10
