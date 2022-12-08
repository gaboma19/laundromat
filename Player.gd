extends KinematicBody2D

signal interact

export var speed = 400
var screen_size
var velocity
var direction
onready var animation = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	velocity = Vector2.ZERO # The player's movement vector.
	
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed

	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)
	
	if velocity == Vector2.ZERO:
		$AnimationTree.get("parameters/playback").travel("idle")
	else:
		$AnimationTree.get("parameters/playback").travel("walk")
		$AnimationTree.set("parameters/idle/blend_position", velocity)
		$AnimationTree.set("parameters/walk/blend_position", velocity)
		move_and_collide(velocity * delta)
		
func _input(event):
	if event.is_action_pressed("interact"):
		pass
