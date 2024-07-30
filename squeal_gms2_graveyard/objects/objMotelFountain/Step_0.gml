event_inherited();
var _other = instance_nearest(x, y, obj_proj_bullet)

var impact = choose(
	snd_impact_brick,
	snd_impact_brick1,
	snd_impact_brick2,
	snd_impact_brick3,
)
#region Collision
if place_meeting(x, y, _other) {
playsound_at(impact, x, y, 16 * 12, 16 * 12)

repeat(random_range(2, 6)) {
	spawn_particle(
		obj_particle_generic,
		sprSmokeHit,
		2,
		_other.x,
		_other.y,
		random_range(4, 6), 
		random_range(0.3, 0.6), 
		60,
		random(360),
		0.4,
		0.4
		)
}
	var inst = instance_create_depth(x, y, -15, obj_debris_generic)
		inst.sprite_index = spr_debris_concrete_small
		inst.image_index = random(7)
		inst.x = _other.x
		inst.y = _other.y
		inst.flying = true;
		inst.flyspeed = 8;
		inst.debris_spd = random_range(5, 7)
		inst.debris_frc = random_range(0.2, 0.3)
		inst.direction = _other.direction - 180 + random_range(-90, 90)
		inst.image_angle += inst.direction
	repeat(random_range(4, 12)) {
		var inst = instance_create_depth(x, y, -15, obj_debris_generic)
		inst.sprite_index = spr_debris_concrete_small
		inst.image_index = random(6)
		inst.x = _other.x
		inst.y = _other.y
		inst.flying = true;
		inst.flyspeed = 2;
		inst.debris_spd = random_range(3, 5)
		inst.debris_frc = random_range(0.2, 0.3)
		inst.direction = _other.direction - 180 + random_range(-90, 90)
		inst.image_angle += inst.direction
	}
		instance_destroy(_other);
	if _other.hp_damage >= 50 {
	repeat(random_range(4, 12)) {
		var inst = instance_create_depth(x, y, -15, obj_debris_generic)
		inst.sprite_index = spr_debris_concrete_med
		inst.image_index = random(6)
		inst.x = _other.x
		inst.y = _other.y
		inst.flying = true;
		inst.flyspeed = 3;
		inst.debris_spd = random_range(4, 6)
		inst.debris_frc = random_range(0.4, 0.6)
		inst.direction = _other.direction - 180 + random_range(-90, 90)
		inst.image_angle += inst.direction
		}
	}
}
#endregion