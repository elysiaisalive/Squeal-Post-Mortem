event_inherited();

initAIDummy();

currentWeapon = new gun_deagle();

sprite_index = charGetSpriteFromIndex( self, currentWeapon.walk_sprite ) ?? FALLBACK_SPRITE;