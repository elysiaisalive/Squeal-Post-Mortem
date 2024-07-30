audio_destroy_stream( global.current_song );
global.music_playing = false;

println( "Destroying Audio Stream" );

/* no longer needed. store this data in buffers.

// If temp files exist, clean them up
if ( file_exists( "pause_temp.png" ) )
{
	file_delete( "pause_temp.png" );
}

if ( file_exists( "tempsave.save" ) )
{
	file_delete( "tempsave.save" );
}