extends KinematicBody
var gravity = Vector3.DOWN * 10
var speed = 4
var jump_speed = 5
var velocity = Vector3.ZERO
var spin = 0.1
var jump = false
var jumping = false
var landing = false
var landet = false
var can_move = true
func _physics_process(delta):
	get_input()
	velocity += gravity * delta
	velocity = move_and_slide(velocity, Vector3.UP)
	if landet and is_on_floor():
		$BRUNO/AnimationPlayer.play("Idle")
		landet = false
	if jump and is_on_floor():
		velocity.y = jump_speed
		jump = false
		jumping = true
	if jumping and !is_on_floor():
		$BRUNO/AnimationPlayer.play("Jump_Idle")
	if jumping and is_on_floor():
		$BRUNO/AnimationPlayer.play("Jump_Land")
		jumping = false
		landet = true


func get_input():
	if !can_move:
		return
	var vy = velocity.y
	velocity = Vector3.ZERO
	if Input.is_action_pressed("move_forward"):
		velocity += -transform.basis.z * speed
		$BRUNO/AnimationPlayer.play("Walk")
	if Input.is_action_just_released("move_forward"):
		$BRUNO/AnimationPlayer.play("Idle")
	if Input.is_action_pressed("move_back"):
		velocity += transform.basis.z * speed
		$BRUNO/AnimationPlayer.play_backwards("Walk")
	if Input.is_action_just_released("move_back"):
		$BRUNO/AnimationPlayer.play("Idle")
	if Input.is_action_pressed("strafe_right"):
		velocity += transform.basis.x * speed
		$BRUNO/AnimationPlayer.play("Walk")
	if Input.is_action_just_released("strafe_right"):
		$BRUNO/AnimationPlayer.play("Idle")
	if Input.is_action_pressed("strafe_left"):
		velocity += -transform.basis.x * speed
		$BRUNO/AnimationPlayer.play("Walk")
	if Input.is_action_just_released("strafe_left"):
		$BRUNO/AnimationPlayer.play("Idle")
	if Input.is_action_just_pressed("jump"):
		jump = true
		$BRUNO/AnimationPlayer.play("Jump")
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
	
	
	



