event_inherited();

ent_name    = "GenericAmbientScape";
disabled    = false;
ambience    = snd_amb_outdoor;
fadeout     = false;
fadein      = false;
play_sound = false;
in_volume   = false;
audioCurrentVolume  = 0;
audioMaxVolume = 0.50;
audioFadeinTime = 0.02;
audioFadeoutTime = 0.006;
update = false;
nodes = array_create( 0 );
check = noone;

TriggerEvent = function(){};

AddNodes = function() {
     with( obj_ambientnode ) {
         if ( other.ent_name == parent_ambience ) {
             array_push( other.nodes, id );
         };
     };
};

GetParentedNodes = function() {
    var _result = false;
    
    for( var i = 0; i < array_length( nodes ); ++i ) {
        if ( nodes[i].parent_ambience == ent_name ) {
            _result = true;
        }
    };
    
    return _result;
}

ActivateNodes = function() {
    for( var i = 0; i < array_length( nodes ); ++i ) {
        nodes[i].disabled = false;
    };
};

DisableNodes = function() {
    for( var i = 0; i < array_length( nodes ); ++i ) {
        nodes[i].disabled = true;
    };
};

DisableAmbientScape = function() {
    disabled = true;
    DisableNodes();
}

EnableAmbientScape = function() {
    disabled = false;
    ActivateNodes();
}

PlayAmbience = function( amb = ambience ) {
    if ( !audio_is_playing( amb ) ) {
        audio_play_sound( amb, -1, true );
    }
    else {
        audio_resume_sound( amb );
    };
};

PauseAmbience = function( amb = ambience ) {
    if ( audio_is_playing( amb ) ) {
        audio_pause_sound( amb );
    };
};

// Called when exiting room / game / etc.
CleanupAmbience = function() {
    with( obj_ambientscape ) {
        audio_stop_sound( ambience );
        
        // Stop ambience nodes
        for( var i = 0; i < array_length( nodes ); ++i ) {
            audio_stop_sound( nodes[i].ambience );
        };
        
        // Disabled nodes and self
        DisableNodes();
        disabled = true;
    }
    
    global.currentambience = -1;
    global.prevambience = -1;
}