function charAbilitySwap() {
	// temp
    if ( !obj_hud.inventoryMenu.InventoryIsOpen() ) { //<--- THIS IS DEFINITELY TEMPORARY
    	switch( keyboard_lastkey ) {
    		case 1 :
    		case 2 :
    		case 3 :
    		case 4 :
    		    var _slotIndex = real( keyboard_lastchar ) - 1;
            	
            	if ( keyboard_check_pressed( _slotIndex ) ) {
            		if ( currentWeapon.itemName == "unarmed" ) {
		            	var _hotbarItem = user().GetInventory().hotbar.GetSlot( _slotIndex );
		            	
		            	// If there was no hotbar item, dont do anything
		            	if ( is_undefined( _hotbarItem ) ) {
		            		return;
		            	}
		            	
		            	var _inventoryItem = user().GetInventory().GetItem( _hotbarItem );
		            	
					    if ( !isAttacking
					    && !isAimedIn ) {
					    	animIndex = 0;
					    	IsMeleeAttacking = false;
					    	// Arrays are 0 based, so we need to increase the last char by 1
							currentWeapon = _inventoryItem;
					        
					        // Eventually, there needs to be a universal SwapAnimation() function or something so that resetting anim indexes, etc is less painful
					        
					        var _equipStart = modify_animation_from_index( charName, currentWeapon.GetAnimation( "equipStart" ), {
								animType : ANIMATION_TYPE.CHAINED,
								animSpd : currentWeapon.equipSpeed,
								animNext : get_animation_from_index( charName, currentWeapon.walkSprite ),
								animStartIndex : 0,
					    		animRepeats : -1,
					    	} );
					    	
					    	currentAnimation = _equipStart;
					    }
	            	}
	            	else { // Also temp.
				    	animIndex = 0;
				        IsMeleeAttacking = false;
				        
				        var _equipEnd = modify_animation_from_index( charName, currentWeapon.GetAnimation( "equipEnd" ), {
							animType : ANIMATION_TYPE.CHAINED,
							animSpd : currentWeapon.equipSpeed,
							animNext : get_animation_from_index( charName, defaultWeapon.walkSprite ),
							animStartIndex : 0,
				    		animRepeats : -1,
				    	} );
				    	_equipEnd.OnAnimEnd = method( self.id, function() {
				    		lastWeapon = currentWeapon;
				    	    currentWeapon = defaultWeapon;
				    	} );
				    	
				    	currentAnimation = _equipEnd;
	            	}
            	}
                break;
    	}
    }
	
	/* 
		Unequip logic should be separated from swap logic so 
		that a simple Equip/Unequip() method can be called on the player so that cutscenes or other can control these actions
    */
    if ( input_check_pressed( "key_unholster" )
    && !isAttacking
    && !isAimedIn
    && currentWeapon.itemName != "unarmed" ) {
        animIndex = 0;
        IsMeleeAttacking = false;
        
		var _equipEnd = modify_animation_from_index( charName, currentWeapon.GetAnimation( "equipEnd" ), {
			animType : ANIMATION_TYPE.CHAINED,
			animSpd : currentWeapon.equipSpeed,
			animNext : get_animation_from_index( charName, defaultWeapon.walkSprite ),
			animStartIndex : 0,
			animRepeats : -1,
		} );
		_equipEnd.OnAnimEnd = method( self.id, function() {
			lastWeapon = currentWeapon;
			currentWeapon = defaultWeapon;
		} );
    	
    	currentAnimation = _equipEnd;
    }
}