lightOn = true;

flicker = false;
flickerTimer = new cTimer( 20, true, true );
flickerTotalTimer = -1;
flickerSound = audio().GetSound( choose( 
    @"env\flicker01", 
    @"env\flicker02", 
    @"env\flicker03", 
    @"env\flicker04", 
    @"env\flicker05", 
    @"env\flicker06", 
) );

cleanup = false;
scaleWhileFlickering = false;
lightAmbSound = audio().GetSound( @"env\fluorescentbuzz3" );
playAmbSound = true;
burnOutSound = -1;
flickerEndState = false;

flickerTempTime = new cTimer( 30, , true );

flickerTimer.OnTimerEnd = function() {
    lightOn = !lightOn;
    
    if ( flickerSound != -1 ) {
        var flicker_sound = audio().GetSound( choose( 
            @"env\flicker01", 
            @"env\flicker02", 
            @"env\flicker03", 
            @"env\flicker04", 
            @"env\flicker05", 
            @"env\flicker06", 
        ) );
        
        // sfx_play_at( self.id, flicker_sound, false, x, y, 16, 16 * 32 );
    }
    
    flickerTimer.SetNewTime( floor( random_range( 5, 60 ) ) );
    flickerTimer.ResetTimer( true );
}

flickerTempTime.OnTimerEnd = function() {
    flicker = false;
    
    // Cleanup and destroy light if we are going to burn out permanently.
    if ( light
    && !flickerEndState ) {
    	cleanup = true; 
    };
    
    flickerTimer.SetNewTime( floor( random_range( 5, 30 ) ) );
    flickerTimer.ResetTimer( true );
    flickerTimer.Pause();
    
    if ( light ) {
        light.alpha = flicker; // True or false for if the light will result in being turned off from flickering
    }
    
    if ( burnOutSound != -1 ) {
        // sfx_play_at( self.id, burnOutSound, false, x, y );
    }
}

light = -1;
lightSprite = spr_lightmask_test;
lightIndex = 0;
lightAlpha = 1;
lightScale = 0.35;
lightAngle = image_angle;
lightColour = c_white;
lightColor = lightColour;
lightPenumbra = 0.0;
lightPos = new Vector2( x, y );

doFlicker = function( time = 60, endstate = false, sound = -1 ) {
    flicker = true;
    flickerEndState = endstate;
    burnOutSound = sound;
    flickerTempTime.SetNewTime( time );
    
    if ( time > 0 ) {
        flickerTempTime.Unpause();
    }
}