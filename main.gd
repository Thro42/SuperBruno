extends Spatial
var c = 0
var score = 0
var hp = 150

func _process(delta):
	if hp <= 0:
		print("YOU LOST")

func _on_Area_body_exited(body):
	if body.name == "character" and c == 0:
		print("YOU LOST") 


func _on_finish_body_entered(body):
	if body.name == "character":
		print("YOU WON")
		c = 1


func _on_coinGold_body_entered(body):
	if body.name == "character":
		score += 1
		$score.text = "Score: %s" % score

func _on_spikes_body_entered(body):
	hp -= 25
	$hp.text = "Hp: %s" % hp
