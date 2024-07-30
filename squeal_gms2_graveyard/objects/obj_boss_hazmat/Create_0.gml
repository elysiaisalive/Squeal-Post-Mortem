event_inherited();

laser_color			= c_lime;

char_boss_vks();

//currentWeapon		= scr_gun_vks();

nade_he				= 3;		// Amount Of Nades
nade_stun			= 1;		// Amount Of Stuns
throwing_nade		= false;	// Is Throwing Nade?
rechambering		= false;	// Is Rechambering?
reloading			= false;	// Is Reloading?
weapon_swapped		= false;

//sprite_index		= charGetSpriteFromIndex(self, currentWeapon.walk_sprite)
nade_sprite			= charGetSpriteFromIndex(self, "ThrowNade")
nademask_sprite		= charGetSpriteFromIndex(self, "ThrowNadeMask")
mask_sprite			= charGetSpriteFromIndex(self, "WalkVKSMask")
reload_sprite		= charGetSpriteFromIndex(self, "ReloadVKS")
maskreload_sprite	= charGetSpriteFromIndex(self, "ReloadVKSMask")

unholster_sprite	= charGetSpriteFromIndex(self, "UnholsterSOCOM")

hp_max				= 300;
hp					= 500;

armour_max		= 350;
armour			= 350;

target_x			= 0;
target_y			= 0;
target_priority		= 0;

currentTarget		= noone;
ai_detect_radius	= 32 * 18;
ai_danger_close		= 32 * 8;
ai_fasterreload		= 32 * 2;

voice				= false;
VO_is_playing		= false;