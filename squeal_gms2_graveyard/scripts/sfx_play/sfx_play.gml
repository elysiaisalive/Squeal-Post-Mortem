/// @desc Plays a sound in 2D Stereo Positioning.
/// @param sound {asset:sound}
/// @param config {struct}
function sfx_play( _soundAsset, _config = {} ) {
	var _emitterInstance = instance_create_depth( 0, 0, 0, obj_audio );
	var _emitterID = _emitterInstance.emitterID;
	var _listenerPosition = new Vector2( LISTENER_DATA[? "x"], LISTENER_DATA[? "y"] );
	var _audioBus = _config[$ "audioBus"] ?? global.audioBus.sfx;
	var _audioMix = _config[$ "audioMix"] ?? global.settings.vol_sfx_volume;
	var _looped = _config[$ "isLooped"] ?? false;
	var _gain = _config[$ "gain"] ?? 1;
	
	_emitterInstance.emitterPosition.SetNewPos( _listenerPosition.x, _listenerPosition.y, 0 );
	_emitterInstance.emitterBus = _audioBus; 
	_emitterInstance.emitterVolumeMix = _audioMix; 
	
	audio_emitter_falloff( _emitterID, 0, room_width + room_height, 1 );
	audio_emitter_gain( _emitterID, _gain * _audioMix );
	
	var _soundEffect = audio_play_sound_on( 
		_emitterID,
		_soundAsset,
		_looped,
		0
	);
	
	_emitterInstance.soundID = _soundEffect;
	
	return _emitterInstance;
};