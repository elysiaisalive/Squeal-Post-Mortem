function melee_shield() : cWeapon() constructor
{
	itemName					= "Shield";
	wep_sprite_index		= 48;
	droppable				= true;
	weight					= 0.50;
	type					= FIREMODE.MELEE;					
	attack_type				= ATTACKTYPE.BLUNTHEAVY;
	walk_sprite				= "WalkShield"
	attack_sprite			= [["AttackShield", 10 / 60]]
	mask_sprite				= "WalkShield_Helmet";
	range				= 32;
	attack_frame			= 4;
	screen_shake			= 5;
							
	random_attack_sounds	= true;	
	attack_sound			= [snd_swing, snd_swing2]
							
	kill_sprite				= "DeadLegless"
	kill_lean_sprite		= ""
							
	firerate			= 0.40;
}