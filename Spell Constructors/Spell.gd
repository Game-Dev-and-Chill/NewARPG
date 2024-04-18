extends Node
class_name Spell

@export var spell_icon: Texture
@export var self_targetable: bool = true
@export var cooldown: float = 3
@export var class_requirement: String 
@export var level_requirement: int
@export var spell_description: String
@export var cast_time: float = 1500
@export_enum("Cast","Channel") var cast_type : String = "Cast"

func pre_cast(_target, _caster):
	var checks = true
	print(str("Going into child checks, checks is [" , checks , "]"))
	if self_targetable == false and _target == _caster:
		checks = false
		print("Failed Check - Target is self on non self targeting spell")
	checks = do_child_checks(_target, _caster, checks)
	return checks

func cast(_target, _caster):
	print(str("casting at ", _target))
	for child in get_children() as Array[SpellEffect]:
		child.cast(_target, _caster)
	
func post_cast(_target, _delta):
	for child in get_children() as Array[SpellEffect]:
		child.post_cast(_target, _delta)

func do_child_checks(_target, _caster, checks):
	for child in get_children() as Array[SpellEffect]:
		checks = checks and child.pre_cast(_target, _caster)
	return checks
