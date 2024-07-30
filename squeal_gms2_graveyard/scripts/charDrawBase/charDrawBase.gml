function charDrawBase() {
    switch( char_state ) {
    	case CSTATE.ALIVE :
    		var charLegDir = point_direction( 0, 0, currentXSpd, currentYSpd );
    		
    		// Draw hit feedback for armour
    		var c_1 = #55FFFF;
    		
    		draw_set_alpha( 0.65 );
    		gpu_set_blendmode( bm_add );
    		draw_circle_color( x, y, damageTaken, c_1, c_black, false );
    		draw_set_alpha( 1 );
    		gpu_set_blendmode( bm_normal );
    		
    		damageTaken = clamp( damageTaken, 0, 32 );
    		
    		// Character Sprite
    		if ( !is_undefined( currentAnimation )
    		&& sprite_exists( currentAnimation.anim ) ) {
    			draw_sprite_ext( currentAnimation.anim, animIndex, x + 1, y + 1, xscale, yscale * sign( 0.5 - flipped ), transform.angle, c_black, image_alpha * 0.5 );
    		
    			if ( !is_undefined( currentLegAnimation ) ) {
    				draw_sprite_ext( currentLegAnimation.anim, charLegAnimIndex, x + 1, y + 1, xscale, yscale, charLegDir, c_black, image_alpha * 0.5 );
    				draw_sprite_ext( currentLegAnimation.anim, charLegAnimIndex, x, y, xscale, yscale, charLegDir, image_blend, image_alpha );
    			}
    		
    			draw_sprite_ext( currentAnimation.anim, animIndex, x, y, xscale, yscale * sign( 0.5 - flipped ), transform.angle, image_blend, image_alpha );
    			draw_text( x, y, stats.hp );
    		}
    		
    		break;
    	case CSTATE.DOWN :
    		draw_sprite_ext( sprite_index, knocked_index, x, y, xscale, yscale, charLookDir, c_white, 1 );
    		break;
    	case CSTATE.EXECUTE :
    		draw_sprite_ext( sprite_index, animIndex, x, y, xscale, yscale, charLookDir, c_white, 1 );
    		break;
    }
    #endregion
    
    if ( global.camera_mode == e_cameraMode.perspective_thirdperson ) {
    	
    	matrix_set( matrix_world, matrix_build( x + depth, y, z, 270, 90, 0, 1, 1, 1 ) );
    	draw_sprite( sprJoe_3dRef, 0, 0, 0 );
    	matrix_set( matrix_world, matrix_build_identity() );
    }
}