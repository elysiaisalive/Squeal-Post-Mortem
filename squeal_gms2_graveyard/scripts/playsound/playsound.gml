function playsound( sound, loops = false, pitch = 1, audio_channel = global.settings.vol_sfx_volume ) 
{	
	var audio = audio_play_sound( 
		sound, 
		0, 
		loops, 
		audio_channel * global.settings.vol_master_volume,
		0, 
		pitch * timescale 
	);
	
	var inst = instance_create_depth( 0, 0, 0, obj_audio );
	inst.sound = sound;
	inst.audio = audio;
	
	return inst;
}

function playsound_at( sound, listen_posx = 0, listen_posy = 0, range_start = 16, range_end = 16 * 64, pitch = 1, falloff_model = audio_falloff_none, audio_channel = global.settings.vol_sfx_volume, loops = false ) 
{
	if ( !global.settings.vol_stereo )
	{
		var audio = audio_play_sound_at( 
			sound,
			listen_posx,
			listen_posy,
			1,
			range_start,
			range_end,
			1, 
			loops,
			4,
			audio_channel * global.settings.vol_master_volume,
			0, 
			lerp( ( pitch * timescale ), 1, 0.5 ) 
		);
	}
	else
	{
		var audio = audio_play_sound( 
			sound, 
			0, 
			loops, 
			audio_channel * global.settings.vol_master_volume,
			0, 
			lerp( ( pitch * timescale ), 1, 0.5 ) 
			);
	}

	var inst = instance_create_depth( listen_posx, listen_posy, 0, obj_audio );
	inst.sound = sound;
	inst.audio = audio;
	
	return inst;
}

function playsound_on( emitter, sound, range_start = 16, range_end = 16 * 2, pitch = 1, loop = false, falloff_model = audio_falloff_exponent_distance_scaled, audio_channel = global.settings.vol_amb_volume ) 
{
	audio_emitter_falloff( emitter, range_start, range_end, 1 );
	
	var audio = audio_play_sound_on(
		emitter, 
		sound,
		loop,
		4
	);
		
	audio_sound_pitch( audio, lerp( ( pitch * timescale ), 1, 0.5 ) );
	audio_sound_gain( audio, audio_channel * global.settings.vol_master_volume, 0 );

	var inst = instance_create_depth( 0, 0, 0, obj_audio );
	inst.sound = sound;
	inst.audio = audio;
}