display_set_gui_size( view_wport[0], view_hport[0] );
var scale = window_get_width() / camera_get_view_width( view_camera[0] );

switch( background ) 
{
	default:
		title_sprite = spr_title;
		BGIsAnimated = true;
		anim_spd = 0.09;
		break;
}

draw_sprite_ext( background, background_index, 0, 0, 1, 1, 0, image_blend, image_alpha );

draw_set_halign( fa_left );
draw_set_valign( fa_middle );

var amnt		= 0.5;

color			= merge_color( #2f0022, #66002e, abs( sin( siner + 1 ) ) );
color2			= merge_color( #040007, #18001e, abs( sin( siner + 1 ) ) );

for( var i = 0; i < sprite_get_number( spr_ui_mainmenu_titlebg ); ++i )
{
	var _sin = sin( siner + ( i * amnt ) );
	var _cos = cos( siner + ( i * amnt ) );
	
	draw_sprite_ext( spr_ui_mainmenu_titlebg, i, _sin + 51 + ( 23 * i ), _cos + 45, 0.6, 0.6, 0 + _sin, merge_color( color, color2, abs( sin( siner + 1 ) ) ), image_alpha );
}

for( var i = 0; i < sprite_get_number( spr_ui_mainmenu_title ); ++i )
{
	var _sin = sin( siner + ( i * amnt ) );
	var _cos = cos( siner + ( i * amnt ) );
	
	draw_sprite_ext( spr_ui_mainmenu_title, i, _sin + 52 + ( 24 * i ), _cos + 46, 0.6, 0.6, 0 + _cos, image_blend, image_alpha );
}

controller.draw();

draw_sprite( spr_cursor_ui, -1, mouse_x, mouse_y );