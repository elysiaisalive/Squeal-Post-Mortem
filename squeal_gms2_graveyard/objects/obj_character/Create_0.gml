event_inherited();

flags.SetFlag( OBJFLAGS.DYNAMIC );

defaultWeapon = new melee_fists();
currentWeapon = new melee_fists();
lastWeapon = currentWeapon;

inventory = new cInventory();
movementTimer = new cTimer( 1, false, true );

statuses = new cStatusEffectManager( self.id );

#region Methods
MakeNoise = function( noise = 0, life = -1 ) {
	var _inst = instance_create_depth( x, y, -45, obj_soundsource );
	_inst.noise.life = life;
	_inst.noise.volume = noise;
}
#endregion

// Struct of the current animation
defaultAnim = animation_init_finite( FALLBACK_SPRITE, 0 );
currentAnimation = defaultAnim;
currentLegAnimation = defaultAnim;

currentTriggerTime = 0;
currentTriggerReset = 0;

defaultTurnSpeed = 1.0;
turnSpeed = 1.0;

lastAnimation = currentAnimation;
lastAnimIndex = 0;

charName = "Dummy";
currentFaction = FACTION.NONE;

idleState = new cState();

deadState = new cState();
deadState.OnEnterState = function() {
	statuses.ClearEffects();
}

currentState = idleState;
currentBehaviour = -1;
#region Character Booleans
// Footsteps
footStepsEnabled = false;
stepped = false;

// Item and weapon interaction
canPickupWeapons = true;
canPickupItems = true;
canThrowWeapons = true;
canAttack = true;
isAimedIn = false;
isAttacking = false;
isMoving = false;

// Movement and Input
can_die				= true;
canMoveMouse		= true;
can_zoom			= true;
canMove				= true;
can_attack			= true;
CanDown				= true;
CanGetUp			= true;
CanBleed			= false;
can_pickup_item		= true;
CanBleedHP			= false;
CanGetLocked		= true;
can_lockon			= false;
can_collide_proj	= true;
can_collide_item	= false;
CanCollideSolid		= true;
CanSpawn			= true;
CanBurn				= true;
FriendlyFire		= false;
StaggerOnShot		= false;
BodyCreated			= false;
#endregion

// Character Stat Struct
stats = {
	hp				: 125,
	hp_max			: 125,
	armour			: 0,
	armour_max		: 100,
	style			: 0,
	style_max		: 0,
	hp_resist		: 0,
	armor_resist	: 0,
	dmg_crit		: 0,
	hp_bleedamount	: 5,
	bleed_threshold : 25,
	burn_resist		: 0,
	recoil_modifier	: 1
};

// _func arg is for nesting a function inside hte function call so you can do some extra stuff if you so please
ChangeState = function( _newstate = sNullState, _func = -1 ) {
	currentState = _newstate;
	currentState.InitState( _newstate );
	
	if ( _func != -1 ) {
		_func();
	}
};

muzzleflash = instance_create_depth( x, y, depth, obj_effect_muzzleflash );
muzzleflash = self.id;

