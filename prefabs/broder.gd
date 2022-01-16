extends KinematicBody

enum {
	IDLE,
	WALKING,
	SPECIAL,
	DIE
}

var state = WALKING

var talking = false

func _ready():
	pass

func _process(delta):

	if Input.is_action_just_pressed("kompis") and state == SPECIAL:
		talking = true
	match state:
		IDLE:
			pass
		WALKING:
			translation.z = translation.z + -0.03
		SPECIAL:
			if talking == true:
				salute()
			talking = false
		DIE:
			pass

func _on_VoiceArea_body_entered(body):
	if body.is_in_group("BMW"):
		state = SPECIAL


func _on_VoiceArea_body_exited(body):
	state = WALKING

func salute():
	$WaitTime.start()


func _on_WaitTime_timeout():
		$AudioPlayer.play()
		state = WALKING
