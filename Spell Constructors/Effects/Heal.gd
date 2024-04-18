extends SpellEffect
class_name Heal

@export var heal_amount : int = 10
@export_enum("Self", "Target") var who : String = "Target"


func pre_cast(_target, _caster):
    var checks = true
    if who == "Target":
        checks = checks and SpellCheck.Check_Target_Alive(_target)
        checks = checks and SpellCheck.Check_Target_Healable(_target)
    elif who == "Self":
        checks = checks and SpellCheck.Check_Target_Alive(_caster)
        checks = checks and SpellCheck.Check_Target_Healable(_caster)
    return checks

func cast(_target, _caster):
    #mp.print("healing target[%s]" %[_target])
    #if who == "Target":
        #mp.set_all.rpc(_target.get_path(), "health", str("+= ", heal_amount))
    #elif who == "Self":
        #mp.set_all.rpc(_caster.get_path(), "health", str("+= ", heal_amount))
    print("fix cast in heal")
