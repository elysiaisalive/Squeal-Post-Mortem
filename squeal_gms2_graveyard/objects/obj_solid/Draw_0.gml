if ( ( global.camera_mode == e_cameraMode.perspective_thirdperson )
|| ( global.camera_mode = e_cameraMode.perspective_firstperson ) )
{
	Draw3D();
	return;
}

if ( draw_under && spr_under != noone )
{
	draw_sprite_ext(
	spr_under, 
	frame_under,
	transform.position.x,
	transform.position.y,
	image_xscale,
	image_yscale,
	image_angle,
	image_blend,
	1
	);
}


if ( sprite_index != -1 ) {
	if ( draw_simpleshadow )// && !( do_3d )
	{
		//matrix_set( matrix_world, matrix_build( 0, 0, 0.5, 0, 0, 0, 1, 1, 1 ) );
		draw_sprite_ext
		(
			sprite_index, 
			animIndex,
			transform.position.x + offset_x + shadow_depth,
			transform.position.y + offset_y + shadow_depth,
			image_xscale,
			image_yscale,
			image_angle,
			c_black,
			0.50
		);
		//matrix_set( matrix_world, matrix_build_identity() );
	}
	
	//if ( true )
	//	draw_self()
	//else
		draw_sprite_ext
		(
			sprite_index, 
			animIndex,
			transform.position.x + offset_x,
			transform.position.y + offset_y,
			image_xscale,
			image_yscale,
			image_angle,
			image_blend,
			image_alpha
		);
	
	if ( draw_over && spr_over != noone )
	{
		draw_sprite_ext(
		spr_over, 
		frame_over,
		transform.position.x,
		transform.position.y,
		image_xscale,
		image_yscale,
		image_angle,
		image_blend,
		image_alpha
		);
	}
}


