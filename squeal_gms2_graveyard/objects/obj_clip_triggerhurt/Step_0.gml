var entity = instance_nearest( x, y, obj_character)

if ( place_meeting( x, y, entity) )
{
	hurt_timer = max( 0, hurt_timer - 1 );
	
	if ( hurt_timer == 0 )
	{
		entity.stats.hp -= damage;
		hurt_timer = hurt_maxtimer;
	}
}

hurt_timer = clamp( hurt_timer, 0, hurt_maxtimer );
