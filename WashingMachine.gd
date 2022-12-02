extends StaticBody2D

var is_reachable = false

func _ready():
	pass
	

func toggle_animation():
	if $AnimatedSprite.playing:
		$AnimatedSprite.stop()
	else:
		$AnimatedSprite.play()
		
func _process(delta):
	if is_reachable == true && Input.is_action_just_pressed("interact"):
		toggle_animation()

func _on_InteractionArea_body_entered(body):
	is_reachable = true
	print("who's there? %s" % body)
	print($InteractionArea)

func _on_InteractionArea_body_exited(body):
	is_reachable = false
	print("are you still there? %s" % body)
	print($InteractionArea)
