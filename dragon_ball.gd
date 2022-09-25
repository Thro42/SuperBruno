extends Area
var speed = 5
var velocity = Vector3.ZERO

func start(xform):
	transform = xform
	velocity = -transform.basis.z * speed
	
func _process(delta):
	transform.origin += velocity * delta
	
func _on_Timer_timeout():
	queue_free()


func _on_dragon_ball_body_entered(body):
	if body is StaticBody:
		queue_free()
