function cGunColt() extends cWeaponGun() class {
	itemName = "colt";
	displayName = LOC_STRING( "#Game.ItemName.38Colt" );
	descString = LOC_STRING( "#Game.ItemDesc.38Colt" );
	worldSprite = spr_weapon_colt;
	displaySprite = spr_ui_inventory_38;
	animIndex = 0;
	
	animSpeed = fpsToDecimal( 25 );
	
	/* 
		Sprites are held as strings as they are all keys to sprites within the global animation map
	*/
	animations = {
		walk : new cSpriteData()
		.SetAnimation( "colt_walk" )
		.SetAnimSpeed( fpsToDecimal( 20 ) ),	
		attack : new cSpriteData()
		.SetAnimation( "colt_shoot" )
		.SetAnimSpeed( fpsToDecimal( 20 ) ),
		
		reloadStart : new cSpriteData()
		.SetAnimation( "colt_open_cylinder" )
		.SetAnimSpeed( fpsToDecimal( 20 ) ),
		reloadRound : new cSpriteData()
		.SetAnimation( "colt_load_cylinder" )
		.SetAnimSpeed( fpsToDecimal( 20 ) ),
		reloadEnd : new cSpriteData()
		.SetAnimation( "colt_close_cylinder" )
		.SetAnimSpeed( fpsToDecimal( 20 ) ),
		
		equipStart : new cSpriteData()
		.SetAnimation( "colt_equip" )
		.SetAnimSpeed( fpsToDecimal( 20 ) ),
		equipEnd : new cSpriteData()
		.SetAnimation( "colt_unequip" )
		.SetAnimSpeed( fpsToDecimal( 20 ) ),
		
		aimStart : new cSpriteData()
		.SetAnimation( "colt_aim" )
		.SetAnimSpeed( fpsToDecimal( 20 ) ),
		aimHold : new cSpriteData()
		.SetAnimation( "colt_holdaim" )
		.SetAnimSpeed( fpsToDecimal( 20 ) ),
		aimEnd : new cSpriteData()
		.SetAnimation( "colt_cancelaim" )
		.SetAnimSpeed( fpsToDecimal( 20 ) ),
	}
	walkSprite = "colt_walk";
	attackSprite = "colt_shoot";
	searchSprite = -1;
	reloadSprites = ["colt_open_cylinder", "colt_close_cylinder", "colt_load_cylinder"];
	aimSprites = ["colt_aim", "colt_holdaim", "colt_cancelaim"];
	equipSprites = ["colt_equip", "colt_unequip"];
	
	/* 
		Firemodes are pretty self explanatory
		
		Attack types are used for determining what kind of gore to use when an enemy is killed
	*/
	fireMode = FIREMODE.SEMI;
	attackType = ATTACKTYPE.GUN;
	
	ammo = 6;
	ammoMax = ammo;
	ammoType = "38";
	
	hpDamage = 0;
	armourDamage = 0;
	
	penetration = 1; // Max 1 enemy to be attacked at anytime by projectile, melee etc.
	spread = 16;
	
	bulletProjectile = obj_proj_bullet_lowcal;
	bulletAmount = 1;
	
	triggerPullTime = fpsToDecimal( 5 );
	aimSpeed = fpsToDecimal( 20 );
	equipSpeed = fpsToDecimal( 25 );
	reloadSpeed = fpsToDecimal( 15 );
	turnSpeedModifier = 0.20;
	
	attackSounds = [snd_gun_ak];
	
	// VFX
	muzzleFlashSprite = sprPistolFlash;
	muzzleFlashAnimSpeed = 0.75;
	
	// How much the camera should shake
	cameraShakeAmount = 6;
	
	// Bools
	isDroppable = false;
	
	// Frame stuff for VFX
	canEjectShells = false;
	canEjectMagazine = false;

	shotsFired = 0;
	
	fireRate = 60 / 550;
	fireRateMax = fireRate;
	fireRateMin = 1;
	fireRateRamp = 1;
	fireRateRampIncrease = 0;
};