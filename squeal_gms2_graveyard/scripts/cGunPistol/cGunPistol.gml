function cGunPistol() : cWeaponGun() constructor {
	itemName				= "1911";
	wep_sprite_index	= 3;
	ammo				= 16;
	maxammo				= 16;
	walk_sprite			= "walk1911";
	attack_sprite		= "attack1911";
	bFlipSprite			= false;
	random_sprite		= true;
	recoil				= 14;
	screen_shake		= 3;
	drop_magazine		= true;
	mag_frame			= 2;

	attack_sound		= [snd_gun_pistol, snd_gun_pistol_2, snd_gun_pistol_3];
	dryfire_sound		= snd_gun_pistol_dryfire;

	kill_sprite			= "DeadLegless";
	kill_lean_sprite	= "";

	droppable			= true;
	firemode_type		= FIREMODE.SEMI;
	attack_type			= ATTACKTYPE.GUN;
	firerate			= 60 / 450;
	weight				= 1.20;
	
	bullet_velocity		= 14;
	bullet_pos			= [32, 0];
	muzzleflash_sprite	= sprPistolFlash;
	muzzleflash_animspd	= 0.75;
	projectile			= obj_proj_bullet_lowcal;
	spread				= 10;
	
	amount				= 1;
	shell_index			= 1;
	eject				= true;
	eject_f				= 1;
};