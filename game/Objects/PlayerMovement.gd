extends KinematicBody2D

var speed = 0
export var move_speed = 5
export var rotate_speed = 1
export(PackedScene) var bullet 
export var max_bullets = 2
var current_bullets
var cannon
var bullet_spawn
var current_speed
func _ready():

	rotate_speed = float(rotate_speed) / 20
	move_speed = float(move_speed) / 100
	current_speed = move_speed
	current_bullets = max_bullets
	cannon = get_node("sprite_cannon")
	bullet_spawn = get_node("sprite_cannon/bullet_spawn")
	set_process_input(true)
	set_fixed_process(true)

func _input(event):
	if(event.is_action_released("action_primary")):
		if(current_bullets >= 1):
			fire()

func _fixed_process(delta):
	speed = 0
	current_speed = move_speed
	#TODO: put input sections into input function.
	if(Input.is_action_pressed("move_forward")):
		speed = 1

	if(Input.is_action_pressed("move_reverse")):
		speed = -1
		current_speed = float(move_speed)/2
	if(Input.is_action_pressed("move_right")):
		set_rot(get_rot() + (rotate_speed * -1))

	if(Input.is_action_pressed("move_left")):
		set_rot(get_rot() + rotate_speed)

	if(speed != 0):
		var hpos = get_node("Heading").get_global_pos()
		var destination = get_global_pos() - hpos
		move(destination * (current_speed * speed))
		
	cannon.set_rot(get_angle_to(get_global_mouse_pos()))
	
func bullet_restore():
	if(current_bullets < max_bullets): current_bullets += 1
	print("Bullet restored! You currently have "+str(current_bullets)+" bullets")
func fire():
	current_bullets -= 1
	var node = bullet.instance()
	node.connect("bullet_destroyed",self,"bullet_restore")
	node.set_pos(bullet_spawn.get_global_pos())
	node.set_rot(bullet_spawn.get_global_rot())
	get_tree().get_root().add_child(node)
	