event_inherited();

// rotation soundfx
if ( lastRotation != charLookDir ) {
	playsound_at( audio().GetSound( @"environment\env_camera_turn2" ) );
} 
else {
	rotationSoundDelayTimer.ResetTimer( ,true );
}

lastRotation = lerp( lastRotation, charLookDir, ( rotationSpd - 1 ) * delta );

if ( currentBehaviour != -1 ) {
    currentBehaviour();
}

currentState.Run();
aggroTimer.Tick();
aggroBeepTimer.Tick();
rotationSoundDelayTimer.Tick();
rotationDelayTimer.Tick();
inSightBeepTimer.Tick();
inSightTimer.Tick();
shotDelayTimer.Tick();