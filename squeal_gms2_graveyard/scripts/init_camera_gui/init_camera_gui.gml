function init_camera_gui( width = 1920.0, height = 1080.0 ) {
	var xx = width / 2.0;
	var yy = height / 2.0;
	var camera = view_get_camera( 0 );
	
	camera_set_view_mat( camera, matrix_build_lookat( xx, yy, 0, xx, yy, 0, 0, 0, 1 ) );
	camera_set_proj_mat( camera, matrix_build_projection_ortho( width, height, -16000, 16000 ) );
	camera_set_view_pos( camera, 0, 0 );
	camera_set_view_size( camera, width, height );
	camera_set_view_angle( camera, 0 );
	camera_apply( camera );
};