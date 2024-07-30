function goap_action(  ) constructor 
{
	action_target = 0;
	
	// Generic Action Constructor
	AC_DEFAULT =
	{
		// Are We Alive?
		precond : goap_precondition_add( "NULL", true ),
		// Are We At Full HP?
		effect : goap_effect_add( "NULL", true )
	}
} 

function goap_action_set(  ) {

}

function IsValid( bool ) {
	
	return bool;
}
