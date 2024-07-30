if ( char_state == CSTATE.ALIVE )
{
	if ( barrel_cool )
	{
		gpu_set_blendmode( bm_add );
		draw_set_alpha( 0.5 );
	
		var c_shift = merge_color( c_red, c_black, abs( sin( siner ) ) );
	
		draw_circle_color( x, y, 32, c_shift, c_black, false );
	
		draw_set_alpha( 1 );
		gpu_set_blendmode( bm_normal );
	}
	else
	{
		c_shift = merge_color( c_lime, c_black, abs( sin( siner ) ) );
	}
	
		var charLegDir = point_direction( 0, 0, currentXSpd, currentYSpd );
		var legs = ( currentXSpd != 0 ) && ( currentYSpd != 0 );
		
		// Draw hit feedback for armour
		var c_1 = #55FFFF;
		
		draw_set_alpha( 0.65 );
		gpu_set_blendmode( bm_add );
		draw_circle_color( x, y, damageTaken, c_1, c_black, false );
		draw_set_alpha( 1 );
		gpu_set_blendmode( bm_normal );
		
		damageTaken = clamp( damageTaken, 0, 32 );
	
		draw_sprite_ext( sprite_index, image_index, x + 1, y + 1, xscale, yscale * sign( 0.5 - flipped ), charLookDir, c_black, image_alpha * 0.5 );
		
		if ( character_legs != noone )
		{
			draw_sprite_ext( character_legs, legindex, x + 1, y + 1, xscale, yscale, charLegDir, c_black, image_alpha * 0.5 );
			draw_sprite_ext( character_legs, legindex, x, y, xscale, yscale, charLegDir, image_blend, image_alpha );
		}
		
		draw_sprite_ext( sprite_index, image_index, x, y, xscale, yscale * sign( 0.5 - flipped ), charLookDir, image_blend, image_alpha );
	
	// Overheated Barrel
	var c_heat = merge_color( c_red, c_orange, 0.2 );
	
	draw_sprite_ext(
		barrel_sprite, 
		image_index,
		x, 
		y, 
		xscale, 
		yscale, 
		charLookDir, 
		c_heat, 
		barrel_heat
		);
}
