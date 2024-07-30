//var _target = instance_exists( obj_player );
//var dist = point_distance( x, y, obj_player.x, obj_player.y );
//var dir = point_direction( x, y, obj_player.x, obj_player.y );
//var col_check = collision_line( x, y, obj_player.x, obj_player.y, obj_wall, false, true );

anim_spd += 0.15 * delta;

//if ( !col_check && ( dist <= 16 * 4 ) )
//{
//	if ( cam_lightindex < 5 )
//	{
//		cam_lightindex = lerp( cam_lightindex, floor( 5 ), 0.05 );
//	}
//	cam_movetype = cam_movetype + clamp( angle_difference( dir - 180, cam_movetype ), -0.50, 0.50 ) * delta;
//}
//else
//if ( col_check || ( dist > 16 * 4 ) )
//{
//	cam_lightindex = lerp( cam_lightindex, 0, 0.10 );
//	cam_dir -= 0.01;
//	cam_movetype = cam_movetype + clamp( angle_difference( image_angle + sin( cam_dir ) * 24, cam_movetype ), -0.20, 0.20 ) * delta;
//}