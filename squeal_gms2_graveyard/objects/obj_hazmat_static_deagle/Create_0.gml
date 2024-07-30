event_inherited();

char_hazmat();

currentWeapon = new gun_deagle();

sprite_index = charGetSpriteFromIndex( self, currentWeapon.walk_sprite ) ?? FALLBACK_SPRITE

ai_init( 75, EBEHAVIOUR.IDLE, true, true );
