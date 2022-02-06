extends Node2D

var frame = 0
##################################
var map = []
#         0=ocean,1=land,2=mountain
##################################
##################################


# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	mapgen()

func mapgen():
	map.clear()
	
	var noise = OpenSimplexNoise.new()
	noise.seed = randi()
	noise.octaves = 4
	noise.period = 20.0
	noise.persistence = 0.8
	
	for x in 100: 
		map.append([])
		for y in 100:
			var terrain = 0
			if noise.get_noise_2d(x,y)+0.5 > 0.95:
				terrain = 2
			elif noise.get_noise_2d(x,y)+0.5 > 0.7:
				terrain = 1
			map[x].append([terrain])

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	frame+=1
	if frame%60==0:
		mapgen()
	
	

func _draw():
	for x in 100: 
		for y in 100:
			var midpoint = Vector2(x*32,y*32)
			
			if map[x][y][0]==1:
				draw_rect(Rect2(midpoint+Vector2(-8,-8),midpoint+Vector2(8,8)),Color.green)
			if map[x][y][0]==2:
				draw_circle(midpoint,10,Color.yellow)
