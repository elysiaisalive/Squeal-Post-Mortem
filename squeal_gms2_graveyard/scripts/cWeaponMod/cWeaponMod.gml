/// @desc Weapon mod class.
function cWeaponMod() class {
    active = false;
    /* 
    	accuracyMod -> Buff the mod will give to the weapons aimed accuracy
    	damageMod -> Percentage damage increase
    	reloadSpeedMod -> Reload speed percentage increase
    	ammoCapacityMod -> Max ammo count increase
    */
    accuracyMod = 0.0;
    damageMod = 0;
	reloadSpeedMod = 0;
	ammoCapacityMod = 0;
	rangeMod = 0;
	
	transform = new cTransform2D();
	offset = new Vector2( 0, 0 );
	angle = 0;
}

function cWeaponModExtendedMag() extends cWeaponMod() class {
	ammoCapacityMod = 8;
}

function cWeaponModLaser() extends cWeaponMod() class {
    color						= merge_color( c_black, c_red, 0.060 );
    offset.x					= 21;
	offset.y					= 1;
	angle						= 0;
	transform.position.x = lengthdir_x( offset.x, angle );
	transform.position.y = lengthdir_y( offset.y, angle );
	alpha						= 0.80;
	width						= 1.50;
	length						= 16 * 6;
	accuracyMod			        = 0.20;
}

function cWeaponModLight() extends cWeaponMod() class {
	sprite = spr_lightmask_cone_medium;
	animIndex = 0;
	
    blend = c_white;
    alpha = 1;
}