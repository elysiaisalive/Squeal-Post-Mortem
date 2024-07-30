/// @description scrGore_ExplosionGore_Part(victim, explosion_id, force, sprite)
/// @param victim
/// @param  explosion_id
/// @param  force
/// @param  sprite
function scrGore_ExplosionGore_Part() {
	var victim = argument[0];
	var explosion = argument[1];

	var _x = victim.x;
	var _y = victim.y;
	var _sprite = -1;
	var _index = 0;
	var _force = argument[2];
	if (argument_count > 3) {
	    _sprite = argument[3]
	    _index = random(sprite_get_number(_sprite))
	}
	var dir = random_range(0, 360);
	var dis = 6 + random(8);
	var inst = instance_create_depth(_x + lengthdir_x(dis, dir), _y + lengthdir_y(dis, dir), -7, objExplosionGore);
	var dir = point_direction(explosion.x, explosion.y, inst.x, inst.y);
	var dis = point_distance(explosion.x, explosion.y, inst.x, inst.y);

	var amount = (1 - clamp((dis - 24) / (explosion.shockwave_size * 2), 0, 1)) * _force;

	inst.sprite_index = _sprite
	inst.image_index = _index
	inst.gore_frc = 0.5

	inst.direction = dir
	inst.gore_spd = amount
	inst.image_angle = random(360)

	return inst



}
