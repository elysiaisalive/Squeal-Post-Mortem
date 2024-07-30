function scr_draw_laser( laserlength = currentWeapon.laser_dist, laser_alpha = currentWeapon.laser_alpha, laser_width = currentWeapon.laser_width, laser_color = currentWeapon.laser_color, xx = x, yy = y, _lookdir = charLookDir )
{
	#region Drawing Laser
	var laser_z = z - max( 0, height - 5 );
	
	with obj_worldobject if ( id != other.id )
	{
		if ( !( collision_flags & BLOCK_VISION ) )
		{
			instance_deactivate_object( id );
		}
		else if ( laser_z < ( z - height ) )
		|| ( ( laser_z ) > z )
		{
			instance_deactivate_object( id );
		}
	}
	var _x = xx;
	var _y = yy;
	var xx2 = xx + lengthdir_x( laserlength, _lookdir );
	var yy2 = yy + lengthdir_y( laserlength, _lookdir );
	if ( true )
	{
		do
		{
			var get = collision_line_point( xx, yy, xx2, yy2, obj_worldobject, true, true );
			if ( get.id )
			{
				xx2 = get.x;
				yy2 = get.y;
			}
		}
		until ( get.id == noone ) || 1;
		_x = xx2;
		_y = yy2;
	}
	/*
	else for ( var laser_length = 0; laser_length < laserlength; ++laser_length )
	{
		var _x = x + lengthdir_x( laser_length, _lookdir );
		var _y = y + lengthdir_y( laser_length, _lookdir );
		
		if ( !position_empty( _x, _y ) )
		{
			if ( place_meeting( _x, _y, obj_solid ) || place_meeting( _x, _y, obj_character ) )
			{
				gpu_set_blendmode( bm_add );
				draw_set_alpha( 0.8 );
				draw_circle_color(
					_x - 0.5, 
					_y - 0.5,
					3.5, 
					laser_color, 
					c_black, 
					false
				);
				draw_set_alpha( 1 );
				gpu_set_blendmode( bm_normal );
				break;
			}
		}
	}
	*/
	
	gpu_set_blendmode( bm_add );
	
	laser_alpha = 1;
	
	var dist = point_distance( _x, _y, x, y );
	var dist2 = min( dist / 2, laserlength );
	var amount = ( dist / laserlength );
	
	var xinc = lengthdir_x( laser_width / 2, _lookdir + 90 );
	var yinc = lengthdir_y( laser_width / 2, _lookdir + 90 );
	
	var xadd = lengthdir_x( dist, _lookdir );
	var yadd = lengthdir_y( dist, _lookdir );
	
	var xadd2 = lengthdir_x( dist2, _lookdir );
	var yadd2 = lengthdir_y( dist2, _lookdir );

	var u_off = random( 1 );
	var v_off = random( 1 );
	var u = ( ( dist / 32 ) * 4 );
	var v = ( ( laser_width / 2 ) * 1 );
	
	var color1 = merge_color( laser_color, c_black, 0.75 );
	var color2 = merge_color( laser_color, c_black, amount );
	
	draw_primitive_begin( pr_trianglestrip );
	
	draw_vertex_color( x + xinc, y + yinc, color1, laser_alpha );
	draw_vertex_color( x + xadd + xinc, y + yadd + yinc, color2, laser_alpha );
	
	draw_vertex_color( x - xinc, y - yinc, color1, laser_alpha );
	draw_vertex_color( x + xadd - xinc, y + yadd - yinc, color2, laser_alpha );
	
	draw_primitive_end();
	
	
	gpu_set_tex_repeat( true );
	draw_primitive_begin_texture( pr_trianglestrip, sprite_get_texture( spr_effect_laser, 0 ) );
	
	draw_vertex_texture_color( x + xinc, y + yinc, u_off, v_off, laser_color, laser_alpha );
	draw_vertex_texture_color( x + xadd + xinc, y + yadd + yinc, u_off + u, v_off, laser_color, laser_alpha );
	
	draw_vertex_texture_color( x - xinc, y - yinc, u_off, v_off + v, laser_color, laser_alpha );
	draw_vertex_texture_color( x + xadd - xinc, y + yadd - yinc, u_off + u, v_off + v, laser_color, laser_alpha );
	
	draw_primitive_end();
	gpu_set_tex_repeat( false );
	
	gpu_set_blendmode( bm_normal );
	
	instance_activate_object( obj_worldobject );
	
	#endregion
};