function score_save()
{
	delete_file( APPDATA_PATH + "levelscores.json" );

	file_text_open_write( APPDATA_PATH + "levelscores.json" );
	
	
	
	
	file_text_close( APPDATA_PATH + "levelscores.json"  );
}