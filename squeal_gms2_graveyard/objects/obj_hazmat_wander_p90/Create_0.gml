event_inherited();

currentWeapon	= new gun_p90();

sprite_index	= charGetSpriteFromIndex(self, currentWeapon.walk_sprite)

ai_init(50, EBEHAVIOUR.WANDER, true, true);