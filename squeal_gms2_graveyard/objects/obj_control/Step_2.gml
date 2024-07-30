//np_setpresence_more( "Awesome", "LOOK", false );

if ( globalflags_get( GLOBALFLAGS.USE_OS_CURSOR ) ) {
	window_set_cursor( cr_default );
}

if ( keyboard_check_pressed( vk_0 ) ) {
		global.current_saveslot = 0;
}
if ( keyboard_check_pressed( vk_1 ) ) {
		global.current_saveslot = 1;
}
if ( keyboard_check_pressed( vk_2 ) ) {
		global.current_saveslot = 2;
}

if ( keyboard_check_pressed( vk_lalt ) ) {
	save_progress();
}
if ( keyboard_check_pressed( vk_ralt ) ) {
	load_progress();
}