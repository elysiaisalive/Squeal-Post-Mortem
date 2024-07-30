function audio_load( group ) 
{
	var result = false;
	var progress = audio_group_load_progress( group );
	
	audio_group_load( group );
	
	if ( audio_group_is_loaded( group ) )
	{
		result = true;
	}
	
	return[result, progress]

}