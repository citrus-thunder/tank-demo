extends KinematicBody2D

export var speed = 35
export var bounces = 2
export var fuse = 5
var moving = true
var current_fuse
var current_bounces
var heading
var dir
signal bullet_destroyed

func _ready():
	heading = get_node("Heading")
	current_fuse = float(fuse)/10
	current_bounces = bounces
	speed = float(speed)/100
	set_fixed_process(true)
	dir = get_global_pos() - heading.get_global_pos()

func _fixed_process(delta):
	#explode if bounce attempted beyond bounce count (e.g. hit wall after final bounce)
	if(current_fuse <= 0):
		explode()
	#start fuse if bounce limit reached
	if(current_bounces < 1):
		current_fuse -= delta

	#var dir = get_global_pos() - heading.get_global_pos()
	var motion = move(dir*speed)

	if(is_colliding()):
		var collider = get_collider()
		var name = collider.get_name()
		if(name=="Player" or name =="Enemy"): explode()
		else: #bounce
			if(current_bounces <= 0): explode()
			current_bounces -= 1
			var normal = get_collision_normal()
			motion = normal.reflect(motion)
			dir = normal.reflect(dir) # I don't understand why we need to reflect both motion and dir, but it works.
			var facing = get_global_pos() - motion
			set_global_rot(motion.angle())

	move(motion)

func explode():
	emit_signal("bullet_destroyed")
	queue_free()