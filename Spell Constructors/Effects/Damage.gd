extends SpellEffect
class_name Damage

@export var damage_amount : int = 10
@export_enum("Fire", "Water", "Earth", "Wind", "Necrotic", "Physical", "Psychic", "Arcane", "Oof") var damage_type : String = "Physical"
@export_enum("Self", "Target") var who : String = "Target"

func pre_cast(_target, _caster):
	var checks = true
	checks = checks and SpellCheck.Check_Target_Alive(_target)
	return checks

func cast(_target, _caster):
	#mp.print("damaging target[%s]" %[_target])
	#mp.set_all.rpc(_target.get_path(), "health", str("-= ", damage_amount))
	print("fix cast in damage")
