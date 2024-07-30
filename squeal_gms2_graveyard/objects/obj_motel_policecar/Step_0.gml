//snd_timer = max( 0, snd_timer - 1 );

//var snd_chatter = choose( snd_env_policechatter, snd_env_policechatter2, snd_env_policechatter3, snd_env_policechatter4, snd_env_policechatter5, snd_env_policechatter6 );

audio_emitter_position( emitter, x, y, 1 );
audio_emitter_pitch( emitter, delta );

//if ( snd_timer == 0 && !audio_is_playing( snd_chatter ) )
//{
//	//playsound_on( emitter, snd_chatter, 16 * 8, 16 * 12,,, );
//	playsound_at( snd_chatter, x, y, 16 * 4, 16 * 8,,audio_falloff_exponent_distance_scaled );
//	snd_timer = random( snd_timermax );
//}