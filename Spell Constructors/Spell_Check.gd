extends Node
class_name SpellCheck

const debug = true
const debugtrue = false

static func Check_Target_Alive(_target):
    var _target_health = _target.get_node("Components/C_Health").health
    if _target_health > 0:
        if debugtrue == true and debug == true: print("Target's health is high enough!")
        return true
    else:
        if debug == true: print("Target's health is too low!")
        return false
        
static func Check_Target_Burnable(_target):
    if _target.burnable == true:
        if debugtrue == true and debug == true: print("Target is burnable")
        return true
    else:
        if debug == true: print("Target is not burnable")
        return false
        
static func Check_Target_Healable(_target):
    if _target.healable == true:
        if debugtrue == true and debug == true: print("Target is healable")
        return true
    else:
        if debug == true: print("Target is not healable")
        return false
        
static func Check_Target_Can_Bleed(_target):
    if _target.can_bleed == true:
        if debugtrue == true and debug == true: print("Target can bleed")
        return true
    else:
        if debug == true: print("Target can not bleed")
        return false
        
#static func Check_Target_Casting(_target):
    #if active_casts.has(_target.get_parent().player_id) == true:
        #if debugtrue == true and debug == true: print("Target is casting")
        #return true
    #else:
        #if debug == true: print("Target isn't casting")
        #return false
        
#static func Check_Target_Channeling(_target):
    #if active_channels.has(_target.get_parent().player_id) == true:
        #if debugtrue == true and debug == true: print("Target is channeling")
        #return true
    #else:
        #if debug == true: print("Target isn't channeling")
        #return false
        
#static func Check_Interrupt_Time_Cast(_target, cast_time):
    #if active_casts.has(_target.get_parent().player_id) and active_casts[_target.get_parent().player_id].timestamp > (Time.get_ticks_usec() + (cast_time*1000)):
        #if debugtrue == true and debug == true: print("There's enough time to interrupt")
        #return true
    #else:
        #if debug == true: mp.print("Can't interupt in time.")
        #return false
        
#static func Check_Interrupt_Time_Channel(_target, cast_time):
    #if active_channels.has(_target.get_parent().player_id) and active_channels[_target.get_parent().player_id].timestamp > (Time.get_ticks_usec() + (cast_time*1000)):
        #if debugtrue == true and debug == true: print("There's enough time to interrupt")
        #return true
    #else:
        #if debug == true: print("Can't interupt in time.")
        #return false
        
static func Check_Target_Poisonable(_target):
    if _target.burnable == true:
        if debugtrue == true and debug == true: print("Target is burnable")
        return true
    else:
        if debug == true: print("Target is not burnable")
        return false
