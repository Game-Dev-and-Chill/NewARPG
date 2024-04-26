#CameraContainer.gd
#@tool
#class_name CameraContainer
extends Node3D
#docstring


#region Variables
#signals
#enums
#constants
#@export variables
@export_category("Camera_Settings")
@export var focal_point : Node3D
@export var camera: Camera3D
@export var spring_arm: SpringArm3D

@export var vertical_camera_angle :int = 30
@export var camera_distance :int = 4
@export var camera_sensitivity_x: float = .01
@export var camera_sensitivity_y: float = .01
@export var min_vertical_angle: int = -70
@export var max_vertical_angle: int = 70
@export var camera_zoom_speed: float = 10
@export var camera_zoom_clamp_low: float = .01
@export var camera_zoom_clamp_high: float = 30
#public variables
var camera_follow = false
var cam_tar
var interp_speed = 10
var spring_arm_reset_rotation
var accumulated_mouse_motion := Vector2.ZERO
var right_mouse_button_pressed := false
var previous_mouse_position := Vector2.ZERO
var my_bod
#private variables
#@onready variables
#endregion


#region Functions
#optional built-in virtual _init method
#optional built-in virtual _enter_tree() method
#optional built-in virtual _ready method - Called when the node enters the scene tree for the first time.
func _ready():
	print("camera is in")
	spring_arm_reset_rotation = spring_arm.global_rotation
	
#region remaining built-in virtual methods
func _input(event: InputEvent) -> void:
	if get_window().has_focus():
		if event is InputEventMouseMotion:
			if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED :
				accumulated_mouse_motion += event.relative
		elif event is InputEventMouseButton:
			if event.button_index == MOUSE_BUTTON_RIGHT:
				if event.pressed:
					right_mouse_button_pressed = true
					previous_mouse_position = event.position
					Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
				else:
					right_mouse_button_pressed = false
					Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
					await get_tree().process_frame
					await get_tree().process_frame
					await get_tree().process_frame   # Hide the mouse before warping
					get_viewport().warp_mouse(previous_mouse_position)  # Warp the mouse to its pre-drag position
					Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)  # Make the mouse visible after warping
	_handle_camera_zoom(event)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !cam_tar == null and camera_follow == true:
		position = global_position.move_toward(cam_tar.global_position, interp_speed*delta)
	pass

func _physics_process(_delta):     
	input_camera(_delta)
	handle_camera_culling()
#endregion
#region public methods
#endregion
#region private methods
func _handle_camera_zoom(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
		spring_arm.spring_length = move_toward(spring_arm.spring_length, camera_zoom_clamp_high, camera_zoom_speed/100)
	
	elif event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_WHEEL_UP:
		spring_arm.spring_length = move_toward(spring_arm.spring_length, camera_zoom_clamp_low, camera_zoom_speed/100)

func input_camera(_delta: float):
	if right_mouse_button_pressed:
		spring_arm_reset_rotation = spring_arm.global_rotation_degrees
		spring_arm.global_rotation.y -= deg_to_rad(accumulated_mouse_motion.x * camera_sensitivity_x * 10)
		var new_tilt = spring_arm.global_rotation.x - deg_to_rad(accumulated_mouse_motion.y * camera_sensitivity_y * 10)
		spring_arm.global_rotation.x = clamp(new_tilt, deg_to_rad(min_vertical_angle), deg_to_rad(max_vertical_angle))
		accumulated_mouse_motion = Vector2.ZERO
		if spring_arm:
			#my_bod.get_node("MeshInstance3D").rotation.y = spring_arm.rotation.y
			my_bod.global_rotation.y = spring_arm.global_rotation.y

#func reset_camera():
	## For X Rotation
	#var diff_x = spring_arm_reset_rotation.x - spring_arm.rotation_degrees.x
	#if abs(diff_x) > 180:
		## Adjust target rotation for shortest path
		#if diff_x > 0:
			#spring_arm_reset_rotation.x -= 360
		#else:
			#spring_arm_reset_rotation.x += 360
	## For y Rotation
	#var diff_y = spring_arm_reset_rotation.y - spring_arm.rotation_degrees.y
	#if abs(diff_y) > 180:
		## Adjust target rotation for shortest path
		#if diff_y > 0:
			#spring_arm_reset_rotation.y -= 360
		#else:
			#spring_arm_reset_rotation.y += 360
	### For z Rotation
	##var diff_z = spring_arm_reset_rotation.z - spring_arm.rotation_degrees.z
	##if abs(diff_z) > 180:
		### Adjust target rotation for shortest path
		##if diff_z > 0:
			##spring_arm_reset_rotation.z -= 360
		##else:a
			##spring_arm_reset_rotation.z += 360
	#spring_arm.rotation_degrees.x = move_toward(spring_arm.rotation_degrees.x,spring_arm_reset_rotation.x, 1.4)
	#spring_arm.rotation_degrees.y = move_toward(spring_arm.rotation_degrees.y,spring_arm_reset_rotation.y, 1.4)
	##spring_arm.rotation_degrees.z = move_toward(spring_arm.rotation_degrees.z,spring_arm_reset_rotation.z, 1.4)
	

func handle_camera_culling():
	var hit_length = spring_arm.get_hit_length()
	var mesh_container: Node3D = my_bod.get_node("MeshInstance3D")

	if hit_length >= 2.5:
		# Reset mesh transparency when the camera is far enough
		reset_mesh_transparency(mesh_container)
	elif hit_length <= 0.5:
		# Make the mesh fully transparent when the camera is very close
		set_mesh_transparency(mesh_container, 0.0)
	else:
		# Calculate the transparency value based on the hit length
		var transparency = 1 - ((2.5 - hit_length) / 2.0)

		# Call the recursive function on the mesh container
		set_mesh_transparency(mesh_container, transparency)
		
# Define the recursive functions separately
func set_mesh_transparency(node: Node, alpha: float):
	if node is GeometryInstance3D:
		node.transparency = 1.0 - alpha  # Invert the alpha value

	for child in node.get_children():
		set_mesh_transparency(child, alpha)
		

func reset_mesh_transparency(node: Node):
	if node is GeometryInstance3D:
		node.transparency = 0.0  # Reset to fully opaque

	for child in node.get_children():
		reset_mesh_transparency(child)
#endregion
#region subclasses
#endregion
#endregion

#region Auto_Include_Functions
#endregion
