global.camera_mode = 0;

button = 6;
button_press = false;

thirdperson_distance = 32;
thirdperson_distance_min = 8;
thirdperson_distance_max = 256;

camera_pull = 0.075;
camera_x = room_width / 2;
camera_y = room_height / 2;
camera_width = 480;
camera_height = 270;
camera_width_max = 480;
camera_height_max = 270;
camera_angle = 0;
camera_keep_inside_room = true;
camera_zoomfactor = 0.75;

range_min = 0.1;
range_max = 0.2;
valid_target = false;

LerpZoom = function( newZoomLevel = 1, rate = fpsToDecimal( 1 ) ) {
	camera_zoomfactor = lerp( camera_zoomfactor, newZoomLevel, rate );
}