#StashInteraction.gd
#@tool
#class_name StashInteraction
extends Interactable
# Description: This class serves as a template for new scripts in the Godot engine, providing structured sections for various types of variables and methods.


#region Variables
#signals
#enums
#constants
#@export variables
@export var Stash_Label: Label3D
#public variables
#private variables
#@onready variables
#endregion


#region Functions
#optional built-in virtual _init method
#optional built-in virtual _enter_tree() method
#optional built-in virtual _ready method - Called when the node enters the scene tree for the first time.
#region remaining built-in virtual methods
func _interact():
	print("test _interact")


func _interactable_mouse_enter():
	if .mouse_over_popup_names:
		Stash_Label.show()


func _interactable_mouse_leave():
	Stash_Label.hide()


func _interactable_ready():
	print("test _ready")
# Called every frame. 'delta' is the elapsed time since the previous frame.
#endregion
#region public methods
#endregion
#region private methods
#endregion
#region subclasses
#endregion
#endregion
