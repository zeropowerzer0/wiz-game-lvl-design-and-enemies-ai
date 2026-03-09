extends CharacterBody3D

@export var speed := 7.0
@export var jump_velocity := 4.5
@export var mouse_sensitivity := 0.002

@onready var spring_arm_3d: SpringArm3D = $SpringArm3D


var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var mouse_captured := true
var pitch := 0.0


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _input(event):

	if event is InputEventMouseMotion and mouse_captured:
		
		# rotate player left/right
		rotate_y(-event.relative.x * mouse_sensitivity)

		# rotate camera up/down
		pitch -= event.relative.y * mouse_sensitivity
		pitch = clamp(pitch, deg_to_rad(-85), deg_to_rad(85))

		spring_arm_3d.rotation.x = pitch


	if event.is_action_pressed("ui_cancel"):
		mouse_captured = !mouse_captured
		
		if mouse_captured:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)


func _physics_process(delta):

	# gravity
	if not is_on_floor():
		velocity.y -= gravity * delta

	# movement input
	var input_dir = Input.get_vector("move_left","move_right","move_forward","move_backward")

	var direction = (transform.basis * Vector3(input_dir.x,0,input_dir.y)).normalized()

	if direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	else:
		velocity.x = move_toward(velocity.x,0,speed)
		velocity.z = move_toward(velocity.z,0,speed)

	move_and_slide()
