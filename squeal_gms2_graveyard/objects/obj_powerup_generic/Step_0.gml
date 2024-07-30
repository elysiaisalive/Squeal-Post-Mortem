siner += 2 * delta
siner2 += 0.05 * delta

if ( instance_exists( obj_player ) )
{
	dist = point_distance( obj_player.x, obj_player.y, x, y )
	interact_press = keyboard_check_direct( global.inputs.key_secondary )
}