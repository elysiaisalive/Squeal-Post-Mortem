z = depth;			// -30 is a good depth to have it at.
zSpd = -random( 3 );	// how fast the object is launched upwards at
ground_z = 0;		// the depth the object bounces at
bounce = 0.6;		// multiplier for the bounce
bounceFrc = 0.6;	// multiplier for speed lost when bouncing

airFrc	= 0.02;		// friction in the air
groundFrc = 0.1;	// friction on the ground

height = 1;			// how tall the object is 
weight = 0.2;		// how fast the object falls

angle_rot = random_range( -4, 4 );
spin = 1 * angle_rot;

sound_single = false; // only play a bounce sound once ( e.g: one sound with multiple bounces )
sound_played = false;

zScaleAmnt = ( 1 / 2 ); // the strength of the 3d effect in topdown
zScaleRamp = ( zScaleAmnt / 15 ); // the amount added to the z scale every step until it reaches the amount
zscale = 0;

debrisSprite	= -1;
debrisIndex     = 0;
debrisSpd		= 0;
debrisFrc		= 0;
debrisDir		= 0;

bFollowDir = false;
bDoBounce   = false;
bAnimated   = false;
bounceSnd = -1;
bounceDir = random_range( -45, 45 );

SetSpd = function( _spd = 1 ) {
    debrisSpd = _spd;
}
SetFrc = function( _frc = 0.25 ) {
    debrisFrc = _frc;
}
SetHeight = function( _height = 1 ) {
    height = _height;
}
SetWeight = function( _weight = 0.20 ) {
    weight = _weight;
}
SetBounceSound = function( _sound = -1 ) {
    bounceSnd = _sound;
}
OnBounce = function() {}
OnLand = function() {}

// Visual positions of the debris
visPosX = x;
visPosY = y;
shadowX = x;
shadowY = y;