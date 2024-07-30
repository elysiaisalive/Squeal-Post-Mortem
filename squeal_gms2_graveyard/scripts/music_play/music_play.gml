function music_play( song, looping = true ) 
{
	global.current_song = audio_create_stream( MUSIC_PATH + song );
	
	var volume = global.settings.music_volume * global.settings.vol_master_volume;
	
	audio_play_sound( global.current_song, 0, looping, volume );
	
	if ( audio_is_playing( global.current_song ) )
	{
		println( "Starting Audio Stream ..." + " " + string( song ) );
	};
}
function music_stop() 
{
	audio_destroy_stream( global.current_song );
}
function music_pause()
{
	audio_pause_sound( global.current_song );
}
function music_unpause()
{
	audio_resume_sound( global.current_song );
}