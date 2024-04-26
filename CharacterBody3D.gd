#ColiderCapsule.gd
#@tool
class_name Player
extends CharacterBody3D
#docstring


#region Variables
#signals
#enums
#constants
const JUMP_VELOCITY = 4.5
const CLICK_MOVE_RAY_LENGTH = 1000
#@export variables
@export var camera: Camera3D
@export var speed: float = 5.0
@export var interact_agent: Node
@export var nav_agent: NavigationAgent3D
#public variables
#private variables
var _target_position: Vector3
var _target_rotation: float
#@onready variables
#endregion


#region Functions
#optional built-in virtual _init method
#optional built-in virtual _enter_tree() method
#optional built-in virtual _ready method - Called when the node enters the scene tree for the first time.
func _ready():
	pass	
#region remaining built-in virtual methods
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
	
func _physics_process(_delta):
	_click_set_move_and_rotation_target(_delta)
	_move_to_target(_delta)
	_rotate_towards_target(_target_rotation, _delta)
#endregion
#region public methodswww
#endregion
#region private methods
func _click_set_move_and_rotation_target(_delta):
	if Input.is_action_pressed("move_to_mouse") and !interact_agent.over_interactable:
		var ray_origin = camera.project_ray_origin(get_viewport().get_mouse_position())
		var ray_end = ray_origin + camera.project_ray_normal(get_viewport().get_mouse_position())*CLICK_MOVE_RAY_LENGTH
		var space_state = get_world_3d().direct_space_state
		var query_parameters = PhysicsRayQueryParameters3D.create(ray_origin, ray_end, 1)
		var result = space_state.intersect_ray(query_parameters)
		_target_position = result.position
		#print("Set target position to ", result.position)
		var direction = global_position.direction_to(_target_position)
		_target_rotation = atan2(direction.x, direction.z)
		nav_agent.set_target_position(_target_position)


func _move_to_target(_delta):
	velocity = (nav_agent.get_next_path_position() - global_transform.origin).normalized() * speed
	move_and_slide()

func _rotate_towards_target(target_rotation: float, _delta):
	if velocity != Vector3.ZERO:
		var lookdirection = Vector2(velocity.z, velocity.x)
		global_rotation.y = lerp_angle(global_rotation.y,lookdirection.angle(),speed * _delta)
#endregion
#region subclasses
#endregion
#endregion

#region Auto_Include_Functions
#endregion








