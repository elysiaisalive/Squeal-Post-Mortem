// Global function for cleaning up ambience and audio that is still playing.
function audio_cleanup() {
    print( "Cleaning Up Audio ..." );
    
    global.currentambience = -1;
    global.prevambience = -1;
    
	audio_stop_all();
	
	with( obj_audio ) {
	    event_perform( ev_destroy, 0 );
	}
}