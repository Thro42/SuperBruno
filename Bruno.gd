extends KinematicBody
var gravity = Vector3.DOWN * 10
var speed = 4
var jump_speed = 5
var velocity = Vector3.ZERO
var spin = 0.1
var jump = false
var can_move = true
func _physics_process(delta):
	get_input()
	velocity += gravity * delta
	velocity = move_and_slide(velocity, Vector3.UP)
	if jump and is_on_floor():
		velocity.y = jump_speed
		jump = false


func get_input():
	if !can_move:
		return
	var vy = velocity.y
	velocity = Vector3.ZERO
	if Input.is_action_pressed("move_forward"):
		velocity += -transform.basis.z * speed
	if Input.is_action_pressed("move_back"):
		velocity += transform.basis.z * speed
	if Input.is_action_pressed("strafe_right"):
		velocity += transform.basis.x * speed
	if Input.is_action_pressed("strafe_left"):
		velocity += -transform.basis.x * speed
	if Input.is_action_just_pressed("jump"):
		jump = true
	velocity.y = vy

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		rotate_y(-lerp(0, spin, event.relative.x / 10))
		
func take_damage():
	velocity *= -1
	velocity.y = jump_speed
	can_move = false
	yield(get_tree().create_timer(1), "timeout")
	can_move = true

