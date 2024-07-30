function GetDistanceToPath( _path = currentPath, _path_x = currentPathX, _path_y = currentPathY ) {
	return point_distance( x, y, _path_x, _path_y );
};


/* 
	TODO : Find nearest path start coordinates via finding closest pos grid space if current coords are in a neg space.
*/
function CalculatePathToTarget( _target = currentTarget, _path = currentPath, _grid = obj_navgrid.nav_grid ) {
	path_set_precision( currentPath, 1 );
	path_set_closed( currentPath, true );
	
	var _target_x = round( _target.x / obj_navgrid.cell_w ) * obj_navgrid.cell_w;
	var _target_y = round( _target.y / obj_navgrid.cell_h ) * obj_navgrid.cell_h;
	var _checkpathdist = GetDistanceToPath( _path );
	
	currentPathX = x;
	currentPathY = y;
	
	if ( path_exists( _path ) ) {
		path_clear_points( _path );
	};

	var _result = mp_grid_path( _grid, _path, currentPathX, currentPathY, _target_x, _target_y, true );
	
	if ( _result ) {
		return true;
	}

	return false;
};

function CalculatePathToPoint( _coords = [x, y], _path = currentPath, _grid = obj_navgrid.nav_grid ) {
	path_set_precision( currentPath, 1 );
	path_set_closed( currentPath, true );
	
	var _target_x = round( _coords[0] / obj_navgrid.cell_w ) * obj_navgrid.cell_w;
	var _target_y = round( _coords[1] / obj_navgrid.cell_h ) * obj_navgrid.cell_h;
	var _checkpathdist = GetDistanceToPath( _path );
	
	currentPathX = x;
	currentPathY = y;
	
	if ( path_exists( _path ) )
	{
		path_clear_points( _path );
	};

	var _result = mp_grid_path( _grid, _path, currentPathX, currentPathY, _target_x, _target_y, true );
	
	if ( _result ) 
	{
		return true;
	};

	return false;
};

function MoveThroughPath( _path = currentPath, _movespd = charWalkSpd, _endfunc = -1 ) {
	var _point_x = path_get_point_x( _path, 1 );
	var _point_y = path_get_point_y( _path, 1 );
	var _path_dir = point_direction( x, y, _point_x, _point_y );
	var _dist_to_point = point_distance( x, y, _point_x, _point_y );
	var _point_count = path_get_number( _path );
	var _check_x = ( x + ( charWalkSpd * delta ) );
	var _check_y = ( y + ( charWalkSpd * delta ) );
	var _check_solid = collision_line( _point_x, _point_y, _check_x, _check_y, obj_solid, false, true );
	
	SetMask( spr_mask_path );
	
	var _current_cell = mp_grid_get_cell( obj_navgrid.nav_grid, x, y );

	// find a cell that is not blocked
	if ( _current_cell == -1 ) {
		lastGridX = x;
		lastGridY = y;
	};
	
	if ( _check_solid ) {
		if ( _point_count > 2 ) {
			var _path_points = path_get_number( _path ) - 1;
	        var _x1 = path_get_point_x( _path, _path_points );
	        var _y1 = path_get_point_y( _path, _path_points );
	        var _x2 = path_get_point_x( _path, _path_points -1 );
	        var _y2 = path_get_point_y( _path, _path_points -1 );
	        
	        if ( _check_solid & BLOCK_MOVEMENT ) {
	            path_delete_point( _path, _path_points );
	        };
		};
	};
	
	var _point_last_x = path_get_point_x( _path, _point_count - 1 );
	var _point_last_y = path_get_point_y( _path, _point_count - 1 );
	var _dist_to_last_point = point_distance( x, y, _point_last_x, _point_last_y );
	
	_dist_to_last_point = clamp( _dist_to_last_point, 0.10, 1 );
	
	
	// We have reached the end of the path.
	if ( _point_count <= 2
	&& _dist_to_last_point <= 8 ) {
		_endfunc();
		SetMask( spr_mask_default );
		path_clear_points( _path );
		return true;
	};
	
	if ( _dist_to_point <= 8 ) {
		path_delete_point( _path, 0 );
	};
	
	movementDirection = _path_dir;
	charVelocity = min( 1, abs( _dist_to_point / ( charWalkSpd * 0.20 ) ), abs( 1 / charWalkSpd ) * _movespd );
	
	charLookDir = rotate( charLookDir, movementDirection, ( 5.65 ) * delta );
	
	return false;
};