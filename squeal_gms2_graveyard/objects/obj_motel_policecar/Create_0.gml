event_inherited();

setPropHeight( 50 );
Solid_SetFlags( BLOCK_MOVEMENT );
Solid_RemoveFlag( BLOCK_VISION );

image_speed		= 0;

shadow_depth	= 1;

snd_timer		= random_range( 20, 60 );
snd_timermax	= 60;

emitter			= audio_emitter_create();
audio_emitter_falloff( emitter, 16 * 4, 16 * 8, 1 );
audio_falloff_set_model( audio_falloff_exponent_distance_scaled );

snd_chatter = choose( snd_env_policechatter, snd_env_policechatter2, snd_env_policechatter3, snd_env_policechatter4, snd_env_policechatter5, snd_env_policechatter6 );

if ( !audio_is_playing( snd_chatter ) )
{
	audio_play_sound_on( emitter, snd_chatter, true, 1 );
}