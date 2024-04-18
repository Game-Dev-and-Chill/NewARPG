extends SpellEffect
class_name Interrupt

@export_enum("Self", "Target") var who : String = "Target"
@export var cast_time = 0

var effect_name = "Interrupt"
var target

# Things to do before the cast
func pre_cast(_target, _caster):
	print("Fix Interrupt")
	var checks = true
	#var checks = SpellCheck.Check_Target_Casting(_target) or SpellCheck.Check_Target_Channeling(_target)
	#checks = checks and (SpellCheck.Check_Interrupt_Time_Cast(_target, cast_time) or SpellCheck.Check_Interrupt_Time_Channel(_target, cast_time))
	return checks


# Things to do during the cast
func cast(_target, _caster):
	if _target == _caster:
		return
	elif _target:
		#mp.interrupt(_target.get_parent().player_id, _caster.get_parent().player_id)
		print("fix cast in interrupt")
