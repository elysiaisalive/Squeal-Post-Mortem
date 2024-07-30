function melee_claws() : cWeaponMelee() constructor
{
	itemName					= "Claws";
	wep_sprite_index		= -1;
	droppable				= false;
	type					= FIREMODE.MELEE;					
	attack_type				= ATTACKTYPE.BLUNT;
	walk_sprite				= "WalkClaws";
	attack_sprite			= [["AttackClaws", 10 / 60]];
	range				= 48;
	attack_frame			= 3;
	screen_shake			= 5;
							
	random_attack_sounds	= true;	
	attack_sound			= [snd_swing, snd_swing2];
							
	kill_sprite				= "DeadLegless";
	kill_lean_sprite		= "";
							
	type					= FIREMODE.SEMI;
	firerate			= 0.8;
	
	static DoMeleeHitEntity = function( victim )
	{
		gore_melee( victim );
		playsound_at( snd_gore_hit, victim.x, victim.y, 16 * 8, 16 * 8 );	
		
		victim.charVelocity = 0;
		victim.stats.hp = 0;
		victim.stats.armour = 0;
	};
}