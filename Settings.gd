#Settings.gd
#@tool
#class_name Settings
extends PanelContainer
# Description: This class serves as a template for new scripts in the Godot engine, providing structured sections for various types of variables and methods.


#region Variables
#signals
#enums
#constants
#@export variables
@export_category("Nodes")
@export_group("UI_Settings")
@export_subgroup("x_sensitivity")
@export var ui_xs_slider: HSlider ##UI_Settings/mouse_over_font_size/Slider
@export var ui_xs_text: LineEdit
@export_subgroup("y_sensitivity")
@export var ui_ys_slider: HSlider
@export var ui_ys_text: LineEdit
@export_subgroup("mouse_over_text")
@export var ui_mot_enabled: CheckButton
@export_subgroup("mouse_over_font_size")
@export var ui_mofs_slider: HSlider ##UI_Settings/mouse_over_font_size/Slider
@export var ui_mofs_text: LineEdit
@export_subgroup("user_interface_font_size")
@export var ui_uifs_slider: HSlider
@export var ui_uifs_text: LineEdit
#public variables
#SETTINGSSSSSSSSSSS, no snakes were here
var mouse_over_popup_text: bool = true
var mouse_over_font_size: int = 32
var ui_font_size: int = 32
#private variables
#@onready variables
#endregion

#region Auto_Include_Functions
#endregion
@onready var t = $"TabContainer/UI Settings/MarginContainer/VBoxContainer/cursor container/x sensitivity/LineEdit"

func _ready():
	ui_mot_enabled.toggled.connect(_toggled_mouse_over_text)
	connect_ui(ui_xs_slider, ui_xs_text)
	connect_ui(ui_ys_slider, ui_ys_text)
	connect_ui(ui_mofs_slider, ui_mofs_text)
	connect_ui(ui_uifs_slider, ui_uifs_text)

func _input(event):
	if event.is_action_pressed("open_menu"):
		visible = !visible
		get_tree().paused = visible

func connect_ui(slider, text):
	slider.value_changed.connect(_on_slider_change.bind(text))
	text.text_changed.connect(_on_text_change.bind(slider))
	text.text_changed.connect(numbers_only.bind(text))

func numbers_only(value, line_edit):
	line_edit.text = str(value.to_int())
	line_edit.caret_column = line_edit.text.length() + 1

func _on_slider_change(value, label):
	label.text = str(value)
	mouse_over_font_size = value

func _on_text_change(value, slider):
	slider.value = int(value)

func _toggled_mouse_over_text(toggled_on):
	mouse_over_popup_text = toggled_on
