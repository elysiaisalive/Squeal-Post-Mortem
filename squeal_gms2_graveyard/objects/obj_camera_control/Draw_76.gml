///@desc move topdown camera
var camera = view_get_camera(0);

if ( !instance_exists( global.camera_target ) )
{
	global.camera_target = obj_gamemanager;
	// if ( valid_target )
	// {
	// 	valid_target = false;
	// 	show_message( "Camera Target Invalid!" );
	// };
	
	//exit;
};

valid_target = true;

switch ( global.camera_mode )
{
	case e_cameraMode.perspective_firstperson:
	case e_cameraMode.perspective_thirdperson:
		camera_set_view_pos( camera, 0, 0 );
		camera_set_view_size( camera, room_width, room_height );
		camera_set_view_angle( camera, 0 );
		camera_apply( camera );
		break;
	default: // Topdown Camera
		var camera_target_x = global.camera_target.transform.position.x;
		var camera_target_y = global.camera_target.transform.position.y;
		var look_factor		= 8;
		var look_dist		= point_distance( camera_target_x, camera_target_y, camera_get_view_x( camera ), camera_get_view_y( camera ) ) / look_factor;
		var range_scale_dis = 256; // mouse distance to reach maximum
		
		if ( object_is_ancestor( global.camera_target.object_index, obj_player )
		&& global.camera_target.can_zoom ) {
			#region Look Modes
			switch( global.zoom_mode ) {
				case 0 :
					if ( input_check( "key_zoom" ) ) {
						global.look_factor = 1.8;
					    range_min = 0;
					    range_max = 3.0;
					}
					else {
						global.look_factor = 1;
					}
					break;
				case 1 :
					if ( !global.zoom_on 
					&& input_check( "key_zoom" ) ) {
						global.zoom_on = true;
						global.look_factor = 1.8;
					    range_min = 0;
					    range_max = 3.0;
					}
					else if ( global.zoom_on 
					&& input_check( "key_zoom" ) ) {
						global.zoom_on = false;
						global.look_factor = 1;
					    range_min = 0.1;
					    range_max = 0.2;
					}
					break;
				case 2 :
					global.look_factor = 1.5;
					range_min = 0;
					range_max = 3.0;
					break;
				case 3 :				
					if ( input_check( "key_zoom" ) ) {
						global.look_factor = 1;
						range_min = 0.1;
						range_max = 0.2;
					}
					else {
						global.look_factor = 1.8;
						range_min = 0;
						range_max = 3.0;
					}
					break;
			};
			#endregion

			var range = global.zoom_maxdist * clamp( point_distance( global.camera_target.transform.position.x, global.camera_target.transform.position.y, global.mousex, global.mousey ) / range_scale_dis, range_min, range_max );
		
			camera_target_x += range * dcos( global.camera_target.charLookDir );
			camera_target_y -= range * dsin( global.camera_target.charLookDir );
		}

		var _pull = camera_pull;
		var _dis = point_distance( camera_x, camera_y, camera_target_x, camera_target_y );
		var _dir = point_direction( camera_x, camera_y, camera_target_x, camera_target_y );
		var _angle = point_direction( camera_x, camera_y, camera_target_x, camera_target_y );
		var _spd = _dis * _pull;
		
		if ( global.shake > 0 ) {
			global.shake = max( 0, global.shake - 1 * delta );
		}
		
		global.shake = clamp( global.shake, -32, 32 );
		
		if ( global.camera_follow ) {
			if ( global.shake_enabled ) {
				camera_x += dcos( _dir ) * _spd + random_range( -global.shake, global.shake ) * delta;
				camera_y -= dsin( _dir ) * _spd + random_range( -global.shake, global.shake ) * delta;
			
				if ( global.shake_intensity >= 1 ) {
					camera_angle += random_range( -global.shake, global.shake ) * delta;
				}
			}
			else {
				camera_x += dcos( _dir ) * _spd * delta;
				camera_y -= dsin( _dir ) * _spd * delta;
			}
			
			global.shake = clamp( global.shake, -30, 30 );
		}
		
		var dir;
		
		if ( true )
		{
			dir = point_direction(room_width / 2, room_height / 2, camera_target_x, camera_target_y) * 2;
		}
		else
		{
			dir = point_direction(room_width / 2, room_height / 2, camera_x, camera_y) * 2;
		}
		
		var dis = point_distance(room_width / 2, room_height / 2, camera_x, camera_y);
		
		if ( global.shake_enabled )
		{
			//camera_angle = ( -dsin( dir ) * dis * 0.00625 + ( random_range( -global.shake, global.shake ) / 5 ) );
		}
		else
		{
			//camera_angle = ( -dsin( dir ) * dis * 0.00625 );
		}
		
		var _width = camera_width * camera_zoomfactor;
		var _height = camera_height * camera_zoomfactor;
		var _x = camera_x - ( _width  / 2 );
		var _y = camera_y - ( _height / 2 );
		
		if ( camera_keep_inside_room ) 
		{
			camera_x = median( _width / 2, camera_x, room_width - _width / 2 );
			camera_y = median( _height / 2, camera_y, room_height - _height / 2 );
		}
		
		camera_set_view_pos( camera, _x, _y );
		camera_set_view_size( camera, _width, _height );
		
		/// UGH I CXANT DO MAHT FUCKFU  CUKF CUKFC THI S SHIT FU CK.
		var _inputRoll = user().GetUserMoveDirection();
		var _rollAngle = _inputRoll / camera_angle;
		// var _direction = point_direction( 0, 0, user().GetUserXAxis(), user().GetUserYAxis() );
		var _direction = 0;
		var _distance = point_distance( user().GetUserXAxis(), user().GetUserYAxis(), camera_target_x, camera_target_y );
		
		camera_angle = ( -dsin( _direction ) * _distance * 0.00625 );
		
		camera_width = clamp( camera_width, 480/2, camera_width_max );
		camera_height = clamp( camera_height, 270/2, camera_height_max );
		
		camera_set_view_angle( camera, camera_angle );
		camera_apply( camera );
		break;
}