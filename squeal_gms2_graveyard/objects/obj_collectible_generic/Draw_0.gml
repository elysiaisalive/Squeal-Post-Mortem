if ( shadow_depth > 0 )
{
	draw_sprite_ext( sprite_index, image_index, x + shadow_depth, y + shadow_depth, image_xscale, image_yscale, image_angle, c_black, 0.5 );
}

var dist = point_distance( x, y, obj_player.x, obj_player.y );

if ( dist <= 16 )
{
	outline_a = max( 0, outline_a + 0.05 );
}
else
if ( dist >= 16 )
{
	outline_a = max( 0, outline_a - 0.05 );
}

scr_draw_outline( x, y, image_index, 1, image_angle, c_white, outline_a, sprite_index );

outline_a = clamp( outline_a, 0, 1 );

draw_sprite_ext( sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha )