extends SpellEffect
class_name blank_effect

#Add Variables Here
@export var tick_amount : int = 10
@export var tick_count : int = 9
@export var duration : int = 3
@export_enum("Self", "Target") var who : String = "Target"

var effect_name = ""
var target
var accumulated_delta
var dur_per_tick = duration/float(tick_count-1)

#OVERIDES
# delete overides not used!

# Things to do before the cast
func pre_cast(_target, _caster):
	var checks = true
	return checks

# Things to do during the cast
func cast(_target, _caster):
	pass

# Things to do after the cast    
func post_cast(_target, _caster):
	pass

# Things to apply over time
func tick(_target):
	pass
