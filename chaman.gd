extends KinematicBody
export var lerp_speed = 0.1 
var gravity = Vector3.DOWN * 10
var velocity = Vector3.ZERO
var bullet = preload("res://fire_ball.tscn")
var target = null
var fire = false
func _physics_process(delta):
	$AnimationPlayer.play("Walk_Cycle")
	get_input()
	velocity += gravity * delta
	if !target:
		return
	global_transform = global_transform.interpolate_with(target.global_transform, lerp_speed * delta)
	
func fire():
	var ball = bullet.instance()
	ball.start($Position3D.global_transform)
	get_parent().add_child(ball)

func get_input():
	if Input.is_action_just_pressed("fire"):
		fire()
	
	
	
	




func _on_Area_body_entered(body):
	if body.name == "character":
		target = body






