var _other = instance_nearest( x, y, obj_proj_generic );

if ( place_meeting( x, y, _other ) )
{
	hp -= 50;
	
	playsound_at( snd_break_glass, x, y );
	
	repeat( random_range( 2, 3  * ( _other.hp_damage ) / hp ) )
	{
		var inst = instance_create_depth( x, y, -10, obj_debris_generic )
		inst.sprite_index = spr_debris_toilet_small;
		inst.image_index = random( image_number );
		inst.debris_spd = random_range( 2, 3 );
		inst.debris_frc = random_range( 0.1, 0.2 );
		inst.direction = _other.direction - 180 + random_range( -90, 90 );
		inst.image_angle = random( 360 ) + inst.direction;
	}
	
	instance_destroy( _other );
}


if ( hp <= 100 )
{
	image_index = 1;
}

if ( hp <= 25 )
{
	image_index = 2;
}

hp = clamp( hp, 0, hp_max );