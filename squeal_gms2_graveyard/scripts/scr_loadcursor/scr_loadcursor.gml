function scr_loadcursor() {	
if ( directory_exists( APPDATA_PATH + "\\Config\\Cursors" ) ) 
{	
	var cursor = (APPDATA_PATH + "\\Config\\Cursors\\") + file_find_first(APPDATA_PATH + "\\Config\\Cursors\\*.png", 0);

	global.cursor_custom = sprite_add(
		cursor,
		obj_control.cursor_index,
		true,
		false,
		16 / 2,
		16 / 2
	);
}
	file_find_close();
}