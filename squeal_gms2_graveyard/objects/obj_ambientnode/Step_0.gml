if ( !IsStaticEmitter ) {
    ambient_timer.Tick();
    ambient_timer.OnTimerEnd = function() {
        if ( !disabled ) {
            if ( irandom( play_chance ) == 1 ) {
                TriggerEvent();
            }
            
            ambient_timer.ResetTimer();
            return true;
        };
    };
}
else if ( IsStaticEmitter
&& !SoundIsPlayed ) {
    audio_play_sound_at( ambience, x, y, 0, audioFallOffMin, audioFallOffMax, 1, true, 4 );
    audio_falloff_set_model( audio_falloff_exponent_distance_scaled );
    SoundIsPlayed = true;
}

if ( disabled ) {
    audioCurrentVolume -= audioFadeoutTime;
} 
else {
    audioCurrentVolume = max( 0, audioCurrentVolume + audioFadeinTime );
}

// Always set gain changes
audio_sound_gain( ambience, audioCurrentVolume * global.settings.vol_amb_volume, 0 );

audioCurrentVolume = clamp( audioCurrentVolume, 0, audioMaxVolume );

if ( disabled )
{
    image_index = 1;
}
else
{
    image_index = 0;
};