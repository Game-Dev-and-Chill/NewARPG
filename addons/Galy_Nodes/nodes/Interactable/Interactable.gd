#Interactable.gd
#@tool
class_name Interactable
extends Node
## Adds an interaction to the parent node for use with the [Interact_Agent] node.


#region Variables
#signals
#enums
#constants
#@export variables
@export var body: PhysicsBody3D ## The body that contains the collider for the interactable node will be some sort of PhysicsBody
@export var owner_node: Node3D	## The top level node of the entire interactables tree.
#public variables
var interactable: bool = true ## a boolean enabling or disabling the interact functionality
var player_body: CharacterBody3D ## variable targeting the location where the movement controller is to prevent moving when trying to interact
var interact_agent ## the node attacthed to the player controller to allow interaction functionality.
#private variables
var _ready_called = false ## a boolean to determine if ready was overriden by a child class in order to prevent overideing core functionality of the node.
#@onready variables
#endregion


#region Functions
#optional built-in virtual _init method
#optional built-in virtual _enter_tree() method
#optional built-in virtual _ready method - Called when the node enters the scene tree for the first time.
func _ready():
	_ready_called = true
	body.set_owner(owner_node)
	body.connect("mouse_entered", mouse_over_interactable)
	body.connect("mouse_exited", mouse_leave_interactable)
	player_body = get_tree().current_scene.player_body
	interact_agent = player_body.get_node("Interact_Agent")
	_interactable_ready()

#region remaining built-in virtual methods
func _notification(what):
	if what == NOTIFICATION_READY:
		assert(_ready_called, "_ready method shouldn't be overidden in interaction. Use _interactable_ready instead.")
#endregion

#region public methods
func mouse_over_interactable():
	interact_agent.over_interactable = true
	interact_agent.interactable_script = self
	_interactable_mouse_enter()


func mouse_leave_interactable():
	interact_agent.over_interactable = false
	interact_agent.interactable_script = null
	_interactable_mouse_leave()

#endregion
#region private methods
## A [method Node._ready] method for interactable objects
func _interactable_ready():
	pass


## A method for interactable objects that calls functionality when a mouse enters the interactables collider.
func _interactable_mouse_enter():
	pass


## A method for interactable objects that calls functionality when a mouse exits the interactables collider.
func _interactable_mouse_leave():
	pass


## Method to add functionality when the object is interacted with.
func _interact():
	print("interacted with ", owner_node.name, " no interaction defined. Overide the interact method.")
#endregion

#region subclasses
#endregion
#endregion

#region Auto_Include_Functions
#endregion