override_bulletcolors = [ #ffff00, #ffffcc ];

entFlags = new cFlags( ENT_FLAGS.ACTIVE );
entFlags.SetFlag( ENT_FLAGS.ACTIVE );
proj_hit_id			= undefined;
CanCreateBody		= true;
body_created		= false;
execution_index		= 0;
execution_target	= noone;
combo_maxtime		= 60 * 5;

proj_hits			= 0;

charSpriteIndex 	= -1;
charSpriteScaleX 	= 1;
charSpriteScaleY	= 1;

charCollisionMask	= spr_mask_default;
mask_index			= charCollisionMask;

animIndex		= 0;
AnimSpd			= 0;

charLegAnimIndex	= -1;

charLookDir 		= 0;
charLegDir			= 0;

charWalkSpd = 3.50; // Desired Walking Speed
maxWalkSpeed = charWalkSpd; // Max Walking Speed
minWalkSpeed = 0.80; // Minimum Walking Speed
curWalkSpeed = 0; // Current Walking Speed

charWalkAcc			= 0.50;
charWalkDec			= 0.50;
charWalkFrc			= 0.50;
charWalkAccAlt		= 0.50;
charWalkDecAlt		= 0.50;

currentWalkSpd		= 0;
currentWalkAcc		= 0;
currentWalkDec		= 0;	
currentWalkFrc		= 0;
currentWalkInc		= 0;
currentWalkRebound	= 0;
currentXSpd			= 0;
currentYSpd			= 0;
currentWalkDir		= 0;
currentMoveSpeedModifier = 1;

charTriggerDelay	= 0;

// Array for following AI
currentFollowers 	= [];

// Used for melee weapon hitbox checks
IsMeleeAttacking	= false;
meleePenetration	= 0;

bExecutingMoveFunc = false;////////////

charVelocity	= 0;
movementDirection	= 0;

#region Input
input_primary			= false;
input_secondary 		= false;
input_moveup			= false;
input_movedown			= false;
input_moveleft			= false;
input_moveright			= false;
input_strafe			= false;

trigger_pressed			= false;
trigger_released		= false;
trigger_held			= false;

trigger_second_pressed	= false;
trigger_second_released	= false;
trigger_second_held		= false;

trigger_alt_pressed		= false;
trigger_alt_released	= false;
trigger_alt_held		= false;
#endregion

IsDoingWeaponAnimation = false;

#region Weapon and Character Init
currentTriggerReset		= 0.1;
#endregion

SetMask = function( _maskindex = spr_mask_default )
{
	charCollisionMask = _maskindex;
	mask_index = charCollisionMask;
};
OnPathEnd = function(){return true;};

// Find a better way
moveTimer = new cTimer( 0, , true );
MoveTowardsFor = function( _time = 60 * 2, _spd = 0.25, _dir = 0, _lockdir = true ) {
	_finished = false;
	bExecutingMoveFunc = true;
	
	if ( !_finished 
	&& moveTimer.timer_paused ) {
		moveTimer.set_maxtime = _time;
		moveTimer.set_time = moveTimer.set_maxtime;
	}
	
	if ( moveTimer.GetTime() <= 0 ) {
		_finished = true;
		charVelocity = 0;
		movementDirection = 0;
		bExecutingMoveFunc = false;
		canMoveMouse = true;
		moveTimer.ResetTimer( false, true );
	}
	
	moveTimer.Unpause();
	moveTimer.Tick();
	
	if ( moveTimer.GetTime() > 0 ) {
		if ( _lockdir ) {
			canMoveMouse = false;
			charLookDir = rotate_to( charLookDir, _dir, 0.40 );
		}
		
		charVelocity = _spd;
		movementDirection = _dir;
	}
}

#region cState Methods
KillCharacter = function()
{
	isValidLockonTarget = false;
	canMove				= false;
	can_attack			= false;
	CanDown				= false;
	CanBleed			= false;
	CanBleedHP			= false;
	CanGetLocked		= false;
	can_lockon			= false;
	can_collide_proj	= false;
	CanCollideSolid		= false;
    charVelocity	= 0;
    currentWeapon.trigger_pressed = false;
    charThrowWeapon( random_range( 3, 4 ) );
    
    with( obj_proj_generic ) {
    	if ( self.currentFaction == other.currentFaction ) {
    		instance_destroy( self.id );
    		exit;
    	}
    }
};
DisableInput = function()
{
	canMove = false;
	canMoveMouse = false;
};
DropWeapon = function( throwspeed, throwdir )
{
	charThrowWeapon( throwspeed, throwdir );
};
#endregion
#region Saving Methods
SaveState = function( buf = global.checkpoint )
{
	var encoded_struct = json_stringify( currentWeapon );
	
	print( "Saved :" + encoded_struct );
	buffer_write( buf, buffer_string, encoded_struct );
	currentWeapon.SaveState( buf );
};
LoadState = function( buf = global.checkpoint )
{
	var decoded_struct = json_parse( buffer_read( buf, buffer_string ) );
	
	currentWeapon = decoded_struct;
	currentWeapon.LoadState( buf );
};
#endregion
#region Collision Methods
on_proj_hit	= function()
{
	#region Particles
	repeat( random_range( 2, 3 ) )
	{
		spawn_particle(
			obj_particle_generic,
			spr_effect_bloodshot2,
			0.6,
			proj_hit_id.direction - 180 + random_range( -30, 30 ),
			0,
			1,
			x,
			y,
			random_range( 4, 6 ), 
			random_range( 0.3, 0.6 ),
			1,
			false,
			true,
			-95,
			true
			);
	};
	repeat( random_range( 4, 5 ) )
	{
		spawn_particle(
			obj_particle_generic,
			sprBloodSmoke,
			random_range( 0.4, 0.6 ),
			random_range( -360, 360 ),
			0,
			1,
			x,
			y,
			random_range( 3, 4 ), 
			random_range( 0.3, 0.6 ),
			1,
			false,
			true,
			-95,
			true
			);
	};
	#endregion
	
	#region Gore
	repeat( random_range( 12, 16 ) )
	{
		var inst = instance_create_depth( x, y, -15, obj_gore_generic );
		inst.sprite_index = spr_bloodspeck_med;
		inst.image_index = floor( random( sprite_get_number( inst.sprite_index ) ) );
		inst.done = false;
		inst.gore_spd = random_range( 2, 6 );
		inst.gore_frc = random_range( 0.4, 0.5 );
		inst.direction = random_range( -360, 360 );
		inst.image_angle = inst.direction;
	}
	
	repeat( random_range( 2, 4 ) )
	{
		var inst = instance_create_depth( x, y, -15, obj_gore_blood_drop );
		inst.sprite_index = spr_blood_drop;
		inst.done = false;
		inst.advancespeed = random_range( 0.1, 0.3 );
		inst.gore_spd = random_range( 2, 6 );
		inst.gore_frc = random_range( 0.4, 0.5 );
		inst.direction = random_range( -360, 360 );
		inst.image_angle = inst.direction;
	}
	#endregion
	return true;
};
on_proj_death	= function()
{
	if ( CanCreateBody && !body_created )
	{
		body_created = true;
		gore_bullet( proj_hit_id, proj_hit_id.direction, self );
	};
};

on_proj_overload = function()
{
	repeat( random_range( 32, 40 ) )
	{
		var inst = instance_create_depth( x, y, -15, obj_gore_generic );
		inst.sprite_index = spr_gore_bloodychunk_small;
		inst.image_index = floor( random( sprite_get_number( inst.sprite_index ) ) );
		inst.surfacetype = obj_surface_manager.body_surf;
		inst.done = false;
		inst.bounce = true;
		inst.splat = true;
		inst.gore_spd = random_range( 1, 1.65 );
		inst.gore_frc = random_range( 0.40, 0.50 );
		inst.direction = random_range( -360, 360 );
		inst.image_angle = inst.direction;
	};	
	
	repeat( random_range( 12, 24 ) )
	{
		var inst = instance_create_depth( x, y, -15, obj_gore_generic );
		inst.sprite_index = choose( spr_gore_bloodychunk_med, spr_gore_bloodychunk_big );
		inst.image_index = floor( random( sprite_get_number( inst.sprite_index ) ) );
		inst.surfacetype = obj_surface_manager.body_surf;
		inst.done = false;
		inst.bounce = true;
		inst.splat = true;
		inst.gore_spd = random_range( 1, 2.45 );
		inst.gore_frc = random_range( 0.40, 0.50 );
		inst.direction = random_range( -360, 360 );
		inst.image_angle = inst.direction;
	};	
	
	repeat( random_range( 24, 38 ) )
	{
		var inst = instance_create_depth( x, y, -15, obj_gore_generic );
		inst.sprite_index = spr_gore_bloodychunk_mess;
		inst.image_index = floor( random( sprite_get_number( inst.sprite_index ) ) );
		inst.surfacetype = obj_surface_manager.body_surf;
		inst.done = false;
		inst.gore_spd = random_range( 2, 4 );
		inst.gore_frc = random_range( 0.35, 0.55 );
		inst.direction = random_range( -360, 360 );
		inst.image_angle = inst.direction;
	};
	
	repeat( random_range( 2, 3 ) )
	{
		spawn_particle(
			obj_particle_generic,
			spr_effect_bloodymess,
			random_range( 0.035, 0.065 ),
			random_range( -360, 360 ),
			random_range( -360, 360 ),
			1,
			x,
			y,
			random_range( 1, 1.25 ), 
			random_range( 0.050, 0.080 ),
			1,
			true,
			true,
			-95,
			true,
			random_range( 0.0040, 0.010 )
		);
	};
	
	repeat( random_range( 8, 12 ) )
	{
		spawn_particle(
			obj_particle_generic,
			spr_effect_bloodshot,
			random_range( 0.035, 0.065 ),
			random_range( -360, 360 ),
			random_range( -360, 360 ),
			1,
			x,
			y,
			random_range( 2, 4 ), 
			random_range( 0.20, 0.30 ),
			1,
			true,
			true,
			-95,
			true,
			random_range( 0.0040, 0.010 )
		);
	};
	
	playsound_at( snd_fatexplode1, x, y );
	KillCharacter();
};

on_proj_hit_armour	= function()
{		
	#region Particles
	var _lenx = lengthdir_x( 14, proj_hit_id.direction );
	var _leny = lengthdir_y( 14, proj_hit_id.direction );
	
	repeat( random_range( 6, 8 ) )
	{
		spawn_particle(
			obj_particle_generic,
			spr_effect_spark_armour,
			0.4,
			proj_hit_id.direction - 180 + random_range( -30, 30 ),
			0,
			1,
			x - _lenx,
			y - _leny,
			random_range( 4, 6 ), 
			random_range( 0.3, 0.6 ),
			1,
			false,
			true,
			-95,
			true
			);
	}
	#endregion
};

on_armour_break	= function()
{
	playsound_at( snd_armor_shatter, x, y );
	
	#region Particles
	repeat( random_range( 6, 8 ) )
	{
		spawn_particle(
			obj_particle_generic,
			spr_effect_spark,
			0.6,
			random_range( -360, 360 ),
			0,
			1,
			x,
			y,
			random_range( 4, 6 ), 
			random_range( 0.3, 0.6 ),
			1,
			false,
			true,
			-95,
			true
			);
		spawn_particle(
			obj_particle_generic,
			spr_effect_smoke_tiny3,
			0.1,
			random_range( -360, 360 ),
			0,
			1,
			x + random_range( -16, 16 ),
			y + random_range( -16, 16 ),
			random_range( 1, 3 ), 
			random_range( 0.2, 0.3 ),
			1,
			true,
			true,
			-95,
			true
			);
	}
	
	spawn_particle(
		obj_particle_generic,
		spr_effect_shatter,
		0.3,
		0,
		0,
		1,
		x,
		y,
		0, 
		0,
		1,
		true,
		true,
		-255,
		true
		);
	#endregion
};
OnMeleeHit = function(){};
OnMeleeDeath = function(){};
OnActivateSlowMo = function(){};
OnDeActivateSlowMo = function(){};
#endregion

#region stats

// Style Points
style_ready				= false;
stopwatch				= 0;
drain					= false;

//Slow Motion
timeslow_scale			= 0;
timeslow_ease			= 0;
timeslow_ease_scale		= 0;
timeslow_ease_timer		= 0;
timeslow_ease_duration	= 30;

anim_spd	= 0;

char_state			= CSTATE.ALIVE;
char_status			= STATUS.NEUTRAL;

melee_attackmultiplier	= 1;

stun_time			= 60 * 4;
stun_maxtime		= 60 * 4;

pickup_target		= noone;
pickup_range		= 16 * 2;

igniteTimer			= 0;
igniteMaxTimer		= 4;
helmet_on			= false;
helmet_created		= false;
canwear_helmet		= false;

DrawVest			= false;
DrawMask			= false;

bleedout			= false;
bleedout_timer		= 40;
bleedout_a			= 0;

damageTaken			= 0;

hit_a				= 0;

BloodLost			= 0;

laser_dist			= 150;

movement_speed		= 3.50;
movement_acc		= 0.50;
movement_acc_alt	= 0.50;
movement_frc		= 0.50;
movement_dec		= 0.50;
movement_dec_alt	= 0.50;
movement_rebound	= 0.50;

movement_impulse	= 0;
movement_impulsedir	= 0;

character_height	= 50;

shadow_depth		= 1;

height				= character_height;
eyes				= character_height - 4.5;

mask_sprite			= -1;
sprite_index		= -1;

knocked_index		= 0;
knocked_timer		= 0;
knocked_timer_max	= 0;
recovery_spd		= 0.5;
#endregion
#region Misc init
currentXSpd			= 0;
currentYSpd			= 0;
myspeed				= 0;
myacc				= 0;
mydec				= 0;
myfrc				= 0;
myinc				= 0;
left				= 1;


charLookDir			= image_angle;
lookdir_raw			= image_angle;
image_angle			= 0;
start_angle			= image_angle;

legindex			= 0;
charLegDir			= 0;

flipped				= false;
#endregion