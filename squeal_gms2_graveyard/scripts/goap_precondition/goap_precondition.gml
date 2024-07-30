// Cond Set
function goap_precondition_set( string, object ) {
	
}

// Cond Add
function goap_precondition_add( string, object ) {
	
	ds_map_add( preconditions, string, object );
}

// Cond Remove
function goap_precondition_remove( string ) {
	
	ds_map_delete( preconditions, string );
	
}

// Effect Add
function goap_effect_add( string, object ) {
	
	ds_map_add( effects, string, object );
}
