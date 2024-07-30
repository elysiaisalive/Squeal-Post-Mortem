event_inherited();

if ( wall_hp <= 100 )
{
	image_index = 1;
}

if ( wall_hp <= 25 )
{
	image_index = 2;
}

wall_hp = clamp( wall_hp, 0, wall_maxhp );