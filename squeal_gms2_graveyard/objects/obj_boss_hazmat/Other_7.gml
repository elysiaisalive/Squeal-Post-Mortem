event_inherited();

if (currentWeapon.itemName == "VKS")
{
	if (sprite_index == sprBossHazmat_ReloadVKS)
	{
		sprite_index = charGetSpriteFromIndex(self,currentWeapon.walk_sprite)
		mask_sprite	= charGetSpriteFromIndex(self,"WalkVKSMask")
		image_speed = 0;
		currentWeapon.ammo = currentWeapon.maxammo
		reloading = false;
	}
	if (sprite_index == sprBossHazmat_AttackVKS)
	{
		image_speed = 0;
		rechambering = false;
	}
}

if (sprite_index == sprBossHazmat_ThrowNade)
{
	sprite_index = charGetSpriteFromIndex(self,currentWeapon.walk_sprite)
	mask_sprite	= charGetSpriteFromIndex(self,"WalkVKSMask")
	image_speed = 0;
	currentWeapon.ammo = currentWeapon.maxammo
	throwing_nade = false;
}