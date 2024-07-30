function melee_bat() : cWeaponMelee() constructor
{
	itemName					= "NailBat";
	wep_sprite_index		= 9;
	type					= FIREMODE.SEMI;					
	attack_type				= ATTACKTYPE.BLUNT;
	walk_sprite				= "WalkNailBat";
	attack_sprite			= [["AttackNailBat", 24 / 60]];
	bFlipSprite				= true;
	range				= 16 * 2;
	attack_frame			= 4;
	screen_shake			= 5;
	droppable				= true;
					
	random_attack_sounds	= true;	
	attack_sound			= [snd_swing, snd_swing2];
	firerate			= 0.45;
	
	penetration				= 3;
	
	static DoMeleeHitEntity = function( victim )
	{
		gore_melee( victim );
		playsound_at( snd_gore_hit, victim.x, victim.y, 16 * 8, 16 * 8 );	
		
		victim.charVelocity = 0;
		victim.stats.hp = 0;
		victim.stats.armour = 0;
	};
};