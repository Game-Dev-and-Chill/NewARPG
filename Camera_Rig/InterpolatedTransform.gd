#InterpolatedTransform.gd
#@tool
class_name InterpolatedTransform
extends Node3D
#docstring


#region Variables
#signals
#enums
#constants
#@export variables
#public variables
var last_physics_position 		:= Vector3(0,0,0)
var current_physics_position 	:= Vector3(0,0,0)
var last_physics_rotation		:= Quaternion.IDENTITY
var current_physics_rotation	:= Quaternion.IDENTITY
var last_physics_scale          := Vector3(0,0,0)
var current_physics_scale 		:= Vector3(0,0,0)
var parent:Node3D               = null
var interpolate_enabled 		:= false
#private variables
#@onready variables
#endregion


#region Functions
#optional built-in virtual _init method
#optional built-in virtual _enter_tree() method
#optional built-in virtual _ready method - Called when the node enters the scene tree for the first time.
func _ready():
	assert(get_parent() is Node3D)
	parent = get_parent()
	top_level = true
	interpolate_enabled = true
#region remaining built-in virtual methods
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if interpolate_enabled:
		#print("test")
		#var interpolation_factor = InterpolationMaster.interpolation_factor
		var interpolation_factor = Engine.get_physics_interpolation_fraction()
		parent.global_position = last_physics_position.lerp(current_physics_position, interpolation_factor)
		#print("global_rotation", parent.rotation)
		#print("new global_rotation", last_physics_rotation.slerp(current_physics_rotation, interpolation_factor).get_euler())
		parent.rotation = last_physics_rotation.slerp(current_physics_rotation, interpolation_factor).get_euler()
		#parent.scale = lerp(last_physics_scale, current_physics_scale, interpolation_factor)
		#print("last_physics_position: [", last_physics_position, "]")
		#print("current_physics_position: [", current_physics_position, "]")
		#print(last_physics_position.lerp(current_physics_position, interpolation_factor))
		#print(last_physics_rotation.slerp(current_physics_rotation, interpolation_factor).get_euler())
		#print(lerp(last_physics_scale, current_physics_scale, interpolation_factor))
	else:
		global_position = current_physics_position
		rotation = current_physics_rotation.get_euler()
		scale = current_physics_scale

func _physics_process(_delta: float) -> void:
	last_physics_position = current_physics_position
	current_physics_position = parent.global_position
	
	last_physics_rotation = current_physics_rotation
	current_physics_rotation = Quaternion.from_euler(parent.rotation)

	#last_physics_scale = current_physics_scale
	#current_physics_scale = parent.scale
#endregion
#region public methods
func set_interpolate_enabled(enabled:bool):
	interpolate_enabled = enabled
#endregion
#region private methods
#endregion
#region subclasses
#endregion
#endregion

#region Auto_Include_Functions
#endregion
