extends CharacterBody2D

@onready var _animated_sprite = $AnimatedSprite2D
@onready var audio = $AudioStreamPlayer

@export var speed = 100
var gravity = 5
var jumpspeed = -200
var red_area = false

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity
	else:
		velocity.y = 0
	
	if Input.is_action_just_pressed("move_up") and is_on_floor():
		velocity.y = jumpspeed
	
	if Input.is_action_pressed("move_left"):
		velocity.x = -speed
	elif Input.is_action_pressed("move_right"):
		velocity.x = speed
	else:
		velocity.x = 0
	move_and_slide()
	
func _process(_delta):
	var is_moving_right = Input.is_action_pressed("move_right")
	var is_jumping = not is_on_floor()
	var is_moving_left = Input.is_action_pressed("move_left")

	if is_jumping:
		if red_area:
			_animated_sprite.play("Jump_red")
		else:
			_animated_sprite.play("Jump") 
	elif is_moving_right:
		if red_area:
			_animated_sprite.play("Move_red")
		else:
			_animated_sprite.play("Move")
		_animated_sprite.flip_h = false
	elif is_moving_left:
		if red_area:
			_animated_sprite.play("Move_red")
		else:
			_animated_sprite.play("Move")
		_animated_sprite.flip_h = true
	else:
		if red_area:
			_animated_sprite.play("Still_red")
		else:
			_animated_sprite.play("Still")


func _on_area_2d_body_entered(body):
	if body == self:
		red_area = true
	audio.play()


func _on_area_2d_body_exited(body):
	if body == self:
		red_area = false
