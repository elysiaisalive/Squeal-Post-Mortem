function cWeaponGun() extends cWeapon() class {
	fireMode = FIREMODE.SEMI;
	attackType = ATTACKTYPE.GUN;
	
	reloadSprites = [];
	aimSprites = [];
	equipSprites = [];
	
	canAssignToHotkey = true;
	
	#region Bullet data
	/* 
		bulletAmount -> Amount of bullets that will be fired in a single shot.
		bulletVelocity -> Self explanatory
		bulletProjectile -> The projectile object that will be fired.
		bulletStagger -> The speed change that will be applied each time a bullet is created, best used for shotguns.
	*/
	bulletPos = new Vector2( 29, 0 );
	bulletAmount = 1;
	bulletVelocity = 14;
	bulletProjectile = obj_proj_generic;
	bulletStagger = 0;
	
	/*
	    needsRechamber -> If the weapon needs to be chambered. ( i.e cocking a revolver, pumping a shotgun. )
	    isChambered = true; -> If the weapon has a round in the chamber.
	    triggerPullTime -> The amount of time the player will need to hold the shoot key in order to fire the weapon
		aimSpeed -> The time in frames that this weapon takes to aim ( default is 15 frames )
		reloadSpeed -> The time taken for this weapon to reload regardless of animation length.
	*/
	needsRechamber = false;
	isChambered = true;
	triggerPullTime = fpsToDecimal( 1 );
	aimSpeed = ( 1 / 60 ) * 15;
	reloadSpeed = 60 / 10;
	
	/*
		ammoType -> The itemName of the item object that will be used for this weapons ammo resource. 
		ammoPerShot -> The amount of ammo consumed in a single shot.
	*/
	ammoType = "";
	ammoPerShot = 1;
	
	hpDamage = 100;
	armourDamage = 0;
	#endregion

	#region Shell casings
	shellSprite = spr_debris_bullet;
	shellIndex = 0;
	shellObject = obj_shellcasing;
	#endregion
	
	#region Sounds
	/* 
		shellSound -> Sound that plays when the weapons casing hits the ground
		tailSound -> The tail sound that plays depending on the environment ( potentially unused )
	*/
	pickupSound = snd_vest_pickup;
	dryfireSound = snd_dryfire;
	shellSound = snd_shellcasing_small;
	tailSound = -1;
	#endregion
	
	// Unused
	mod_altfire					= false;
};