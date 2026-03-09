extends Camera3D

@export var mouse_sensitivity: float = 0.003
@export var min_pitch: float = -40.0
@export var max_pitch: float = 60.0

var spring_arm: SpringArm3D
var player: CharacterBody3D
var pitch: float = 0.0


func _ready():
	spring_arm = get_parent()
	player = spring_arm.get_parent()
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _input(event):

	if event is InputEventMouseMotion:

		# rotate player horizontally
		player.rotate_y(-event.relative.x * mouse_sensitivity)

		# vertical camera rotation
		pitch -= event.relative.y * mouse_sensitivity * 100
		pitch = clamp(pitch, min_pitch, max_pitch)

		spring_arm.rotation_degrees.x = pitch
