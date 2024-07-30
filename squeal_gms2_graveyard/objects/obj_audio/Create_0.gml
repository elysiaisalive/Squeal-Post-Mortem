soundID = -1;	// Index
emitterBus = global.audioBus.sfx;
emitterID = audio_emitter_create();
emitterVolume = 1;
emitterVolumeMix = global.settings.vol_sfx_volume;
emitterPosition = new cTransform2D();
playbackSource = -1; // Audio source

audio_emitter_bus( emitterID, emitterBus );
audio_emitter_gain( emitterID, emitterVolume * emitterVolumeMix );
/* 
TODO; CHange this to be emitters...

Also move this to a diff audio class.
*/


//audio_sound_get_track_position
//audio_sound_length

//use the above perhaps for emitter loops/loop iterations.

Tick = function() {
	if ( audio_emitter_exists( emitterID ) ) {
		audio_emitter_position( emitterID, emitterPosition.position.x, emitterPosition.position.y, emitterPosition.position.z );
		audio_emitter_pitch( emitterID, lerp( timescale, 1, 0.5 ) );
	}
	
	var _audioTrackPosition = audio_sound_get_track_position( soundID );
	var _audioLength = audio_sound_length( soundID );
	
	if ( _audioTrackPosition >= _audioLength ) {
		emitterVolume = lerp( emitterVolume, 0, 0.1 );
		audio_emitter_gain( emitterID, emitterVolume * emitterVolumeMix );
		
		if ( emitterVolume <= 0 ) {
			instance_destroy();
		}
	}
}

CullSound = function( range ) {
	with ( obj_audio ) {
		if ( ( id != other.id ) 
		&& ( sound == other.sound ) ) {
			audio_stop_sound( sound );
			instance_destroy();
		};
	}
};