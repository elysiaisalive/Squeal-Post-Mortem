function charRegisterMeleeHit( attacker = other ) {	
	var	melee_dir		= point_direction( attacker.x, attacker.y, x, y );
	var	melee_cone		= abs( angle_difference( attacker.charLookDir, melee_dir ) ) < attacker.currentWeapon.recoil;
	var range_check 	= rectangle_in_circle( bbox_left, bbox_top, bbox_right, bbox_bottom, attacker.x, attacker.y, attacker.currentWeapon.range );
	
	// If we aren't blocked by a wall and the bounding box of the target is in range
	if ( melee_cone 
	&& range_check )
	{
		/* 
			TODO: 
				Check if the player is in an attack animation
		*/
		//if ( attacker.currentAnimation == get_animation_from_index( attacker.charName, attacker.currentWeapon.attack_sprite ) ) {
		return true;
		//};
		
		//return false;
	};
};