event_inherited();
image_speed				= 0;
debug					= false;
currentBehaviour = -1;

entFlags = new cFlags( ENT_FLAGS.ACTIVE );
initAIDummy = function( _behaviour = ai_bh_wander, _flags = ENT_FLAGS.ACTIVE | ENT_FLAGS.DEAF )
{
	entFlags.SetFlag( _flags );
	currentBehaviour = _behaviour;
};

initAIDummy();

// Previous target inst id
prevTarget = undefined;

// Previous target position as a vector so we can path back after finding a weapon or doing some other interaction
prevTargetPos = new Vector2( x, y );

isValidLockonTarget = true;
currentPath				= path_add();
currentPathX			= 0;
currentPathY			= 0;

fWanderDir		= random_range( -360, 360 );
searchTimer 	= new cTimer( 60 / 1.50, false, true );
suspicionTimer	= new cTimer( 30, false, true );
sightTimer		= new cTimer( 30, false, true ); // Timer before shooting can happen when target in sight
_rotate_timer	= new cTimer( 60 * 6 );
_walk_timer 	= new cTimer( 90 );
_delay_timer	= new cTimer( 175 );

on_proj_death = function()
{
	if ( CanCreateBody && !body_created )
	{
		body_created = true;
		gore_bullet( proj_hit_id, proj_hit_id.direction, self );
		add_score( 100, 1 );
		global.score.combo_time = obj_player.combo_maxtime;
		
		if ( delta != 1 )
		{
			global.trophies.trophy_quest_pointman.Add( 1 );
		};
		
		obj_player.stats.style += 60 * global.combo_multiplier;
	}
	
	charThrowWeapon( random_range( 3, 4 ), charLookDir );
};
#region Ai Methods
looking_for_gun = false;

// Check if we meet all the prerequesites to look for a gun.
CheckFindWeapon = function()
{
	if ( ( !looking_for_gun
	&& currentWeapon.ammo == 0 
	&& currentWeapon.attack_type == ATTACKTYPE.GUN ) 
	|| ( currentWeapon.itemName == "Unarmed" ) )
	{
		looking_for_gun = true;
		return true;
	}
	else
	{
		return false;
	};
};

FindWeapon = function()
{
	var _result = false;
	var _pos = [0, 0];
	
	pickup_target = charGetWeaponPickupTarget( self.id, ai_visiondist * 0.35 );
	
	if ( CheckMovementLoS( pickup_target, self, ai_visiondist ) 
	&& pickup_target.gun.ammo > 0 )
	{
		_pos[0] = pickup_target.x;
		_pos[1] = pickup_target.y;
		_result = true;
	}
	else
	{
		looking_for_gun = false;
		charVelocity = 0;
		path_end();
		_result = false;
	};
	
	return {
		result : _result,
		pos : _pos,
		target : pickup_target
	};
};

GotoObject = function( obj )
{
	if ( CalculatePathToPoint( [obj.x, obj.y] ) )
	{
		
		//InteractObject( obj );
	};
};

InteractObject = function( obj )
{
	if ( charPickupWeapon() )
	{
		enemy_alert = EALERT.UNALERT;
		looking_for_gun = false;
		charVelocity = 0;
		path_end();
	};
};

AIShoot = function() {
	switch( currentWeapon.firemode_type ) {
		case FIREMODE.SEMI :
			charAttackWeapon( true );
			break;
		case FIREMODE.AUTO :
			charAttackWeapon( true );
			break;
	}
};
#endregion

#region Enemy States
enemy_state				= ESTATE.IDLE;
enemy_behaviour			= EBEHAVIOUR.IDLE;
enemy_alert				= EALERT.UNALERT;
currentFaction			= FACTION.AITEAM1;

start_x			= x;
start_y			= y;
patrol_dir		= movementDirection;
#endregion
#region Enemy stats
knocked_sprite			= get_animation_from_index( charName, "downed" ) ?? FALLBACK_ANIMATION;

hp						= 10;
armour				= 0;

hp_max					= 125;
caliber_hit				= noone;

can_die					= true;
can_path				= true;
can_collide_proj		= true;
can_collide_item		= true;

chase_spd				= 0.9;

target_dir				= 0;
start_direction			= image_angle;
turn_speed				= 0;
aim_speed				= 0;
wander_dir				= random_range( 0, 360 );
turning					= false;

knocked_index			= 0;
knocked_timer			= 60;
knocked_timer_max		= 60;
recovery_spd			= 0.2;

#endregion
#region See Player
seen_player				= false;
seen_x					= 0;
seen_y					= 0;
start_x					= x;
start_y					= y;
target_x				= 0;
target_y				= 0;
currentTarget			= noone;
#endregion
#region Timers
wander_timer			= 90;
alert_timer				= 0;
wander_delay_max		= 175;
wander_delay			= random_range(0, wander_delay_max);
rotation_timer			= random_range(0, 120);
walk_timer				= random_range(0, 175);
rotation_timer_max		= 120;
walk_timer_max			= 175;
sustimer				= 10;
sustimer_max			= 10;
search_timer			= 60;
search_timermax			= 60;
turn_spd				= 0;
#endregion

stop_dist				= 16 * 14;
backpedal_dist			= 16 * 4;
ai_visiondist			= 32 * 12;
ai_detect_radius		= 32 * 8;

// ai_init( 10, EBEHAVIOUR.WANDER, true, true );