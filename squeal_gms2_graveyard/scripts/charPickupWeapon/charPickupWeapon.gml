function charPickupWeapon( _entity = self.id ) {
	if ( currentWeapon != defaultWeapon ) {
		charThrowWeapon( 10 );
	};
	
	if ( pickup_target != noone 
	&& canPickupWeapons ) {
		currentWeapon = pickup_target.gun;
		currentTriggerReset = 0;
		
		currentAnimation = get_animation_from_index( charName, currentWeapon.walk_sprite );
		animIndex = 0;
		
		if ( IsMeleeAttacking ) {
			IsMeleeAttacking = false;
		}
		
		playsound_at( currentWeapon.pickupSound, _entity.x, _entity.y );
	
		with( pickup_target ) {
			instance_destroy();
		}
		
		return true;
	}
};