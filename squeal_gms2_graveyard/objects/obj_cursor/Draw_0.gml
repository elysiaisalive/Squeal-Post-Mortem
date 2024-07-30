var angle = camera_get_view_angle( CURRENT_VIEW );

if ( instance_exists( global.input_target ) ) {
	if ( obj_player.char_state == CSTATE.ALIVE )
	{
		if ( !mouse_locked )
		{
			draw_sprite_ext(
				sprCursor_Joe, 
				cursor_speed + cursor_animationspeed, 
				global.mousex + 2, 
				global.mousey + 2, 
				cursor_scale, 
				cursor_scale, 
				angle, 
				c_black, 
				0.5
				);
			//gpu_set_blendmode_ext( bm_inv_dest_colour, bm_inv_src_alpha );
	
			draw_sprite_ext(
				sprCursor_Joe, 
				cursor_speed + cursor_animationspeed, 
				global.mousex + 1, 
				global.mousey + 1, 
				cursor_scale, 
				cursor_scale, 
				angle, 
				c_white,
				1
			);
			//gpu_set_blendmode( bm_normal );
		}
		else if ( instance_exists( mouse_target ) && mouse_locked && mouse_target != noone )
		{
			scr_draw_outline(
				global.mousex,
				global.mousey,
				mouse_target.image_index,
				mouse_target.image_xscale,
				mouse_target.charLookDir,
				merge_color( c_red, c_white, 0.2 ),
				sin( lock_sin ),
				mouse_target.currentAnimation.anim
			);
			draw_sprite_ext(
				mouse_target.currentAnimation.anim, 
				mouse_target.image_index, 
				global.mousex, 
				global.mousey, 
				mouse_target.image_xscale, 
				mouse_target.image_yscale, 
				mouse_target.charLookDir,
				c_white, 
				1
				);	
			draw_sprite_ext(
				sprCursor_Joe, 
				cursor_speed + cursor_animationspeed, 
				global.mousex + 1, 
				global.mousey + 1, 
				cursor_scale, 
				cursor_scale, 
				angle, 
				c_white,
				1
				);
		}
		//gpu_set_blendmode( bm_normal );
	}
};