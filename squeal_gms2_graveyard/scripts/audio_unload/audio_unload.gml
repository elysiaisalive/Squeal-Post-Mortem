function audio_unload( group ) {
	
	var result = false;
	
	audio_group_unload( group );
	
	if ( !audio_group_is_loaded( group ) )
	{
		result = true;
	}
	
	return[result]

}