renderer = new BulbRenderer( global.amblight_colour, BULB_MODE.HARD_BM_MAX, global.smooth_lighting );

SaveState = function( buf = global.checkpoint ) {
	var hsv = {
		h : color_get_hue( global.amblight_colour ),
		s : color_get_saturation( global.amblight_colour ),
		v : color_get_value( global.amblight_colour )
	};
	
	buffer_write( buf, buffer_u8, hsv.h );
	buffer_write( buf, buffer_u8, hsv.s );
	buffer_write( buf, buffer_u8, hsv.v );
}
LoadState = function( buf = global.checkpoint ) {
	var _h = buffer_read( buf, buffer_u8 );
	var _s = buffer_read( buf, buffer_u8 );
	var _v = buffer_read( buf, buffer_u8 );
	
	hsv = {
	    h : _h,
	    s : _s,
	    v : _v
	};
	
	var color = make_color_hsv( hsv.h, hsv.s, hsv.v );
	
	bulb_set_ambientlight_colour( color );
}