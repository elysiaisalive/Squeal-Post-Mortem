event_inherited();

if ( wall_hp <= 150 )
{
	image_index = 1;
}

if ( wall_hp <= 75 )
{
	image_index = 2;
}

wall_hp = clamp( wall_hp, 0, wall_maxhp );