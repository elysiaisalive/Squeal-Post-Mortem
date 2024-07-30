function melee_fists() : cWeaponMelee() constructor
{
	itemName					= "unarmed";
	wep_sprite_index		= -1;
	droppable				= false;
	type					= FIREMODE.AUTO;					
	attackType				= ATTACKTYPE.NONLETHAL;
	walk_sprite				= "walkunarmed";
	attack_sprite			= "attackunarmed";
	mask_sprite				= "Unarmed_Mask";
	range					= 16 * 1.50;
	attack_frame			= 3;
	screen_shake			= 5;
							
	random_attack_sounds	= true;	
	attack_sound			= [snd_swing, snd_swing2];
							
	kill_sprite				= "DeadLegless";
	kill_lean_sprite		= "";
							
	type					= FIREMODE.AUTO;
	firerate			= 60 / 60;
	
	static DoMeleeHitEntity = function( victim )
	{
		victim.charVelocity	= 0;
		victim.charLookDir				= other.charLookDir - 180;
		victim.knocked_index		= 0;
		victim.enemy_state			= ESTATE.IDLE;
		victim.enemy_alert			= EALERT.UNALERT;
		victim.char_state			= CSTATE.DOWN;
		victim.height				= 5;
		
		global.shake				= 10;
								
		playsound_at( snd_hit_item, victim.x, victim.y, 16 * 8, 16 * 8 );	
	};
};