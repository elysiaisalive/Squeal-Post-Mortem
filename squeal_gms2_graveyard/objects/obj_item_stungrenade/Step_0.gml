event_inherited();
if (grenade_spd > 0)
{
	image_angle += 15 * delta;
}

#region Grenade Detonation
var player = instance_nearest(x, y, obj_player)
var danger_close = 16 * 8;
var blockedbywall = collision_line(x, y, player.x, player.y, obj_wall, false, false)
var in_danger_close = rectangle_in_circle(bbox_left, bbox_top, bbox_right, bbox_bottom, player.x, player.y, danger_close)

grenade_fuse = max(0, grenade_fuse - 1)

if ( grenade_fuse == 0 )
{
	//with(player)
	//{
	//	if (!blockedbywall)
	//	{
	//		if (in_danger_close)
	//		{
				
	//			char_status = STATUS.STUNNED;
	//			can_attack = false;
	//			charThrowWeapon( random_range( 10, 12 ) );
	//		}
	//	}
	//}
	#region Explosion
	global.shake = 25;
	instance_create_depth(x, y, -15, obj_flashbang)
	
	playsound_at(snd_airburst_explode, x, y, (x + y), 16 * 8)
	spawn_particle(
		obj_particle_generic,
		spr_effect_airburstdetonate,
		0.8,
		0,
		random(360),
		1,
		x,
		y,
		0,
		0,
		1,
		true,
		false
	)
	#endregion
	#region Particles
	repeat(random_range(12, 16))
	{
		spawn_particle(
			obj_particle_generic,
			spr_effect_dragonsbreathspit,
			random_range(0.3, 0.5),
			random_range(-360, 360),
			0,
			1,
			x,
			y,
			random_range(6, 8),
			random_range(0.2, 0.4),
			1,
			false,
			true
		)
	}
	#endregion
	instance_destroy();
}
grenade_fuse = clamp(grenade_fuse, 0, grenade_fusemax)
#endregion