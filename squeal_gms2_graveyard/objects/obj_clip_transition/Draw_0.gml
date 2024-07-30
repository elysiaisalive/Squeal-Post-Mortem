if ( instance_exists( global.input_target ) ) {
	switch( global.input_target.charName )
	{
		default :
			arrow_sprite = spr_icon_goarrow_generic;
			break;
		case "Joe" :
			arrow_sprite = spr_icon_goarrow_joe;
			break;
		case "Derby" :
			arrow_sprite = spr_icon_goarrow_derby;
			break;
		
	};
};

if ( active && arrow )
{
	draw_sprite_ext( arrow_sprite, image_index, arrow_xmove, arrow_ymove, 1, 1, image_angle, image_blend, 1 );
};