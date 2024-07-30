//event_inherited();
//var soundrangestart = x
//var soundrangeend = 16 * 6
//var bullet = instance_nearest(x, y, obj_proj_bullet)

//if (d_state == cState.alive)
//{
//	if (place_meeting(x, y, bullet))
//	{
//		f_index = 1;
//		hp -= bullet.hp_damage
//		playsound_at(sndMolotov, x, y, soundrangestart, soundrangeend)
//		repeat(random_range(10, 12)) 
//		{
//			spawn_particle(
//			obj_particle_generic,
//			sprFireBallSmall,
//			1,
//			x,
//			y,
//			random_range(4, 8),
//			random_range(0.2, 0.4),
//			200,
//			random(360),
//			0.1,
//			1,
//			1,
//			true,
//			random(360)
//			)
//		}
//		//repeat(random_range(10, 12)) 
//		//{
//		//	var inst = instance_create_depth(x, y, -15, obj_debris_generic)
//		//	inst.sprite_index = spr_
//		//	inst.image_index = random(3)
//		//	inst.debris_spd = random_range(5, 7)
//		//	inst.debris_frc = random_range(0.2, 0.5)
//		//	inst.flying = true
//		//	inst.flyspeed = 5
//		//	inst.direction = (bullet.direction - 180 + random_range(-90, 90))
//		//	inst.image_angle = random(360)
//		//}
//		instance_destroy(bullet);
//		instance_destroy();
//		d_state = (cState.destroyed)
//	}
//}