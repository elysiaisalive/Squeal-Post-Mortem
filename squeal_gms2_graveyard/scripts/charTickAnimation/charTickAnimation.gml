// /// @desc Ideally used when swapping to an animation outside of the charTickAnimation() function.
// /// @param {struct} next_anim
// function charSwitchAnimation( next_anim ) {
// 	if ( currentAnimation.isInterruptable ) {
// 		currentAnimation = next_anim;
// 	}
// 	else {
// 		exit;
// 	}
// }

// Based on Animo v0.0.1
function charTickAnimation() {
    // Check if the animation entry exists
    if ( !is_undefined( currentAnimation ) ) {
        // Increment frame index
        animIndex += currentAnimation.animSpd * delta;
        
        if ( floor( animIndex ) >= sprite_get_number( currentAnimation.anim ) ) {
            switch( currentAnimation.animType ) {
                case ANIMATION_TYPE.FINITE :
        			// Switch back to the start index and stop animating
        			currentAnimation.animSpd = 0;
                    break;
                case ANIMATION_TYPE.CHAINED :
        			// If we have reached the amount of set repeats and there is a valid animation to change to, we will switch
                    if ( ( currentAnimation.currentIterations >= currentAnimation.animRepeats )
                    && !is_undefined( currentAnimation.animNext ) ) {
        				/* 
        					TODO:
        						Add code to support randomizing chain animations
        				*/
        				currentAnimation.OnAnimEnd();
        				currentAnimation = currentAnimation.animNext;
        				animIndex = 0;
        				currentAnimation.OnAnimationSwitch();
                    }
                    // If there is no animation to switch to, just start looping, but don't change type because we may want to set this later.
                    else if ( is_undefined( currentAnimation.animNext ) ) {
        				animIndex = 0;
        				currentAnimation.OnAnimationSwitch();
                    }
                    break;
            }
            
	    	// If there is an end index available, we will execute the function on the frame.
	    	currentAnimation.OnAnimEnd();
	    	
	    	if ( isAttacking ) {
	    		isAttacking = false;
	    		// janky fix
				currentAnimation = lastAnimation;
				animIndex = lastAnimIndex;
	    	}
	    	
			// If is melee attacking
        	if ( IsMeleeAttacking ) {
        	    if ( currentWeapon.bFlipSprite ) {
            	    flipped = !flipped;
            	    IsMeleeAttacking = false;
            	    meleePenetration = 0;
        	    }
        	}
            
        	animIndex = 0;
        	
			// Ejecting Shellcasings if the current weapon is a GUN class
			if ( currentWeapon.canEjectShells 
			&& is_instanceof( currentWeapon, cWeaponGun ) )
			&& ( currentAnimation == get_animation_from_index( charName, currentWeapon.attackSprite ) ) {
				if ( floor( animIndex ) <= currentWeapon.shellEjectFrame ) {
					spawn_shell( currentWeapon.shellObject, currentWeapon.shellSprite, currentWeapon.shellIndex, transform.angle, currentWeapon.shellSound );
				}
			}
        	
            if ( currentAnimation.currentIterations < currentAnimation.animRepeats ) {
        		++currentAnimation.currentIterations;
            }
        }
        
        animIndex = clamp( animIndex, 0, sprite_get_number( currentAnimation.anim ) );
    }
    else {
        currentAnimation = defaultAnim;
    }
}