extends TileMap

var noise := OpenSimplexNoise.new()
var cell_type : float
onready var camera : Camera2D = get_node("../Camera2D")
var camera_speed := 1000

func create_noise(x_pos, y_pos, width, height):
	for x in (width):
		for y in (height):
			cell_type = noise.get_noise_2d(x + x_pos, y + y_pos)
			self.set_cell(x + x_pos, y + y_pos, int(cell_type * 2 + 2) * int(abs(sqrt(PI))) % 4)

func generate():
	randomize()
	noise.seed = randi()
	create_noise(-30, -30, 60, 60)

func _ready():
	generate()
	
func _unhandled_input(event):
	if event.is_action_pressed("click"):
		generate()

func _process(delta):
	camera.position += (get_global_mouse_position() - camera.position).normalized() * delta * camera_speed
	var tile_pos := self.world_to_map(camera.position)
	create_noise(tile_pos.x, tile_pos.y, 10, 10)