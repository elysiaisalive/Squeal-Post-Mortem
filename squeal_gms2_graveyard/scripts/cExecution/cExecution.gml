function cExecution() constructor 
{
	e_id			= "Unarmed";			// Execution ID
	playing			= false;				// Is execution playing?
	psprite			= "ExecutionUnarmed";	// Player Sprite
	esprite			= "ExecutionUnarmed";	// Enemy Sprite
	pframe			= 0;					// Player frame
	eframe			= 0;					// Enemy frame
	origin			= [0, 2];				// Offset from the center of the target
	spd				= 0;					// Animation Speed
	repeats			= [1, 2];				// Repeats
	death_sprite	= "DeadUnarmedExecute";	// Death Sprite after execution is finished
	frameactions	= [];					// Actions that will occur for each frame of the execution
	
	static NextAttackerFrame = function()
	{
		anim_index += 1;
		return true;
	};
	
	static NextVictimFrame = function()
	{
	    if ( execution_target != noone )
	    {
	    	execution_target.anim_index += 1;
	    	return true;
	    };
	};
	
	static SetAttackerFrame = function( newframe )
	{
		pframe = newframe;
	};
	
	static SetVictimFrame = function( newframe )
	{
		eframe = newframe;
	};
		
	static GetVictimState = function( _state = CSTATE.DEAD )
	{
		execution_target.char_state = _state;
	};
		
	static DoClick = function()
	{
		if ( keyboard_check_direct( 1 ) || mouse_check_button( mb_left ) )
		{
			current_execution.playing = true;
		};
	};
	
	static FinishExecution = function()
	{
		return true;
	};
};