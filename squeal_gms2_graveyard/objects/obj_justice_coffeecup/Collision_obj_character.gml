if ( !knocked_over )
{
	spd				+= 4;
	sprite_index	= spr_debris_coffeecupflying
	image_angle		= other.charLegDir;
	direction		= other.charLegDir;
}

knocked_over = true;