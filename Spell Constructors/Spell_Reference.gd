@tool
extends TextureRect
class_name Spell_Reference

@export var Spell_Selection : PackedScene :
	set(scene):
		if scene != null and scene is PackedScene and not scene._bundled.is_empty() and scene._bundled["names"][0] == "Spell":
			#print("ITS A SPELL")
			Spell_Selection = scene
		elif scene == null:
			print("Setting Scene To null")
			Spell_Selection = null
		else:
			print("THAT AINT NO FUCKING SPELL!!!!")
# In your draggable spell icon script
var being_dragged = false
var original_position = Vector2()

func _ready():
	original_position = position

func _process(_delta):
	if being_dragged:
		position = get_viewport().get_mouse_position()

func _get_drag_data(_at_position):
	if get_parent().get_parent().name == "Spell_Bar":
		if get_parent().disabled or get_parent().get_node("TextureProgressBar").visible == true: # or mp.casting == true
			return
	var preview = TextureRect.new()
	var container = Control.new()
	preview.texture = texture
	preview.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	preview.size = size
	container.add_child(preview)
	preview.position = -0.5*size
	set_drag_preview(container)
	if get_parent().get_parent().name == "Spell_Bar":
		self.queue_free()
	return{"spell":Spell_Selection, "parent":get_parent(), "texture":texture}
