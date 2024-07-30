event_inherited();

char_hazmat();

currentWeapon = gun_aug();

sprite_index = charGetSpriteFromIndex( self, currentWeapon.walk_sprite ) ?? FALLBACK_SPRITE

ai_init( 75, EBEHAVIOUR.WANDER, true, true );
