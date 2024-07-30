event_inherited();

// var _entity = user().GetController();

// if ( !is_undefined( _entity ) ) {
// 	var _dist = point_distance( x, y, _entity.transform.position.x, _entity.transform.position.y );
// 	var _range = 16 * 3;
	
// 	if ( _dist <= _range )
// 	{
// 		door_angle -= door_openspeed;
	
// 		if ( door_angle == door_targetangle )
// 		{
// 			playsound_at( snd_car_dooropen, x, y );
// 		}
// 	}
// 	else
// 	{
// 		door_angle += door_closespeed;
	
// 		if ( door_angle == 0 )
// 		{
// 			playsound_at( snd_car_doorclose, x, y );
// 		}
// 	}
// }

door_angle = clamp( door_angle, door_targetangle, 0 );