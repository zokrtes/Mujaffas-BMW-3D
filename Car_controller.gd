extends VehicleBody

export var horse_power = 111
export var accel_speed = 10

var steer_angle = deg2rad(30)
var steer_speed = 3

var brake_power = 30
var brake_speed = 20

var mouse_sens = 0.1

var ratt_lerp = 30.0

func _input(event):
	
	if event is InputEventMouseMotion:
		$Head.rotate_y(deg2rad(-event.relative.x * mouse_sens))
		$Head.rotation.y = clamp($Head.rotation.y, deg2rad(-158), deg2rad(145))
		$Head/Camera.rotate_x(deg2rad(event.relative.y * mouse_sens))
		$Head/Camera.rotation.x = clamp($Head/Camera.rotation.x, deg2rad(-60), deg2rad(60))
		
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_WHEEL_RIGHT and event.is_pressed():
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _physics_process(delta):
	
	#throtleee
	var throt_input = -Input.get_action_strength("decelerate") + Input.get_action_strength("accelerate")
	engine_force = lerp(engine_force, throt_input * horse_power, accel_speed * delta)
	
	#steering
	var steer_input = +Input.get_action_strength("left") - Input.get_action_strength("right")
	steering = lerp(steering, steer_input * steer_angle, steer_speed * delta)
	
	#braking
	var brake_input = Input.get_action_strength("brake")
	brake = lerp(brake, brake_input * brake_power, brake_speed * delta)
	
	
	
	if Input.is_action_pressed("left"):
		$DrivingHand.rotate_z(-steer_input / 10)
	elif Input.is_action_pressed("right"):
		$DrivingHand.rotate_z(-steer_input / 10)
		
	$DrivingHand.rotation = $DrivingHand.rotation.linear_interpolate(Vector3(0,0,0), delta*3)
	
	if Input.is_action_just_pressed("kompis"):
		$AnimationPlayer.play("wallah")
	elif Input.is_action_just_pressed("jente"):
		$AnimationPlayer.play("snuppa")
