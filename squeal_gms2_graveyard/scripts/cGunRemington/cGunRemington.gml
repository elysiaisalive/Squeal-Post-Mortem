function cGunRemington() extends cWeaponGun() class {
	itemName = "12ga";
	displayName = LOC_STRING( "#Game.ItemName.12ga" );
	descString = LOC_STRING( "#Game.ItemDesc.12ga" );
	worldSprite = spr_weapon_12ga;
	displaySprite = spr_ui_inventory_12ga;
	animIndex = 0;
	animSpeed = ( 1 / 60 ) * 10;
	
	/* 
		Sprites are held as strings as they are all keys to sprites within the global animation map
	*/
	walkSprite = "12ga_walk";
	attackSprite = "12ga_shoot";
	searchSprite = -1;
	reloadSprites = -1;
	aimSprites = ["12ga_aim", "12ga_holdaim", "12ga_cancelaim"];
	equipSprites = ["12ga_equip", "12ga_unequip"];
	
	/* 
		Firemodes are pretty self explanatory
		
		Attack types are used for determining what kind of gore to use when an enemy is killed
	*/
	fireMode = FIREMODE.SEMI;
	attackType = ATTACKTYPE.GUN;
	
	ammo = 6;
	ammoMax = ammo;
	ammoType = "12ga";
	
	hpDamage = 0;
	armourDamage = 0;
	
	penetration = 3; // Max 1 enemy to be attacked at anytime by projectile, melee etc.
	spread = 16;
	
	bulletProjectile = obj_proj_bullet_pellet;
	bulletAmount = 8;
	bulletStagger = 2;
	
	aimSpeed = ( 1 / 60 ) * 18;
	equipSpeed = ( 1 / 60 ) * 18;
	turnSpeedModifier = 0.10;
	
	attackSounds = [snd_gun_pistol, snd_gun_pistol_2, snd_gun_pistol_3];
	
	// VFX
	muzzleFlashSprite = spr_effect_shotgunflash;
	muzzleFlashAnimSpeed = 0.75;
	
	// How much the camera should shake
	cameraShakeAmount = 12;
	
	// Bools
	isDroppable = false;
	
	// Frame stuff for VFX
	canEjectShells = true;
	canEjectMagazine = false;

	shotsFired = 0;
	
	fireRate = 60 / 70;
	fireRateMax = fireRate;
	fireRateMin = 1;
	fireRateRamp = 1;
	fireRateRampIncrease = 0;
};