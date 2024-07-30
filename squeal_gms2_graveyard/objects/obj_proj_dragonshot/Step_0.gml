event_inherited();
ammo_type = BULLETCAL.PELLET;
//audio_emitter_position(whizz, x, y, 1);
//audio_emitter_pitch(whizz, delta);

//if !object_exists(obj_proj_bullet)
//	audio_emitter_free(whizz);

//if !audio_emitter_exists(whizz) {
//	whizz = audio_emitter_create();
//}
if (bullet_velocity > 0) 
{
	fire_delay = max(fire_delay - 1 * delta)
	fire_delay = clamp(fire_delay, 0, 2)
	if (fire_delay == 0)
	{
		var inst = instance_create_depth(x, y, -15, obj_hazard_dragonfire)
		inst.speed = 2
		inst.friction = 0.2
		//inst.image_angle = random_range(-90, 90)
		inst.direction = random(360)
		repeat(2) {
		var inst = instance_create_depth(x, y, -15, obj_gore_generic)
		inst.gore_spd = 1
		inst.gore_frc = 0.2
		inst.sprite_index = sprCharBits
		inst.image_index = random(3)
		inst.image_angle = random(360)
		inst.direction = random(360)
		inst.image_alpha = random_range(0.4, 0.8)
		}
		#region Particles
		spawn_particle(
			obj_particle_generic,
			spr_effect_dragonsbreathbigspit,
			0.4,
			direction,
			direction,
			1,
			x,
			y,
			4,
			0.3,
			1,
			false
			)
		spawn_particle(
			obj_particle_generic,
			choose(spr_effect_dragonsbreathspit, spr_effect_dragonsbreathspit2, spr_effect_dragonsbreathspit3),
			0.3,
			direction,
			direction,
			1,
			x - lengthdir_x(10, direction),
			y - lengthdir_y(10, direction),
			4,
			0.3,
			1,
			false
			)
		spawn_particle(
			obj_particle_generic,
			spr_effect_dragonsbreathfireball,
			0.4,
			direction,
			direction,
			1,
			x + random_range(-20, 20),
			y + random_range(-20, 20),
			4,
			0.3,
			1,
			false,
			true
			)
		spawn_particle(
			obj_particle_generic,
			spr_effect_spark,
			0.5,
			direction,
			direction,
			1,
			x + random_range(-30, 30),
			y + random_range(-30, 30),
			4,
			0.3,
			1,
			false,
			true
			)
		#endregion
		fire_delay = random_range(1, 4);
	}
}
bullet_color = merge_color(c_orange, c_red, random(1));

bullet_life -= 1 * delta
if (bullet_life <= 0)
{
	instance_destroy();
}