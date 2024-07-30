/// @desc Plays a sound in 3D Mono Positioning.
function sfx_play_at( _source = -1, _sound, _looped = false, _x, _y, _rangeStart = 16, _rangeEnd = 16 * 64, _gain = 1, _volumeChannel = global.settings.vol_sfx_volume, _audioBus = global.audioBus.sfx ) {
	var _emitterInstance = instance_create_depth( 0, 0, 0, obj_audio );
	var _emitterID = _emitterInstance.emitterID;
	
	_emitterInstance.emitterPosition.SetNewPos( _x, _y, 0 );
	_emitterInstance.emitterBus = _audioBus; 
	_emitterInstance.emitterVolumeMix = _volumeChannel; 
	
	audio_emitter_falloff( _emitterID, _rangeStart, _rangeEnd, 1 );
	audio_emitter_gain( _emitterID, _gain * _volumeChannel );
	
	var _soundEffect = audio_play_sound_on( 
		_emitterID,
		_sound,
		_looped,
		0
	);
	
	_emitterInstance.soundID = _soundEffect;
	
	return _emitterInstance;
};