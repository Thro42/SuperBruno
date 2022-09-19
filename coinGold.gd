extends Area



func _on_coinGold_body_entered(body):
	if body.name == "character":
		queue_free()
