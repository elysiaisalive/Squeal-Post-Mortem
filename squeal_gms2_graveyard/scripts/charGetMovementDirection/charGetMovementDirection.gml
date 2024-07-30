// Returns movement direction of character from game input
function charGetMovementDirection() {
	var x_move = ( input_moveright - input_moveleft );
	var y_move = ( input_movedown - input_moveup );
	
    return point_direction( 0, 0, x_move, y_move );
}