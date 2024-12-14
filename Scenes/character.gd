extends CharacterBody2D

const SPEED = 300.0
@onready var _animated_sprite = $AnimatedSprite2D
@onready var _camera = $Camera2D

func _ready() -> void:
	_animated_sprite.play("idle_down")
	_camera.make_current()

func _process(delta: float) -> void:
	get_input()

func get_input() -> void:
	var input_vector = Vector2.ZERO

	if Input.is_action_pressed("left"):
		input_vector.x -= 1
	if Input.is_action_pressed("right"):
		input_vector.x += 1
	if Input.is_action_pressed("up"):
		input_vector.y -= 1
	if Input.is_action_pressed("down"):
		input_vector.y += 1

	if input_vector != Vector2.ZERO:
		if input_vector.x < 0:
			_animated_sprite.play("left")
		elif input_vector.x > 0:
			_animated_sprite.play("right")
		elif input_vector.y < 0:
			_animated_sprite.play("up")
		elif input_vector.y > 0:
			_animated_sprite.play("down")
	else:
		if Input.is_action_just_released("left"):
			_animated_sprite.play("idle_left")
		elif Input.is_action_just_released("right"):
			_animated_sprite.play("idle_right")
		elif Input.is_action_just_released("up"):
			_animated_sprite.play("idle_up")
		elif Input.is_action_just_released("down"):
			_animated_sprite.play("idle_down")

	input_vector = input_vector.normalized() * SPEED
	velocity = input_vector

func _physics_process(delta: float) -> void:
	move_and_slide()
