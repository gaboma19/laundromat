extends KinematicBody2D

signal interact

export var speed = 400
var screen_size
var velocity
var direction

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	velocity = Vector2.ZERO # The player's movement vector.
	$AnimatedSprite.play()
	
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

	move_and_collide(velocity * delta)
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)

	if velocity == Vector2.ZERO:
		if direction == "down":
			$AnimatedSprite.animation = "idle_down"
		elif direction == "up":
			$AnimatedSprite.animation = "idle_up"
		elif direction == "left":
			$AnimatedSprite.animation = "idle_left"
		elif direction == "right":
			$AnimatedSprite.animation = "idle_right"
		else:
			$AnimatedSprite.animation = "idle_down"
	elif velocity.x > 0:
		$AnimatedSprite.animation = "walk_right"
		direction = "right"
	elif velocity.x < 0:
		$AnimatedSprite.animation = "walk_left"
		direction = "left"
	elif velocity.y < 0:
		$AnimatedSprite.animation = "walk_up"
		direction = "up"
	elif velocity.y > 0:
		$AnimatedSprite.animation = "walk_down"
		direction = "down"
		
func _input(event):
	if event.is_action_pressed("interact"):
		pass
