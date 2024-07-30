function effects_explode_char() 
{
	global.shake = 15;
	
	repeat( random_range( 10, 12 ) ) 
	{
		var inst = instance_create_depth( x, y, -10, obj_gore_bloodtrail )
		inst.trail = true;
		inst.trail_sprite = spr_effect_chartrail_med;
		inst.sprite_index = spr_effect_chartrail_med;
		inst.image_index = random( image_number );
		inst.animated = false;
		inst.gore_spd = random_range( 8, 10 );
		inst.gore_frc = random_range( 0.8, 1 );
		inst.direction = random_range( 0, 360 );
		inst.image_angle = inst.direction;
		inst.surfacetype = obj_surface_manager.GetSurf();
	}
	
	//Initial Splat
	var inst = instance_create_depth( x, y, -10, obj_gore_generic )
	inst.sprite_index = spr_effect_charsplat_huge;
	inst.animated = false;
	inst.image_angle = random( 360 );
	inst.surfacetype = obj_surface_manager.GetSurf();
	
	spawn_particle(
	obj_particle_generic,
	spr_effect_explosion,
	1,
	0,
	random_range( -360, 360 ),
	1,
	x,
	y,
	0,
	0,
	1,
	false,
	true,
	-256,
	true,
	0.05
	);
}
