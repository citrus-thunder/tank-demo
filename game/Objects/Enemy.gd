extends KinematicBody2D

var speed = 0
export var move_speed = 5
export var rotate_speed = 1
export(PackedScene) var bullet 
var cannon
var bullet_spawn
var current_speed
export var cooldown = 3
var current_cooldown
var bullet_cooldown = false

func _ready():
	rotate_speed = float(rotate_speed) / 20
	move_speed = float(move_speed) / 100
	current_speed = move_speed
	current_cooldown = cooldown
	cannon = get_node("sprite_cannon")
	bullet_spawn = get_node("sprite_cannon/bullet_spawn")
	set_process(true)

func _process(delta):
	if(bullet_cooldown):
		current_cooldown -= delta
		if(current_cooldown <= 0): 
			bullet_cooldown=false
			current_cooldown = cooldown
	if(check_los() && bullet_cooldown != true):
		fire()
	

func check_los():
	pass

func fire():
	bullet_cooldown=true
	var node = bullet.instance()
	node.set_pos(bullet_spawn.get_global_pos())
	node.set_rot(bullet_spawn.get_global_rot())
	get_tree().get_root().add_child(node)



func _on_targetscan_player_targeted():
	pass # replace with function body
