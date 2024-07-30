/**
 * Function Initializes a level and the rooms to be used for its "floors"
 * @param {string} [name] Level Name
 * @param {array<array<any>>} [floors] A 2D Array that holds the rooms that the level will transition between and the completion states of floors
 * @param {bool} [_state] The completion cState  of the level
 */
 global.level = {};

function cLevel_OLD( name = FALLBACK_STRING, floors = [ [noone, false] ], _state = false, max_combo = 0, par_time = 0, par_score = 0 ) constructor
{
    static levelnum = 0;
	
    _levelid	= levelnum++;
	
	_done		= _state;
	_name		= name;
	_floors		= floors;
	maxcombo	= max_combo;
	partime		= par_time;	// Developer / Player tester averaged times
	parscore	= par_score; // Developer / Player tester averaged scores
	
	// Populating the checkpoint array with the stage floors
	// for( var i = 0; i < array_length( _floors ); ++i )
	// {
	// 	array_push( global.checkpointarray[i][0], _floors );
	// 	array_push( global.checkpointarray[i][1], buffer_create( 1, buffer_grow, 1 ) );
		
	// 	buffer_seek( global.checkpointarray[i][1], 0, 0 );
	// 	buffer_write( global.checkpointarray[i][1], buffer_u8, 0 );
	// };
	
	/* 
	floors = 
	[
		[room, cState, checkpoint buffer], [room_2, cState, checkpoint buffer]
	]
	*/
	
    static GetState = function()
    {
        return _done;
    }
	
    static GetName = function()
    {
        return _name;
    }  
    
    static GetMaxCombo = function()
    {
        return maxcombo;
    }
	
    static GetFloors = function()
    {
		var array = [];
		
		for( var i = 0; i < array_length( _floors ); ++i )
		{	
			array_push( array, _floors[i][0] );
			
			//println( "All Floors [" + string( room_get_name( _floors[i][0] ) ) + "]", true );
		}
		
        return array;
    }
	
	static IsLevelComplete = function()
	{
		var result = true;
		
		for( var i = 0; i < array_length( _floors ); ++i )
		{	
			if ( !_floors[i][1] )
			{
				result = false;
			}
		}
		
		return result;
	}

	static CompleteLevel = function()
	{
		for( var i = 0; i < array_length( _floors ); ++i )
		{	
			if ( !_floors[i][1] )
			{
				_floors[i][1] = true;
			}
		}
	}
	
	static ExitLevel = function()
	{
		var unpersist_list = [
			obj_player,
			obj_hud,
			obj_cursor,
			obj_camera_control
		];
		
		for( var i = 0; i < array_length( _floors ); ++i )
		{		
			room_set_persistent( _floors[i][0], false );
			println( "Floor [" + room_get_name( _floors[i][0] ) + "]" );
		};
		
		global.score.Reset();
		
		global.level.lvl = -1;
		global.camera_target = noone;
		global.input_target = noone;
	}
	
    static GetCurrentFloor = function()
    {		
		for( var i = 0; i < array_length( _floors ); ++i )
		{	
			if ( _floors[i][0] == room )
			{
				//println( "Current Floor [" + string( room_get_name( _floors[i][0] ) ) + "]" );
				return _floors[i][0];
			}
		}
    }
	
	/**
	 * I was here :)
	 */
    static GetNextFloor = function()
    {
        for( var i = 0; i < array_length( _floors ); ++i )
        {
            if ( _floors[i][0] == room )
            {
				//println( "Next Floor [" + string( room_get_name( _floors[i + 1][0] ) ) + "]" );
                return _floors[i + 1][0];
            }
        }
    }
    
    static GetPrevFloor = function()
    {    
        for( var i = 0; i < array_length( _floors ); ++i )
        {
            if ( _floors[i][0] == room )
            {
                return _floors[i - 1][0];
            }
        }
    }
    
    static GetNextFloorState = function()
    {
        for( var i = 0; i < array_length( _floors ); ++i )
        {
            if ( _floors[i][0] == room )
            {
                return _floors[i + 1][1];
            }
        }
    }
    
    static GetPrevFloorState = function()
    {
        for( var i = 0; i < array_length( _floors ); ++i )
        {
            if ( _floors[i][0] == room )
            {
                return _floors[i - 1][1];
            }
        }
    }
	
    static GetCurrentFloorState = function()
    {
		for( var i = 0; i < array_length( _floors ); ++i )
		{	
			if ( _floors[i][0] == room )
			{
				//println( "Current Floor cState [" + string( _floors[i][1] ) + "]" );
				return _floors[i][1];
			}
		}
    }
	
    static SetCurrentFloorState = function( _state )
    {
		for( var i = 0; i < array_length( _floors ); ++i )
		{	
			if ( _floors[i][0] == room )
			{
				_floors[i][1] = _state;
			}
		}
    }
	
    static OnFloorClear = function()
    {
		//println( "POOPING" );
	}

	// Will "Clear" the current floor
    static FloorClear = function()
	{
		for( var i = 0; i < array_length( _floors ); ++i )
		{	
			if ( _floors[i][0] == room )
			{
				_floors[i][1] = true;
				
				//println( "Floor Cleared [" + string( room_get_name( _floors[i][0] ) ) + "]" );
				return _floors[i][1];
			}
		}
		
		OnFloorClear();
	}

	static FloorIsCleared = function()
	{
		for( var i = 0; i < array_length( _floors ); ++i )
		{	
			if ( _floors[i][0] == room && _floors[i][1] )
			{				
				//println( "Floor Cleared [" + string( room_get_name( _floors[i][0] ) ) + "]" );
				return true;
			}
		}
	}
	
    static OnClear = function()
    {
		//global.displaynotif = true;
	}

    static Clear = function()
	{
        if ( !_done )
		{
			_done = true;
			//OnUnlock();
		}
		
		return _done;
	}

	static IsCleared = function()
	{
	    return _done;
	}
};