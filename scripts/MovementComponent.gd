extends Node
class_name MovementComponent

@export var speed: float = 6.0
@export var acceleration: float = 10.0
@export var friction: float = 8.0

var character: CharacterBody3D

func _ready():
	# get parent character
	character = get_parent() as CharacterBody3D


func _physics_process(delta):

	var input_dir = Vector2.ZERO

	input_dir.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	input_dir.y = Input.get_action_strength("move_backward") - Input.get_action_strength("move_forward")

	input_dir = input_dir.normalized()

	var direction = (character.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()

	if direction:
		character.velocity.x = move_toward(character.velocity.x, direction.x * speed, acceleration)
		character.velocity.z = move_toward(character.velocity.z, direction.z * speed, acceleration)
	else:
		character.velocity.x = move_toward(character.velocity.x, 0, friction)
		character.velocity.z = move_toward(character.velocity.z, 0, friction)

	character.move_and_slide()
