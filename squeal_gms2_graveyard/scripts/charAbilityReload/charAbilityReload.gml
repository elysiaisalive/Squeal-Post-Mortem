function charAbilityReload() {
    switch( currentWeapon.itemName ) {
        case "colt":
        	var _inventory_ammo = inventory.GetItemStack( currentWeapon.ammoType );
    		var _reloadRemainder = ( currentWeapon.ammoMax - currentWeapon.ammo );
    		var _open_cylinder = get_animation_from_index( charName, currentWeapon.reloadSprites[0] );
    		var _close_cylinder = get_animation_from_index( charName, currentWeapon.reloadSprites[1] );
    		var _reload_cylinder = get_animation_from_index( charName, currentWeapon.reloadSprites[2] );
    		
    		_close_cylinder.animType = ANIMATION_TYPE.CHAINED;
    		_close_cylinder.animSpd = 0.25;
    		_close_cylinder.animNext = get_animation_from_index( charName, currentWeapon.walkSprite );
    		_close_cylinder.OnAnimEnd = function() {
    			sfx_play_at( self.id, snd_gun_38_close, false, x, y );
    		}
    		
    		_open_cylinder.animType = ANIMATION_TYPE.CHAINED;
    		_open_cylinder.animSpd = 0.20;
    		_open_cylinder.animNext = _reload_cylinder;
    		_open_cylinder.OnAnimEnd = function() {
    			sfx_play_at( self.id, snd_gun_38_open, false, x, y );
    		}
    		
    		_reload_cylinder.animType = ANIMATION_TYPE.CHAINED;
    		_reload_cylinder.animSpd = currentWeapon.reloadSpeed;
    		_reload_cylinder.animNext = _close_cylinder;
    		_reload_cylinder.OnAnimEnd = function() {
				_reloadRemainder = ( currentWeapon.ammoMax - currentWeapon.ammo );
    			
    			sfx_play_at( self.id, snd_gun_38_load, false, x, y );
				
				if ( _reloadRemainder > 0 ) {
					global.shake = 4;
	    			inventory.RemoveItem( currentWeapon.ammoType, 1 );
	       			currentWeapon.ammo += 1;
				}
    		};
    		
    		if ( input_check_pressed( "key_reload" )
    		&& ( currentWeapon.ammo < currentWeapon.ammoMax )
    		&& _inventory_ammo > 0 ) {
    			lastAnimIndex = animIndex;
    			
    			_reloadRemainder = currentWeapon.ammoMax - currentWeapon.ammo;
    			_reload_cylinder.animRepeats = ( _reloadRemainder - 1 ) % currentWeapon.ammoMax;
    			print( _reloadRemainder );
    			print( _reload_cylinder.animRepeats );
    			currentAnimation = _open_cylinder;
    		}
    		break;
	}
}