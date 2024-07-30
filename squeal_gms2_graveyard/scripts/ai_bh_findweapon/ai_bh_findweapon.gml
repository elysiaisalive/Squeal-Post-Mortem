function ai_bh_findweapon() {
	
	var weapon = instance_nearest( x, y, obj_weapon_generic );
	var dist_to_weapon = point_distance( x, y, weapon.x, weapon.y )
	var weapon_direction = point_direction( x, y, weapon.x, weapon.y );
	//var blocked_by_wall = collision_line( x, y, weapon.x, weapon.y, obj_wall, false, true );
	
	var pickuprange = 16 * 2	
		
	if ( ( CheckMovementLoS( weapon ) || CheckVisionLoS( weapon ) ) && ( weapon.gun_spd <= 4 ) && ( dist_to_weapon <= ai_detect_radius ) )
	{
		currentPathX = x;
		currentPathY = y;
		
		if ( CalculatePathToTarget( weapon.x, weapon.y, 3 ) )
		{
			if ( ( dist_to_weapon <= pickuprange ) && ( weapon.gun_spd <= 0 ) && !( currentWeapon.itemName != "Unarmed" ) )
			{
				char_get_gun();
				charVelocity = 0;
			}	
		}
	}
}