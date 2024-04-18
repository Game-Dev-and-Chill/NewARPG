extends GPUParticles3D
class_name Projectile_GPUParticles3D

func _ready():
	for draw_pass in [draw_pass_1, draw_pass_2, draw_pass_3, draw_pass_4]:
		if draw_pass:
			draw_pass.size = Vector2(owner.scale.x * draw_pass.size.x, owner.scale.x * draw_pass.size.y)
