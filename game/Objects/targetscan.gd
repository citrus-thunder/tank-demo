extends RayCast2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
signal player_targeted

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	set_enabled(true)
	set_fixed_process(true)

func _fixed_process(delta):
	if(is_colliding()):
		var target = get_collider()
		if(target.get_name() == "Player"):
			emit_signal("player_targeted")
