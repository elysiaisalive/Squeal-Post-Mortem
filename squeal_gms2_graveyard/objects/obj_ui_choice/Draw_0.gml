// Drawing the temp controls list
var _x			= room_width / 2 ;
var _y			= room_height / 2;

draw_set_halign( fa_center );

draw_sprite_ext( form_sprite, anim_spd, _x + 2, page_yoffset + 2, image_xscale, image_yscale, sin( -rot * 8 ), c_black, 0.5 );

draw_sprite_ext( form_sprite, anim_spd, _x, page_yoffset, image_xscale, image_yscale, image_angle, image_blend, image_alpha );


if ( selected == -1 )
{
	draw_sprite_ext( spr_ui_choice_action, anim_spd, glasses_xoffset + 2, _y + 2, glasses_scale, glasses_scale, sin( -rot * 2 ), c_black, 0.5 );
	
	draw_set_font( fnt_test );
	draw_set_color( c_black );
	draw_text( glasses_xoffset + 1, _y + 41, action_string );
	draw_set_color( c_white );
	draw_text( glasses_xoffset, _y + 40, action_string );
}
if ( selected == 1 )
{
	draw_sprite_ext( spr_ui_choice_justice, anim_spd, badge_xoffset + 2, _y + 2, badge_scale, badge_scale, sin( -rot * 2 ), c_black, 0.5 );
	
	draw_set_font( fnt_test );
	draw_set_color( c_black );
	draw_text( badge_xoffset + 1, _y + 41, justice_string );
	draw_set_color( c_white );
	draw_text( badge_xoffset, _y + 40, justice_string );
}

draw_sprite_ext( spr_ui_choice_action, anim_spd, glasses_xoffset, _y, glasses_scale, glasses_scale, sin( rot ), image_blend, image_alpha );
draw_sprite_ext( spr_ui_choice_justice, anim_spd, badge_xoffset, _y, badge_scale, badge_scale, sin( rot ), image_blend, image_alpha );

draw_set_font( fnt_handwritten );

draw_text( _x, _y, string ( display_string ) );

if ( surface_exists( draw_surf ) )
{	
	draw_surface( draw_surf, 155, 16 );
} 
else 
{ 
	draw_surf = surface_create( surf_x, surf_y );
}

var mousex = mouse_x;
var mousey = mouse_y;

draw_sprite_ext( spr_ui_choice_cursor, 0, mousex, mousey, image_xscale, image_yscale, image_angle, image_blend, image_alpha );