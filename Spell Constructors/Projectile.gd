extends Node3D
class_name Projectile

var target_name
var caster_name
var speed: int = 1
var execute_distance: float = 1.0
var id : int
var executed: bool = false
var spell_script_path
#@onready var target_body = mp.Players.get_node(NodePath(target_name)).get_node("Body")
#@onready var caster_body = mp.Players.get_node(NodePath(caster_name)).get_node("Body")
@onready var target_body = CharacterBody2D.new()
@onready var caster_body = CharacterBody2D.new()

func _ready():
    if has_node("GPUParticles3D"):
        get_node("GPUParticles3D").finished.connect(queue_free)
    
func _process(delta):
    if target_name:
        var direction = (target_body.global_position - global_position).normalized()
        if !global_position.is_equal_approx(target_body.global_position):
            look_at(target_body.global_position)
        global_position += direction * speed * delta
        
        if global_position.distance_to(target_body.global_position) <= execute_distance:
            if executed == false:
                execute()
                executed = true
                get_node("MeshInstance3D").hide()
                if has_node("GPUParticles3D"):
                    get_node("GPUParticles3D").emitting = false
                    get_node("GPUParticles3D").one_shot = true
                    get_node("GPUParticles3D").emitting = true
                    get_node("GPUParticles3D").emitting = false
                else:
                    queue_free()

func execute():
    if multiplayer.is_server():
        get_node(spell_script_path).execute(target_body,caster_body)
        print("Projectile executed")
