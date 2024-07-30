event_inherited();

ent_name = "GenericAmbientNode";
parent_ambience = "GenericAmbientScape";
disabled = true;
audioCurrentVolume = 1;
audioMaxVolume = 0.55;
audioFadeinTime = 0.02;
audioFadeoutTime = 0.03;
ambience = snd_amb_outdoor_plane;
ambient_timer = new cTimer( random_range( 60 * 20, 60 * 120 ) );
play_chance = 1; // ex 1 in 100, 1 in 1 etc.
SoundIsPlayed = false;
IsStaticEmitter = false; // loops
audioFallOffMin = 16;
audioFallOffMax = 16 * 32;

TriggerEvent = function()
{
    // TO DO : Figure out why playsound_at doesn't work for ambient nodes, but regular audio_play_sound does.
    
    audio_play_sound_at( ambience, x, y, 0, audioFallOffMin, audioFallOffMax, 1, false, 4 );
    audio_falloff_set_model( audio_falloff_exponent_distance_scaled );
    //playsound_at( ambience, x, y, , , , , vol_amb_volume * global.settings.vol_amb_volume ); 
};