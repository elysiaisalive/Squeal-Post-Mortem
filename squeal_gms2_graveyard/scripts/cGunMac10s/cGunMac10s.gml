function cGunMac10s() : cGunPistol() constructor {
	itemName				= "Mac10s";
	wep_sprite_index	= 0;
	ammo				= 30;
	maxammo				= 30;
	random_sprite		= true;
	walk_sprite			= "walkmac10s";
	attack_sprite		= "attackmac10s1";
	bFlipSprite			= false;
	recoil				= 18;
	screen_shake		= 3.50;
	drop_magazine		= true;
	mag_frame			= 0;
	bEjectCartridge		= true;

	attack_sound		= [snd_mac10s, snd_mac10s_2, snd_mac10s_3];

	droppable			= true;
	firemode_type		= FIREMODE.AUTO;
	attack_type			= ATTACKTYPE.GUN;
	firerate			= 60 / 950;
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
}