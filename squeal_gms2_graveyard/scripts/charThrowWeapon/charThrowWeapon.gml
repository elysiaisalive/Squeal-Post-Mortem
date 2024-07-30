function charThrowWeapon( throwspd = 10, throw_dir = charLookDir - 5 + random( 12 ) ) {
	if ( currentWeapon.droppable 
	&& canThrowWeapons ) {
		if ( currentWeapon.itemName != "Unarmed" ) {
			currentWeapon.bTriggerPressed = false;
			
			animIndex = 0;
			
			var inst = instance_create_depth( x, y, -4, obj_weapon_generic );
			
			inst.gun = currentWeapon;
			inst.sprite_index = spr_item_weapons;
			inst.direction = throw_dir;
			inst.gun_angle = random_range( -360, 360 );
			inst.gun_spd = throwspd;
			inst.gun_fric = 0.20;

			currentWeapon = defaultWeapon;
			
			currentAnimation = get_animation_from_index( charName, defaultWeapon.walk_sprite );
		}
	}
};