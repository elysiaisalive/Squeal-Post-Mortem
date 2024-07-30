function collision_explosion( object_to_explode, radius ) {
	var char	= instance_nearest( x, y, object_to_explode );
	var list	= ds_list_create();
	var rad	    = collision_circle_list( x, y, radius, char, false, false, list, false );
	var result	= false;
	var _id		= [];
	
	if ( rad ) {
		for ( var i = 0; i < rad; i++ ) {
			var inst = list[| i];

			array_push( _id, inst );
				
			result = true;
		};
	};

	ds_list_destroy( list );
	
	return[result, _id];
}