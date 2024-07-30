/// @param		{sprite}	_animation
/// @param		{number}	_anim_spd
/// @param		{number}	_start_frame
function animation_init_finite( _animation, _anim_spd, _start_frame = 0 ) {
    var animation = new cAnimation();
    animation.animType = ANIMATION_TYPE.FINITE;
    animation.anim = _animation;
    animation.animSpd = _anim_spd;
    animation.animStartIndex = _start_frame;
    
    return animation;
}

/// @param		{sprite}	_animation
/// @param		{number}	_anim_spd
/// @param		{number}	_repeats
/// @param		{number}	_start_frame	
function animation_init_looped( _animation, _anim_spd, _repeats = -1, _start_frame = 0 ) {
    var animation = new cAnimation();
    animation.animType = ANIMATION_TYPE.LOOPED;
    animation.anim = _animation;
    animation.animSpd = _anim_spd;
	animation.animRepeats = ( _repeats != -1 ) ? 0 : _repeats;
    animation.animStartIndex = _start_frame;
    
    return animation;
}

/// @param		{sprite}	_animation
/// @param		{struct}	_end_animation
/// @param		{number}	_anim_spd
/// @param		{number}	_repeats
/// @param		{number}	_start_frame
function animation_init_chained( _animation, _end_animation, _anim_spd, _repeats = -1, _start_frame = 0 ) {
    var animation = new cAnimation();
    animation.animType = ANIMATION_TYPE.CHAINED;
    animation.anim = _animation;
    animation.animSpd = _anim_spd;
    animation.animNext = _end_animation;
	animation.animRepeats = ( _repeats != -1 ) ? _repeats : 0;
    animation.animStartIndex = _start_frame;
    
    return animation;
}

function cAnimation() constructor {
    anim = -1; // Asset index of the sprite
    currentIterations = 0; // How many times we will loop
	animRepeats = 0;
    animNext = undefined; // Struct reference of next animation
    animType = ANIMATION_TYPE.FINITE;
    animSpd = 0;
    animStartIndex = 0;
    isInterruptable = false;
    
    // End frame defined to execute the end function. If none is defined then it will execute at the end of an animation
    animEndIndex = 0;
    animEndFunc = undefined;
    
	/// @static
	static OnAnimEnd = function() {};
	
	/// @static
	static SetIterations = function( _iterations = 0 ) {
		animRepeats = _iterations;
	}
	
	static LoadData = function( data ) {
		anim = data[$ "anim"];
		animType = data[$ "animType"];
		animSpd = data[$ "animSpd"];
		animRepeats = data[$ "animRepeats"];
		animNext = data[$ "animNext"];
	}
	
	static GetData = function() {
		return {
			anim,
			animType,
			animSpd,
			animRepeats,
			animNext
		}
	}
	
	/// @static
	static GetCurrentAnimSpeed = function() {
		return animSpd;
	}
	
	/// @static
	static OnAnimationSwitch = function() {
		currentIterations = 0;
	}
}