event_inherited();

// if ( instance_exists( currentTarget ) ) {
// 	draw_text( x, y, $"Current target is {currentTarget.charName}" );
// 	draw_text( x, y+20, $"sustime {suspicionTimer.GetTime()}" );
	
// 	draw_set_color( c_aqua );
// 	draw_line( x, y, currentTarget.x, currentTarget.y );
// 	draw_set_color( c_white );
// }

// draw_set_color( c_white );

// for ( var i = 0; i < path_get_number( currentPath ); i++ )
// {
// 	var _x = path_get_point_x( currentPath, i );
// 	var _y = path_get_point_y( currentPath, i );
	
// 	// Destination
// 	var _x2 = path_get_point_x( currentPath, path_get_number( currentPath ) - 1 );
// 	var _y2 = path_get_point_y( currentPath, path_get_number( currentPath ) - 1 );
	
// 	draw_set_color( c_lime );
// 	draw_circle( _x, _y, 1, false );
// 	// Destination
// 	draw_set_color( c_aqua );
// 	draw_circle( _x2, _y2, 8, false );
// };

// draw_set_color( c_red );
// draw_circle( currentPathX, currentPathY, 2.5, true );
// draw_line( currentPathX - 2, currentPathY - 2, currentPathX + 2, currentPathY + 2 );
// draw_line( currentPathX + 2, currentPathY - 2, currentPathX - 2, currentPathY + 2 );