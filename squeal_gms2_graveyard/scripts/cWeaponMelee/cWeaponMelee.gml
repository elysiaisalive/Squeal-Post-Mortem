function cWeaponMelee() : cWeapon() constructor {
	range					= 40;	// Melee Range
	recoil					= 45;	// Melee Angle
	penetration				= 1;	// How many enemies can be hurt in a single hit
	
	firemode_type			= FIREMODE.AUTO;					
	attack_type				= ATTACKTYPE.NONLETHAL;
	
	// Melee Methods that determine how the weapon will behave AFTER an attack on something
	static DoMeleeHitEntity = function( victim ) {
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
	static DoMeleeHitSolid = function( victim, xx, yy, dir ) {
		return victim.on_melee_hit( xx, yy, dir );
	};
};