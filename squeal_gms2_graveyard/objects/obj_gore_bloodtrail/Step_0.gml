event_inherited();

trail_timer = max( 0, trail_timer - 1 * delta );
trail_timer = clamp( trail_timer, 0, trail_timermax );

if ( trail_timer == 0 )
{
	var inst = instance_create_depth( x, y, -15, obj_gore_generic )
	inst.sprite_index = trail_sprite;
	inst.image_index += gore_spd * random_range( 0.5, 3 );
	inst.direction = direction;
	inst.image_angle = inst.direction;
	
	if ( random_rotation )
	{
		inst.image_angle = random( 360 );
	}
	
	trail_timer = random_range( 1, 3 );
}
