/// @description  MOUSE PRE
if ( !global.input_blocked ) {
	var app = application_get_position();
	
	var left	= app[0];
	var top		= app[1];
	var right	= app[2];
	var bottom	= app[3];
	
	var width	= right - left;
	var height	= bottom - top;
	
	var rawmousex = ( display_mouse_get_x() - ( window_get_x() + left ) );
	var rawmousey = ( display_mouse_get_y() - ( window_get_y() + top ) );
	
	var mousex = clamp( rawmousex, 0, width) ;
	var mousey = clamp( rawmousey, 0, height );
	
	var mousexscale = clamp( mousex / width, 0, 1 );
	var mouseyscale = clamp( mousey / height, 0, 1 );
	
	var mousex = ( camera_get_view_width( view_camera ) * ( mousexscale - 0.5 ) );
	var mousey = ( camera_get_view_height( view_camera ) * ( mouseyscale - 0.5 ) );

	global.mousex_raw = mousex;
	global.mousey_raw = mousey;
	
	if ( global.firstperson ) {
		mouse_midx = window_get_x() + floor(window_get_width() / 2);
		mouse_midy = (window_get_y() + floor(window_get_height() / 2));
		
		var xmove = -(display_mouse_get_x() - mouse_xprev ) * global.mouse_sensitivity;
		var ymove = -(display_mouse_get_y() - mouse_yprev ) * global.mouse_sensitivity;
		
		global.mouseh = (global.mouseh + xmove) % 360;
		global.mousev = clamp(global.mousev + ymove, 0, 180);
	
		global.mousex_raw = dcos( global.mouseh ) * 100;
		global.mousey_raw = -dsin( global.mousev ) * 100;
	
		display_mouse_set( mouse_midx, mouse_midy );
		mouse_xprev = display_mouse_get_x();
		mouse_yprev = display_mouse_get_y();
	
	}
}