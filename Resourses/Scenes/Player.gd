extends KinematicBody2D

var stopSpeed = PlayerStats.stopSpeed
var maxSpeed = PlayerStats.maxSpeed
var acceleration = PlayerStats.acceleration
var jumpSpeed = PlayerStats.jumpSpeed
var canNoGravity = PlayerStats.canNoGravity
var noGravityMax = PlayerStats.noGravityMax
var noGravityTimer = 0
var speed = 0
var velocity = Vector2()
var airTime = 0
var floorState = false
var noGravity = false


onready var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func update_status():
	stopSpeed = PlayerStats.stopSpeed
	maxSpeed = PlayerStats.maxSpeed
	acceleration = PlayerStats.acceleration
	jumpSpeed = PlayerStats.jumpSpeed


func _physics_process(delta):
	update_status()
	
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
	
	if !noGravity:
		velocity.y += gravity * delta
		velocity.y += airTime
	else:
		noGravityTimer += 1
		if noGravityTimer >= noGravityMax:
			noGravity = false
			airTime = 0
	velocity = move_and_slide(velocity, Vector2.UP)
	
	if is_on_floor():
		if  noGravityTimer > 0:
			noGravityTimer -= 1
		airTime = 0
	elif airTime < 100:
		airTime += 1
	if Input.is_action_just_pressed("PlayerUp"):
		if is_on_floor():
			velocity.y = -jumpSpeed
		elif !noGravity and noGravityTimer < noGravityMax:
			noGravity = true
	if Input.is_action_just_released("PlayerUp"):
		if noGravity:
			noGravity = false
			airTime = 0
