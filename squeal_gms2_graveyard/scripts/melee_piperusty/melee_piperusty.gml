function melee_piperusty() : cWeaponMelee() constructor
{
	itemName					= "PipeRusty";
	pickupSound				= audio().GetSound( @"item\pickup\pickup_metal" );
	wep_sprite_index		= 50;
	firemode_type			= FIREMODE.SEMI;					
	attack_type				= ATTACKTYPE.BLUNT;
	walk_sprite				= "walkpiperusty";
	attack_sprite			= "attackpiperusty";
	bFlipSprite				= true;
	range					= 16 * 3;
	attack_frame			= 4;
	screen_shake			= 5;
	droppable				= true;

	random_attack_sounds	= true;	
	attack_sound			= [snd_swing_blunt, snd_swing_blunt_2, snd_swing_blunt_3];
	firerate				= 60 / 90;
	
	penetration				= 3;
	
	static DoMeleeHitEntity = function( victim, attacker ) {
		gore_melee( victim );
		playsound_at( snd_gore_hit, victim.x, victim.y, 16 * 8, 16 * 8 );	
		
		victim.charVelocity = 0;
		victim.stats.hp = 0;
		victim.stats.armour = 0;
		
        inst = instance_create_depth( attacker.x, attacker.y, -30, obj_debris );
        inst.x = attacker.x + lengthdir_x( 16, 0 );
        inst.y = attacker.y + lengthdir_y( 16, 0 );
        inst.image_angle = random_range( -360, 360 );
        inst.debrisSprite = spr_debris_weapons;
        inst.direction = random_range( -360, 360 );
        inst.bDoBounce = true;
        inst.debrisIndex = 1;
        inst.SetSpd( random_range( 1, 3 ) );
        inst.SetFrc( random_range( 0.20, 0.35 ) );
        inst.SetHeight( 1 );
        inst.SetWeight( 0.20 ); 
        inst.zsp = -random( 3 ); 
        
        inst = instance_create_depth( attacker.x, attacker.y, -30, obj_debris );
    	inst.x = attacker.x + lengthdir_x( 16, 0 );
        inst.y = attacker.y + lengthdir_y( 16, 0 );
        inst.image_angle = random_range( -360, 360 );
        inst.debrisSprite = spr_item_weapons_unloaded;
        inst.direction = random_range( -360, 360 ) - 180;
        inst.bDoBounce = true;
        inst.debrisIndex = 48;
        inst.SetSpd( random_range( 1, 3 ) );
        inst.SetFrc( random_range( 0.20, 0.35 ) );
        inst.SetHeight( 1 );
        inst.SetWeight( 0.20 ); 
        inst.zsp = -random( 3 );
        
		attacker.currentWeapon = attacker.defaultWeapon;
        attacker.SetSpriteFromIndex( attacker.currentWeapon.walk_sprite );
        attacker.IsMeleeAttacking = false;
	};
};