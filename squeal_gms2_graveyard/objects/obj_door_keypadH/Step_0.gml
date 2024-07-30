event_inherited();

var radius = 16 * 2;
var dist = point_distance( x, y, obj_player.x, obj_player.y );

outline_a += alphasin;

if ( dist <= radius )
{
	player_inrad = true;
	
	if ( keyboard_check_pressed( global.interactkey ) )
	{
		instance_create_depth( x, y, -499, obj_keypad );
		obj_player.can_attack = false;
		obj_player.canMove = false;
		obj_player.canMoveMouse = false;
		obj_player.can_zoom = false;
	}
}
else
{
	player_inrad = false;
}

if ( !locked )
{
	Solid_RemoveFlag( BLOCK_MOVEMENT );
}