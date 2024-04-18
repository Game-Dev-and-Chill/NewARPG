extends SpellEffect
class_name Heal_Over_Time

@export var tick_amount : int = 10
@export var tick_count : int = 5
@export var duration : int = 3
@export_enum("Self", "Target") var who : String = "Target"

var actiondict = {}
var target
const effect_name = "Heal Over Time"


func pre_cast(_target, _caster):
	var checks = true
	checks = checks and SpellCheck.Check_Target_Alive(_target)
	checks = checks and SpellCheck.Check_Target_Healable(_target)
	return checks

func cast(_target, _caster):
	if who == "Target":
		_target.get_node("Components/C_Status_Effect_Handler").add_effect(self)
	elif who == "Self":
		_target.get_node("Components/C_Status_Effect_Handler").add_effect(self)

func post_cast(_target, _caster):
	pass

func pre_tick(_target):
	var checks = true
	checks = checks and SpellCheck.Check_Target_Alive(_target)
	checks = checks and SpellCheck.Check_Target_Healable(_target)
	return checks

func tick(_target):
	#mp.print("healing target[%s]" %[_target])
	#mp.set_all.rpc(_target.get_path(), "health", str("+= ", tick_amount))
	print("fix tick in Heal_Over_Time")
