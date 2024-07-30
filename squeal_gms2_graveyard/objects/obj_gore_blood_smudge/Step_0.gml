event_inherited();

if ( ( gore_spd <= 0 ) && !blood_created )
{
	blood_created = true;
	
	repeat( random_range( 12, 16 ) )
	{
		var inst = instance_create_depth( x, y, -15, obj_gore_generic );
		inst.sprite_index = spr_bloodspeck_small;
		inst.image_index = floor( random( image_number ) );
		inst.gore_spd = random_range( 4, 5 );
		inst.gore_frc = random_range( 0.4, 0.6 );
		inst.done = false;
		inst.direction = direction + random_range( -25, 25 );
		inst.image_angle = inst.direction;
	}
}