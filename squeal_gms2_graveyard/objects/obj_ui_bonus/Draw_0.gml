// Drawing the temp controls list
var _x			= room_width / 2 ;
var _y			= room_height / 2;
var offset_y2	= 100;

draw_sprite( spr_ui_bonusbg, image_index, 0, 0 );

draw_set_halign( fa_center );
draw_set_valign( fa_bottom );
draw_set_font( fnt_terminal );
draw_set_color( c_white );

draw_text_transformed( _x, _y - 90, str_typed, 0.5, 0.5, 0 );
draw_text_transformed( _x, _y * 1.5, str2_typed, 0.5, 0.5, 0 );

for ( var i = 0; i < array_length( trophy ); ++i ) 
{
	var collectible = trophy[i];

	if ( !collectible.unlocked )
	{
		draw_sprite_ext( collectible.sprite, animspd, _x, _y, image_xscale, image_yscale, image_angle, c_black, image_alpha );
	}
	else
	{
		draw_sprite_ext( collectible.sprite, animspd, _x, _y, image_xscale, image_yscale, image_angle, image_blend, image_alpha );	
	}
}