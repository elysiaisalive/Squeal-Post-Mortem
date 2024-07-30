function cAudioPlayer() class {
    playbackTarget = noone;
    soundID = undefined;
    source = noone;
    
    static Play = function( soundEffect, _volume = 1, _loops = false, _priority = 0 ) {
        playbackTarget = audio_emitter_create();
        audio_emitter_gain( playbackTarget, _volume );
        audio_play_sound_on( playbackTarget, soundEffect, _loops, _priority );
    }
    
    static Cleanup = function() {
        audio_emitter_free( playbackTarget );
    }
}