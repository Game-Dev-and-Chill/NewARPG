extends GPUParticles3D
class_name Projectile_GPUParticles3D


func _ready():
    if draw_pass_1:
        draw_pass_1.size = Vector2(owner.scale.x*draw_pass_1.size.x,owner.scale.x*draw_pass_1.size.y)
    if draw_pass_2:
        draw_pass_2.size = Vector2(owner.scale.x*draw_pass_2.size.x,owner.scale.x*draw_pass_2.size.y)
    if draw_pass_3:
        draw_pass_3.size = Vector2(owner.scale.x*draw_pass_3.size.x,owner.scale.x*draw_pass_3.size.y)
    if draw_pass_4:
        draw_pass_4.size = Vector2(owner.scale.x*draw_pass_4.size.x,owner.scale.x*draw_pass_4.size.y)
