extends KinematicBody
export var lerp_speed = 0.1 
var target = null
func _physics_process(delta):
	if !target:
		return
	global_transform = global_transform.interpolate_with(target.global_transform, lerp_speed * delta)
	$AnimationPlayer.play("Animacion")




func _on_Area_body_entered(body):
	if body.name == "character":
		target = body

