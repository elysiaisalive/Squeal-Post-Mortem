function charAbilityAim() {
    if ( currentWeapon.attackType == ATTACKTYPE.GUN
    && !isAttacking ) {
        var _equipStart = get_animation_from_index( charName, currentWeapon.GetAnimation( "equipStart" ) );
    	var _aimEnd = modify_animation_from_index( charName, currentWeapon.GetAnimation( "aimEnd" ), {
    			animType : ANIMATION_TYPE.CHAINED,
    			animSpd : currentWeapon.aimSpeed,
    			animNext : get_animation_from_index( charName, currentWeapon.walkSprite ),
    			animStartIndex : 0,
    			animRepeats : -1,
    	} );         	
    	
    	var _aimHold = get_animation_from_index( charName, currentWeapon.GetAnimation( "aimHold" ) );
    	_aimHold.animType = ANIMATION_TYPE.LOOPED;
    	_aimHold.animSpd = 0;
    	_aimHold.animRepeats = -1;
    		
    	var _aimStart = modify_animation_from_index( charName, currentWeapon.GetAnimation( "aimStart" ), {
    		animType : ANIMATION_TYPE.CHAINED,
    		animSpd : currentWeapon.aimSpeed,
    		animNext : _aimHold,
    		animStartIndex : 0,
    		animRepeats : -1,
    	} );
    	
        var _attack_anim = modify_animation_from_index( charName, currentWeapon.attackSprite, {
    		animType : ANIMATION_TYPE.CHAINED,
    		animSpd : ( 1 / 60 ) * 15,
    		animNext : _aimHold,
    		animStartIndex : 0,
    		animRepeats : -1,
    	} );
    	
    	if ( !global.settings.ctrl_toggleaim ) {
        	if ( input_check( "key_secondary" )
        	&& currentAnimation != _equipStart ) {
        	    IsMeleeAttacking = false;
        		isAimedIn = true;
        		
        		accuracy = min( maxAccuracy, accuracy + accuracyAimRamp );
        		
        // 		if ( isMoving ) {
        // 		    accuracy *= accuracyMoveDecay;
        // 		}
        	}
        	else {
        		isAimedIn = false;
        		
        		// Decrease accuracy
        		accuracy = max( minAccuracy, accuracy - accuracyAimDecay );
        	}
    	}
    	else {
    	    if ( input_check_pressed( "key_secondary" )
        	&& currentAnimation != _equipStart ) {
        	    IsMeleeAttacking = false;
    	        isAimedIn = !isAimedIn;
    	    }
    	}
    	
    	// Aim Logic
    	if ( isAimedIn ) {
    	    canAttack = true;
    	    
    		if ( currentAnimation != _aimHold 
    		&& currentAnimation != _aimEnd ) {
    			currentAnimation = _aimStart;
    		}
    		
    		currentMoveSpeedModifier = lerp( currentMoveSpeedModifier, 0.50, 0.10 * delta );
    	}
    	else {
    	    canAttack = false;
    	    
    		if ( currentAnimation != _attack_anim ) {
    			if ( currentAnimation == _aimHold ) {
    				currentAnimation = _aimEnd;
    			}	
    			
    			if ( currentAnimation == _aimStart ) {
    				currentAnimation = _aimEnd;
    			}
    		}
    		
    		currentMoveSpeedModifier = lerp( currentMoveSpeedModifier, 1, 0.10 * delta );
    	}
    }
}