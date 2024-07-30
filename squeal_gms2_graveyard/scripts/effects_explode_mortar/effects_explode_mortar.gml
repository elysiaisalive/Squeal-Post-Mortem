function effects_explode_mortar() 
{
	global.shake = 15;
	
	repeat( random_range( 10, 12 ) ) 
	{
		var inst = instance_create_depth( x, y, -10, obj_gore_bloodtrail );
		
		inst.trail = true;
		inst.trail_sprite = spr_effect_chartrail_med;
		inst.sprite_index = spr_effect_chartrail_med;
		inst.image_index = random( image_number );
		inst.animated = false;
		inst.gore_spd = random_range( 8, 10 );
		inst.gore_frc = random_range( 0.8, 1 );
		inst.direction = random_range( 0, 360 );
		inst.image_angle = inst.direction;
		inst.x = x + lengthdir_x( random_range( 10, 12 ), inst.direction );
		inst.y = y + lengthdir_y( random_range( 10, 12 ), inst.direction );
		inst.surfacetype = obj_surface_manager.GetSurf();
	}
	
	//Initial Splat
	var inst = instance_create_depth( x, y, -10, obj_gore_generic );
	
	inst.sprite_index = spr_effect_charsplat_huge;
	inst.animated = false;
	inst.image_angle = random( 360 );
	inst.surfacetype = obj_surface_manager.GetSurf();
	
	var inst = instance_create_depth( x, y, -15, obj_gore_generic );
	
	inst.sprite_index = spr_mortar_crater;
	inst.animated = false;
	inst.done = false;
	inst.image_angle = random( 360 );
	inst.surfacetype = obj_surface_manager.GetSurf();
}
