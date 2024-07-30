var entity = instance_nearest( x, y, obj_character)

if ( place_meeting( x, y, entity) )
{
	entity.stats.hp = 0;
}
