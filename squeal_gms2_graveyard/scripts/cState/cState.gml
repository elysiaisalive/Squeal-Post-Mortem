function cState() constructor {
	activeState = -1;
	bPaused = false;
	
	// Start runs when a state is initialized / swapped
	static Start = function(){bPaused = false;};
	// Run happens every frame of the state
	static Run = function(){};
	// Stop is what happens on the state end ( callbacks )
	static Stop = function(){bPaused = true;};
	
	static RestartState = function()
	{
		println( string( "Restarted {0}", activeState ) );
		activeState.Stop();
		activeState.Start();
	};
	
	static OnEnterState = function() {};
	static RunState = function()
	{
		if ( !bPaused )
		{
			activeState.Run();
		};
	};
	
	static ChangeState = function( _newstate ) {
		OnEnterState();
		
		if ( activeState != undefined ) {
			activeState.Stop();
			activeState = _newstate;
			activeState.Start();
		}
		else 
		{
			println( string( "state Change Unsuccessful, state {0} not initialized.", activeState ) );
			return false;
		};
	};
	
	static InitState = function( _state )
	{
		activeState = _state;
		activeState.Start();	
	};
	
	static Pause = function()
	{
		bPaused = true;
	};
	
	static Unpause = function()
	{
		bPaused = false;
	};
	
	return self;
};