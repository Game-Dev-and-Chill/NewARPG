extends SpellEffect
class_name Poison

@export var tick_amount : int = 3
@export var tick_count : int = 15
@export var duration : int = 30
@export_enum("Self", "Target") var who : String = "Target"

const damage_type := "Necrotic" 
var effect_name = "Poison"
var target
var actiondict = {}

func pre_cast(_target, _caster):
	var checks = true
	checks = checks and SpellCheck.Check_Target_Alive(_target)
	checks = checks and SpellCheck.Check_Target_Poisonable(_target)
	return checks

func cast(_target, _caster):
	var handler = _target.get_node("Components/C_Status_Effect_Handler")
	handler.add_effect(self)
	pass

func post_cast(_target, _caster):
	pass

func tick(_target):
	#mp.set_all.rpc(_target.get_path(), "health", str("-= ", tick_amount))
	print("fix tick in Poison")
