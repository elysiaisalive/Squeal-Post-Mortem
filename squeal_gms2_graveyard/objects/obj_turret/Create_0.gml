event_inherited();

charInit( "Turret", FACTION.SOLO );
SetSpriteFromIndex( "Idle" );

height = 35;

lastRotation = charLookDir;

aggroBeeps = 4;
aggroMaxBeeps = 4;

shootBeeps = 2;
shootMaxBeeps = 2;

rotationSpd = 2.45;

aggroBeepTimer = new cTimer( 12, ,true );
aggroTimer = new cTimer( 60 * 2, ,true );
inSightTimer = new cTimer( 60, ,true );
inSightBeepTimer = new cTimer( 10, ,true );
shotDelayTimer = new cTimer( 1, ,true );
rotationDelayTimer = new cTimer( 120, , true );
rotationSoundDelayTimer = new cTimer( 1, , true );

// Behaviour when awake
deployedBehaviour = new cAIBehaviour();
deployedBehaviour.Tick = function(){};

// When asleep and not deployed
sleepState = new cState();
sleepState.Run = function() {
    if ( CheckVisionLoS( obj_player ) ) {
        aggroBeepTimer.Unpause();
        
        if ( aggroBeepTimer.GetTime() <= 0 ) {
            playsound_at( snd_landmine_step );
            --aggroBeeps;
            aggroBeepTimer.ResetTimer();
        }
    }
    else {
        aggroBeeps = aggroMaxBeeps;
        aggroBeepTimer.ResetTimer( ,true );
    }
    
    if ( aggroBeeps <= 0 ) {
        playsound_at( snd_keypad_accepted );
        
		ResetAnimation = function() {
			DoAnimation( SetSpriteFromIndex( "IdleHostile" ) );
		}
        
        ChangeState( deployedState, function() {
    		DoAnimation( SetSpriteFromIndex( "Activate" ), 0, 0.075 );
        } );
    }
};

// Deployed
deployedState = new cState();
deployedState.Start = function() {
	rotationDelayTimer.Unpause();
}
deployedState.Run = function() {
	if ( CheckVisionLoS( obj_player ) ) {
		aggroTimer.Unpause();
		
		if ( aggroTimer.GetTime() <= 0 ) {
			ChangeState( attackState );
		}
	} 
	else {
		aggroTimer.ResetTimer( ,true );
	}
};

attackState = new cState();
attackState.Run = function() {
	if ( CheckVisionLoS( obj_player ) 
	|| CheckMovementLoS( obj_player ) ) {
		inSightTimer.Unpause();
		charLookDir = rotate( charLookDir, point_direction( x, y, obj_player.x, obj_player.y ), rotationSpd * delta );
		
		if ( inSightTimer.GetTime() <= 0 ) {
			inSightBeepTimer.Unpause();
			
			if ( inSightBeepTimer.GetTime() <= 0 
			&& shootBeeps > 0 ) {
	            playsound_at( snd_landmine_beep );
	            --shootBeeps;
	            inSightBeepTimer.ResetTimer();
			}
		}
		
		if ( shootBeeps <= 0 ) {
			shotDelayTimer.Unpause();
			
			if ( shotDelayTimer.GetTime() <= 0 
			&& animIndex <= 1 ) {
				playsound_at( snd_gun_uzi );
				spawnProjectile( x + lengthdir_x( 16, charLookDir ), y + lengthdir_y( 16, charLookDir ), obj_proj_bullet_lowcal, self.id, 1, charLookDir, 4, 2 );
				shotDelayTimer.ResetTimer();
			}
		}
	}
	else {
		shootBeeps = shootMaxBeeps;
		shotDelayTimer.ResetTimer( ,true );
		inSightBeepTimer.ResetTimer( ,true );
		inSightTimer.ResetTimer( ,true );
	}
}

ChangeState( sleepState );

on_proj_hit = function()
{
	effects_impact_metalspark( proj_hit_id );
	playsound_at( snd_armor_hit );
	return true;
};
on_proj_overload = function(){};