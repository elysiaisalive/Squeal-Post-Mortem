check = collision_rectangle( bbox_left, bbox_top, bbox_right, bbox_bottom, obj_player, false, true );

if ( !disabled ) {
    if ( check
    && GetParentedNodes() ) {
        PlayAmbience();
        
        if ( global.currentambience != ambience ) {
            global.prevambience = global.currentambience;
            global.currentambience = ambience;
        }
    }
}

audio_sound_gain( ambience, audioCurrentVolume * global.settings.vol_amb_volume, 0 );

if ( global.currentambience != ambience ) {
    audioCurrentVolume -= audioFadeoutTime;
    DisableNodes();
} 
else {
    ActivateNodes();
    audioCurrentVolume = max( 0, audioCurrentVolume + audioFadeinTime );
}

audioCurrentVolume = clamp( audioCurrentVolume, 0, 0.25 );