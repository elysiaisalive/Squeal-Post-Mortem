swing_spd = clamp( swing_spd, -8, 8 );

image_angle += swing_spd * delta;

if ( !locked )
{
	// Clear self from the grid
	if ( instance_exists( obj_navgrid ) )
	{
		var xoffset = sprite_get_xoffset( sprite_index );
		var yoffset = sprite_get_yoffset( sprite_index );
		var org_to_start = point_direction( 0, 0, xoffset, yoffset );
		var start_to_end = point_direction( 0, 0, sprite_width, sprite_height );

		mp_grid_clear_rectangle(
			obj_navgrid.nav_grid,
			x - lengthdir_x( xoffset, image_angle + org_to_start ),
			y - lengthdir_y( yoffset, image_angle + org_to_start ),
			x - lengthdir_x( xoffset, image_angle + org_to_start ) + lengthdir_x( sprite_width, image_angle + start_to_end ),
			y - lengthdir_y( yoffset, image_angle + org_to_start ) + lengthdir_y( sprite_height, image_angle + start_to_end )
		);
	}
}

#region Legacy Hotline Doors
if ( ( swing_spd < 1 ) || ( swing_spd < -1 ) )
{
	CanCollide = true;
}
else
{
	CanCollide = false;
}

if ( abs( swing_spd ) > 0 ) 
{	
	if ( image_angle < -135 ) 
	{
		image_angle = -135;
		swing_spd = abs( swing_spd );
	}

	if ( image_angle > 135 ) 
	{
		image_angle = 135; 
		swing_spd = -abs( swing_spd );
	}
	
	swingdir = sign( swing_spd );

	if ( swing_spd > 0.25 )
	{
		swing_spd -= 0.25;
	}
	else
	{
		if ( swing_spd < 0 )
		{
			swing_spd += 0.25;
		} 
		else 
		{
			swinger = 0;
			swing_spd = 0;
		}
	}
}
#endregion