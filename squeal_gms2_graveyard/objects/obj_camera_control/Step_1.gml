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

///// DEBUG!!!!!!!!!
if ( keyboard_check( vk_subtract ) ) {
	camera_zoomfactor -= 0.01;
	print( camera_zoomfactor );
}
if ( keyboard_check( vk_add ) ) {
	camera_zoomfactor += 0.01;
	print( camera_zoomfactor );
}