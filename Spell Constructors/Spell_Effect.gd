extends Node
class_name SpellEffect

func pre_cast(_target, _caster):
    return true

func cast(_target, _caster):
    pass
    
func post_cast(_target, _caster):
    pass

func pre_tick(_target):
    return true
    
func tick(_target):
    pass
