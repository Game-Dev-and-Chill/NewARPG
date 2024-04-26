#Interact_Agent.gd
#@tool
class_name Interact_Agent
extends Node
# Description: This class serves as a template for new scripts in the Godot engine, providing structured sections for various types of variables and methods.


#region Variables
#signals
#enums
#constants
#@export variables
#public variables
var over_interactable: bool = false
var interactable_script: Node
#private variables
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
func _process(delta):
	_interact_input()
#endregion
#region public methods
#endregion
#region private methods
func _interact_input():
	if over_interactable and Input.is_action_just_pressed("interact"):
		interactable_script._interact()
#endregion
#region subclasses
#endregion
#endregion

#region Auto_Include_Functions
#endregion
