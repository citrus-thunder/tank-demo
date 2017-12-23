extends Navigation2D

var path = []
var font = null
var drawTouch = false
var touchPos = Vector2(0,0)
var closestPos = Vector2(0,0)
export var testEnabled = false

func _ready():
	font = load("res://ubuntu.fnt")
	if(testEnabled):
		set_process_input(true)

func _draw():
   if(path.size()):
      for i in range(path.size()):
         draw_string(font,Vector2(path[i].x,path[i].y - 20),str(i+1))
         draw_circle(path[i],10,Color(1,1,1))
      
      if(drawTouch):
         draw_circle(touchPos,10,Color(0,1,0))  
         draw_circle(closestPos,10,Color(0,1,0))
   

func _input(event):
   if(event.type == InputEvent.MOUSE_BUTTON):
      if(event.button_index == 1):
         if(path.size()):
            touchPos = Vector2(event.x,event.y)
            drawTouch = true
            closestPos = get_closest_point(touchPos)
            print("Drawing touch")
            update()
            
      if(event.button_index == 2):
         path = get_simple_path(get_node("/root/Game/Player").get_pos(),Vector2(
                event.x,event.y))
         update()