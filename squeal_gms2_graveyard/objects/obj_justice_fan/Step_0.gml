if ( fanOn ) {
	fan_dir -= 0.01;
	fan_move = image_angle + sin( fan_dir ) * 16;
}