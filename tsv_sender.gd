extends TextureRect

@onready
var tsv_sender: TsvSender = TsvSender.new()

var image: Image

@onready
var time: float = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	self.image = Image.create(100, 100, false, Image.FORMAT_RGBA8)
	self.image.fill(Color(1,1,1,1))
	
	var img_texture: ImageTexture = ImageTexture.new()
	img_texture.set_image(self.image)
	self.texture = img_texture
	
	# Set sending texture name (should be the same as the receiver name)
	self.tsv_sender.shared_texture_name = "gd_shared"
	
	# Set texture to write received texture to
	self.tsv_sender.set_texture(self.texture, Image.FORMAT_RGBA8)
	
	# Connect sender to Godot post_render signal
	self.tsv_sender.connect_to_frame_post_draw()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self.time += delta
	if self.time > 2.0:
		self.time = 0.0
	
	# Change the sending texture's color
	var col = self.time / 2.0
	self.image.fill(Color(col, col, col, 1.0))
	self.texture.set_image(self.image)
