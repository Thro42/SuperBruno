extends Area
var speed = 2
var velocity = Vector3.ZERO
var target = null
func start(xform):
	transform = xform
	velocity = -transform.basis.z * speed
	
func _process(delta):
	if !target:
		return
	global_transform =  global_transform.interpolate_with(target.global_transform, speed * delta)
	
func _on_Timer_timeout():
	queue_free()




func _on_fire_ball_body_entered(body):
	if body is StaticBody:
		queue_free()


func _on_Area_body_entered(body):
	if body.name == "character":
		target = body
