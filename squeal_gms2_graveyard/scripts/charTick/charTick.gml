function charTick() {
	charTickAnimation();
	charDoBleedout();
	charTickMovement( canMove );
	charDoFootStep( footStepsEnabled );
	// TODO:
	/* 
		Refactor weapon pickup to be item pickup and instead prioritize based on type
		this should be moved to the user instance...
	*/
	#region Pickup Logic
	var _nearestPickup = instance_nearest( self.x, self.y, obj_pickup );
	var _pickupRadius = 16;
	var _pickupObject = collision_circle( self.x, self.y, _pickupRadius, _nearestPickup, false, true );
	
	if ( _pickupObject
	&& input_check_pressed( "key_interact" ) ) {
		var _self = self.id;
		var _userInventory = user().GetInventory();
		var _controllerPos = user().GetControllerPosition();
		var _pickupItem = _pickupObject.GetItem();
		/* 
			If the target Item can be added successfully, destroy the pickup object
		    At some point this will also display the pickup prompt and then only execute once 'yes' is selected.
		*/
		if ( _userInventory.CanAddItem() ) {
			_userInventory.AddItem( _pickupObject.GetItem() );
			
			sfx_play_at( user().GetController(), _pickupItem.pickupSound, false, _controllerPos.x, _controllerPos.y );
			instance_destroy( _pickupObject );
		}
	}
	#endregion
	#region Melee Logic
	if ( IsMeleeAttacking 
	&& ( floor( animIndex ) >= currentWeapon.attack_frame ) ) {
		if ( meleePenetration > 0 ) {
			with( obj_character ) if ( id != other.id ) {
				other.meleePenetration--;
				
				var	blocked_wall = collision_line( other.x, other.y, x, y, obj_wall, true, false );
				
				if ( !blocked_wall 
				&& charCheckFactionIsAllied( self.id, other.id ) 
				&& ( char_state == CSTATE.ALIVE ) ) {
					if ( charRegisterMeleeHit( other ) ) {
						other.IsMeleeAttacking = false;
						
						if ( !is_undefined( other.currentWeapon.DoMeleeHitEntity ) ) {
							other.currentWeapon.DoMeleeHitEntity( self, other );
						}
					}
				}
			}
		}
		
		instance_deactivate_object( obj_solid );
		instance_activate_region( x - currentWeapon.range, y - currentWeapon.range, currentWeapon.range * 2, currentWeapon.range * 2, true );
		
		var punch_z = z - ( height - 5 );
		
		with( obj_solid ) {
			if ( !collision_flags & BLOCK_MOVEMENT ) {
				instance_deactivate_object( self.id );
			}
			else
			if ( punch_z < ( z - height ) )
			|| ( ( punch_z ) > z ) {
				instance_deactivate_object( self.id );
			}
		};
		
		var melee_x		= x + lengthdir_x( currentWeapon.range, charLookDir );
		var melee_y		= y + lengthdir_y( currentWeapon.range, charLookDir );
		var melee_point = collision_line_point( x, y, melee_x, melee_y, obj_solid, false, true );
		
		// crashes sometimes
		if ( melee_point.id 
		&& ( melee_point.id.collision_flags & BLOCK_MOVEMENT ) ) {
			if ( !is_undefined( currentWeapon.DoMeleeHitSolid ) ) {
				if ( !currentWeapon.DoMeleeHitSolid( melee_point.id, melee_point.x, melee_point.y, charLookDir ) ) {
					IsMeleeAttacking = false;
					meleePenetration = 0;
				}
			}
		};
		
		instance_activate_object( obj_solid );
	};
	#endregion
}