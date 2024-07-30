event_inherited();

char_hazmat_enforcer();

currentWeapon	= gun_deagle();

sprite_index	= charGetSpriteFromIndex( self, currentWeapon.walk_sprite ) ?? FALLBACK_SPRITE;

ai_init( 125, EBEHAVIOUR.PATROL, true, true );