display_set_gui_size( view_wport[0], view_hport[0] );
var scale = window_get_width() / camera_get_view_width( view_camera[0] );

var divfactor	= 2;

var _x			= room_width / divfactor;
var _y			= room_height / divfactor;

var scale = window_get_width() / camera_get_view_width( CURRENT_VIEW );

//draw_sprite_ext( global.pause_png, 0, 0, 0, scale, scale, 0, c_white, image_alpha );

#region Dark overlay
var _x2 = camera_get_view_width( CURRENT_VIEW );
var _y2 = camera_get_view_height( CURRENT_VIEW );

var c_mixed = c_black + merge_color( c_black, c_red, abs( sin( siner ) ) );
var c_mixed2 = c_black + merge_color( c_teal, c_black, abs( sin( siner ) ) );

draw_set_alpha( alpha );
{
	draw_rectangle_color( 
		0, 
		0, 
		_x2 + _y2 * scale, 
		_y2 + _x2 * scale, 
		c_mixed2, 
		c_mixed2, 
		c_mixed, 
		c_mixed,
		false
		);
}
draw_set_alpha( 1 );
#endregion

controller.draw();

draw_sprite_ext( spr_defaultmouse, -1, mouse_x, mouse_y, 1, 1, 0, image_blend, image_alpha );