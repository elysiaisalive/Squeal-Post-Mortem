function scr_draw_outline( xx = 0, yy = 0, index = 0, outline_scale = 1,  angle = image_angle, color = c_white, alpha = image_alpha, sprite = sprite_index ) {
	
	gpu_set_fog( true, color, 0, 0 );
	
	for ( var i = 0; i < 360; i += 90 )
	{
		draw_sprite_ext( sprite, index, xx + dcos( i ) * outline_scale, yy + dsin( i ) * outline_scale, 1, 1, angle, color, alpha )
	}
	
	gpu_set_fog( false, 0, 0, 0 );
}