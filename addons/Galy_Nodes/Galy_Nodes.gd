#GalyNodes.gd
@tool
#class_name GalyNodes
extends EditorPlugin
# Description: This class serves as a template for new scripts in the Godot engine, providing structured sections for various types of variables and methods.


#region Variables
#signals
#enums
#constants
#@export variables
#public variables
#private variables
#@onready variables
#endregion


#region Functions
#optional built-in virtual _init method
#optional built-in virtual _enter_tree() method
#optional built-in virtual _ready method - Called when the node enters the scene tree for the first time.
func _enter_tree():
	add_custom_type("Interactable","Node",preload("nodes/Interactable/Interactable.gd"), preload("nodes/Interactable/Interactable.png"))
func _exit_tree():
	remove_custom_type("Interactable")
#region remaining built-in virtual methods
#endregion
#region public methods
#endregion
#region private methods
#endregion
#region subclasses
#endregion
#endregion

#region Auto_Include_Functions
#endregion
