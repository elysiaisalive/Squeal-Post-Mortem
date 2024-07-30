/// @desc Function for getting a collision and its angle and position
function collision_solid( obj = obj_solid )
{
	var list	= ds_list_create();
	var len		= instance_place_list( x, y, obj, list, false );
	var result	= false;
	var _id		= [];
	var _x		= 0;
	var _y		= 0;
	var _angle	= 0;
				
	// Check for a bullet blocking collision
	if ( len )
	{
		for ( var i = 0; i < len; i++ )
		{
			var inst = list[| i];
			
			array_push( _id, inst );
			
			result = true;
			
			_x = x;
			_y = y;
			_angle = direction;
		};
	};

	ds_list_destroy( list );
	
	return {
		result		: result, 
		id 			: _id,
		x			: _x, 
		y			: _y, 
		direction	: _angle 
	};
};