if ( !instance_exists( global.camera_target ) )
{
	global.camera_target = obj_gamemanager;
	// if ( valid_target )
	// {
	// 	valid_target = false;
	// 	show_message( "Camera Target Invalid!" );
	// };
	
	//exit;
};
if ( global.camera_target ) {
	camera_x = global.camera_target.x;
	camera_y = global.camera_target.y;
}
persistent = false;