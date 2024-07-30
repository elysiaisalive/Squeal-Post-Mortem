function scr_gore_fatexplode(){

	#region Body Parts
	repeat(random_range(36, 42))
	{
		var inst = instance_create_depth(x, y, -15, obj_gore_bloodtrail)
		inst.sprite_index = spr_gore_guts
		inst.image_index = random(image_number)
		inst.trail_sprite = spr_bloodtrail_small
		inst.flying = true
		inst.flying_speed = 10
		inst.gore_spd = random_range(6, 8)
		inst.gore_frc = random_range(0.2, 0.3)
		inst.direction = random_range(0, 360)
		inst.image_angle = inst.direction + random(360)
	}
	repeat(2)
	{
		var inst = instance_create_depth(x, y, -15, obj_gore_bloodtrail)
		inst.sprite_index = spr_gore_fatarms
		inst.image_index = random(image_number)
		inst.trail_sprite = spr_bloodtrail_small
		inst.flying = true
		inst.flying_speed = 8
		inst.gore_spd = random_range(8, 10)
		inst.gore_frc = random_range(0.3, 0.4)
		inst.direction = random_range(0, 360)
		inst.image_angle = inst.direction + random(360)
	}
	repeat(random_range(16, 24))
	{
		var inst = instance_create_depth(x, y, -15, obj_gore_bloodtrail)
		inst.sprite_index = spr_gore_fatskin_big
		inst.image_index = random(image_number)
		inst.trail_sprite = spr_bloodtrail_small
		inst.flying = true
		inst.flying_speed = 10
		inst.gore_spd = random_range(8, 10)
		inst.gore_frc = random_range(0.3, 0.4)
		inst.direction = random_range(0, 360)
		inst.image_angle = inst.direction + random(360)
	}
	repeat(random_range(24, 36))
	{
		var inst = instance_create_depth(x, y, -15, obj_gore_bloodstatic)
		inst.sprite_index = spr_gore_fatskin_small
		inst.image_index = random(image_number)
		inst.gore_spd = random_range(8, 10)
		inst.gore_frc = random_range(0.3, 0.4)
		inst.direction = random_range(0, 360)
		inst.image_angle = inst.direction + random(360)
	}
	repeat(random_range(24, 32))
	{
		var inst = instance_create_depth(x, y, -15, obj_gore_bloodsplat)
		inst.sprite_index = choose(spr_gore_fatblubber, spr_gore_fatblubber2)
		inst.flying = true
		inst.gore_spd = random_range(3, 6)
		inst.gore_frc = random_range(0.1, 0.2)
		inst.direction = random_range(0, 360)
		inst.image_angle = inst.direction
	}
	#endregion
	#region Blood Splatters
	repeat(random_range(32, 36))
	{
		var inst = instance_create_depth(x, y, -15, obj_gore_bloodstatic)
		inst.sprite_index = spr_bloodspeck_small
		inst.image_index = random(image_number)
		inst.gore_spd = random_range(5, 6)
		inst.gore_frc = random_range(0.3, 0.5)
		inst.direction = random_range(0, 360)
		inst.image_angle = inst.direction
				
		var inst = instance_create_depth(x, y, -15, obj_gore_bloodstatic)
		inst.sprite_index = spr_bloodspeck_med
		inst.image_index = random(image_number)
		inst.gore_spd = random_range(5, 6)
		inst.gore_frc = random_range(0.3, 0.5)
		inst.direction = random_range(0, 360)
		inst.image_angle = inst.direction
	}
	repeat(random_range(10, 14))
	{
		var inst = instance_create_depth(x, y, -15, obj_gore_bloodsplat)
		inst.sprite_index = choose(sprBloodWave1, sprBloodWave2, sprBloodWave3)
		inst.gore_spd = 6
		inst.gore_frc = random_range(0.2, 0.3)
		inst.direction = random_range(0, 360)
		inst.image_angle = inst.direction
	}
	#endregion
	#region Puss Splatters
	repeat(random_range(24, 32))
	{
		var inst = instance_create_depth(x, y, -15, obj_gore_bloodsplat)
		inst.sprite_index = choose(spr_puss_smudge, spr_puss_smudge2, spr_puss_smudge3, spr_puss_smudge4, spr_puss_smudge5)
		inst.gore_spd = random_range(3, 6)
		inst.gore_frc = random_range(0.1, 0.2)
		inst.direction = random_range(0, 360)
		inst.image_angle = inst.direction
	}
	repeat(random_range(32, 36))
	{
		var inst = instance_create_depth(x, y, -15, obj_gore_bloodstatic)
		inst.sprite_index = spr_puss_speck
		inst.image_index = random(image_number)
		inst.gore_spd = random_range(4, 6)
		inst.gore_frc = random_range(0.2, 0.3)
		inst.direction = random_range(0, 360)
		inst.image_angle = inst.direction
	}
	repeat(random_range(18, 24))
	{
		var inst = instance_create_depth(x, y, -15, obj_hazard_goo)
		inst.image_index = random(image_number)
		inst.hazard_spd = random_range(2, 3)
		inst.hazard_frc = random_range(0.1, 0.2)
		inst.direction = random_range(0, 360)
		inst.image_angle = inst.direction
	}
	#endregion
	repeat(random_range(4, 7))
	{
		spawn_particle(
			obj_particle_generic, 
			spr_bloodspray, 
			0.2, 
			random(360), 
			random(360), 
			1, 
			x, 
			y, 
			random_range(6, 8), 
			random_range(0.1, 0.3), 
			1, 
			false, 
			true
			);
	}
	repeat(random_range(24, 32))
	{
		spawn_particle(
			obj_particle_generic, 
			choose(sprBloodWave1, sprBloodWave2, sprBloodWave3), 
			0.2, 
			random(360), 
			random(360), 
			1, 
			x, 
			y, 
			random_range(3, 6), 
			random_range(0.1, 0.3), 
			1, 
			false, 
			true
			);
	}
}