event_inherited();

charInit( "JoeAct1", FACTION.PLAYER, 0, 0 );
SetControllerSelf();

currentWeapon = defaultWeapon;

flashlightOn = false;
flashlight = instance_create_depth( transform.position.x, transform.position.y, transform.position.z, obj_light_cone );
flashlight.light.angle = transform.angle;
flashlight.light.alpha = flashlightOn;

init = function() {
    self.stats.hp_max       = global.player_stats.hp;
    self.stats.armour_max   = global.player_stats.armour;
    self.stats.hp           = global.player_stats.hp;
    self.stats.armour       = global.player_stats.armour;
}
init();

eventhandler_subscribe( self.id, "ev_loadprogress", init );

canPickupWeapons = false;
canPickupItems = true;
canThrowWeapons = false;
canAttack = false;

can_attack = true;

charWalkSpd			= 1.25; //1.25; old.
charWalkAcc			= 0.10;
charWalkDec			= 0.20;
charWalkFrc			= 0.20;
charWalkAccAlt		= 0.20;
charWalkDecAlt		= 0.20;

maxWalkSpeed = charWalkSpd; // Max Walking Speed
minWalkSpeed = 0.80; // Minimum Walking Speed
curWalkSpeed = 0; // Current Walking Speed

bIsDiving = false;

charDiveCurrentSpd = 0;
charDiveFrcTime = 30; // Time before the friction of the dive kicks in
charDiveAirFrc = 0.020; // The friction applied when "in the air"
charDiveGroundFrc = 0.10; // The friction of the dive on the ground
charDiveMinSpd = charWalkSpd / 2; // The speed that must be reach before a dive can be done
charDiveRampSpd = 0.10; // the speed at which it will increment until it hits max speed.
charDiveMaxSpd = 4;
charDiveDelay = new cTimer( 60, ,true ); // delay between dives
charDiveDir = 0;
charDiveSpd = 3.30;
charDiveTime = 60 * 4; // The max time spent in the dive? Maybe just divide by how long the ability key was pressed.

// Normal alive cState
idleState = new cState();

// Used for gun
aimingState = new cState();

currentState = idleState;

draw = new cDrawComponent();
// .AddAnimation( get_animation_from_index( charName, currentWeapon.animations[$ "walk"].animKey ) );