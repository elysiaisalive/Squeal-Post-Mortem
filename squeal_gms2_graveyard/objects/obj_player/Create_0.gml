event_inherited();

// Forcing all audio from weapons to be in vol_stereo
audio_overrides.force_stereo = true;
user().SetControllerInstance( self );
camera_set_target( self );

accuracy = 0;
minAccuracy = 0;
maxAccuracy = 100;
accuracyAimRamp = 1.5; // Accuracy aim ramp that is modified by the current weapons aim speed multipler ( and subsequently any mods )
accuracyAimDecay = 2.0; // Accuracy decay rate when not aimed in
accuracyMoveDecay = 0.90; // Decay rate when moving

EnableMovement = function( _state = true ) {
	canMove = _state;
	canMoveMouse = _state;
}
SetControllerSelf = function() {
	if ( global.input_target == noone
	&& global.camera_target == noone )
	{
		global.input_target = self.id;
		camera_set_target( self.id );
	};
};

SwapCharacter = function( _character ) {
	if ( instance_exists( _character ) ) {
		global.input_target = _character.id;
		global.camera_target = _character.id;
			// global.input_target.UpdateHUD();
		return true;
	}
	else {
		println( "Failed To Swap Characters ... Character [" + string( instance_id_get( _character ) ) + "] Doesn't exist" );
		return false;
	};
};

// Radius of "sound" generated when the player fires a loud weapon.
noise_radius			= 0;
noise_radius_decay		= 0.1;
noise_radius_max		= 16 * 64;

powerup_gum				= false;

can_attack				= true;
CanDown					= true;
CanBleed				= true;
CanGetLocked			= false;
can_lockon				= true;
can_collide_proj		= true;
CanCollideSolid			= true;
input_enabled			= false;

bleed_threshold			= 25;

stepped					= false;

snd						= false;

currentFaction					= FACTION.PLAYER;

on_proj_death	= function()
{
	if ( CanCreateBody && !body_created )
	{
		body_created = true;
		gore_bullet( proj_hit_id, proj_hit_id.direction, self );
	}
	
	charThrowWeapon( random_range( 3, 4 ), charLookDir );
	UpdateHUD();
};

// UpdateAmmo = function()
// {
// 	with( obj_hud )
// 	{
// 		current_hud.ammo.elem_value = other.currentWeapon.ammo;
// 	};
// };

// UpdateHUD = function()
// {
// 	UpdateAmmo();
// };

// UpdateHUD();
footStepsEnabled = true;

heartBeatSound = snd_heartresting;
heartRate = 1;
sfx_play( heartBeatSound, {
	isLooped : true,
	gain : 0.3
} );