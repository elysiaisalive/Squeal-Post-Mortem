flickerTimer.Tick();
flickerTempTime.Tick();

if ( light ) {
	if ( cleanup ) {
		print( "Cleaning up light ..." );
		light.Destroy();
		cleanup = false;
	}

	if ( flicker ) {
	    flickerTimer.Unpause();

		// TODO: potentially just add different flicker types.
		
		if ( scaleWhileFlickering ) {
			var scale_ratio = lightScale / flickerTimer.GetTime();
			
			light.xscale = lerp( light.xscale, min( lightScale / scale_ratio, 0.75 ), 0.25 );
			light.yscale = lerp( light.yscale, min( lightScale / scale_ratio, 0.75 ), 0.25 );
			light.alpha = lerp( light.alpha, min( lightOn, lightScale / scale_ratio ), 0.045 );
			
			//KEEP THIS -- > light.alpha = lerp( light.alpha, min( 1, lightScale / scale_ratio ), 0.45 );
		}
		else {
			if ( lightOn ) {
			    // audio_resume_sound( lightAmbSound );
			    light.alpha = 1;
			}
			else {
			    // audio_pause_sound( lightAmbSound );
			    light.alpha = 0;
			}
		}
	}
	else {
	    flickerTimer.Pause();
	}
}

// if ( lightAmbSound != -1 
// && !audio_is_playing( lightAmbSound ) ) {
// 	sfx_play_at( self.id, lightAmbSound, false, x, y, 16, 16 * 32 );
// }