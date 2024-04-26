#Settings.gd
#@tool
#class_name Settings
extends Node
# Description: This class serves as a template for new scripts in the Godot engine, providing structured sections for various types of variables and methods.


#region Variables
#signals
#enums
#constants
#@export variables
@export_category("Nodes")
@export_group("UI_Settings")
@export_subgroup("mouse_over_text")
@export var ui_mot_enabled: CheckButton
@export_subgroup("mouse_over_font_size")
@export var ui_mofs_slider: HSlider ##UI_Settings/mouse_over_font_size/Slider
@export var ui_mofs_text: LineEdit
@export_subgroup("user_interface_font_size")
@export var ui_uifs_slider: HSlider
@export var ui_uifs_text: LineEdit
#public variables
var mouse_over_popup_text: bool = true
var mouse_over_font_size: int = 32
var ui_font_size: int = 32
#private variables
#@onready variables
#endregion

#region Auto_Include_Functions
#endregion


func numbers_only(value,node_path):
	if value is String:
		var lineedit = get_node(node_path) as LineEdit
		lineedit.text = str(value.to_int())
		lineedit.caret_column = lineedit.text.length()+1

func _on_slider_change_mouse_over_font_size(value):
	ui_mofs_text.text = str(value)
	mouse_over_font_size = value
func _on_slider_change_user_interface_font_size(value):
	ui_uifs_text.text = str(value)
	mouse_over_font_size = value
func _on_text_change_mouse_over_font_size(value):
	ui_mofs_slider.value = int(value)
func _on_text_change_user_interface_font_size(value):
	ui_uifs_slider.value = int(value)
func _toggled_mouse_over_text(toggled_on):
	mouse_over_popup_text = toggled_on
