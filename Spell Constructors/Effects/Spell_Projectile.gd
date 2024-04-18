extends SpellEffect
class_name Spell_Projectile

#Add Variables Here
@export var projectile: PackedScene
@export var execute_distance: float = 1.0
@export var speed: int = 1
@export var scale: float = 1.0

func pre_cast(_target, _caster):
	var checks = true
	for child in get_children() as Array[SpellEffect]:
		checks = checks and child.pre_cast(_target, _caster)
	return checks

func cast(_target_body, _caster_body):
	if projectile:
		var prefab_pos = _caster_body.get_node("Components/C_Caster").global_position + Vector3(execute_distance, 0, 0)
		var properties_dict = {
			"caster_name": _caster_body.get_parent().name,
			"target_name": _target_body.get_parent().name,  # Or any other identifier
			"speed": speed,
			"execute_distance": execute_distance,
			"scale": Vector3(scale,scale,scale),
			#"id": mp.my_id,
			'spell_script_path': get_path(),
		}
		#var properties_array = mp.root.prep_prefab_array(properties_dict).duplicate()
		#mp.root.request_rpc_prefab.rpc_id(1,"Spell_Projectiles", projectile.get_path(), prefab_pos, Vector3.ZERO, properties_array)
		print("Fix_Spell_Projectile.gd")

func post_cast(_target, _caster):
	for child in get_children() as Array[SpellEffect]:
		child.post_cast(_target, _caster)

func tick(_target):
	pass

func execute(target_body_path,caster_body_path):
	for child in get_children() as Array[SpellEffect]:
		child.cast(target_body_path, caster_body_path)
