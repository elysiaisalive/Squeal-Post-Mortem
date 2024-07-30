#region Player Draw
switch( char_state )
{
	case CSTATE.ALIVE :
	
		var len_x = lengthdir_x( 18, charLookDir );
		var len_y = lengthdir_y( 18, charLookDir );
		
		draw_sprite_ext( sprite_index, image_index, x + 1, y + 1, xscale, yscale, charLookDir, c_black, image_alpha * 0.5 );		
		draw_sprite_ext( sprite_index, image_index, x, y, xscale, yscale , charLookDir, image_blend, image_alpha );
		
		draw_sprite_ext( head_index, image_index, ( x + len_x ), ( y + len_y ), xscale, yscale, head_dir, image_blend, image_alpha );
}
#endregion