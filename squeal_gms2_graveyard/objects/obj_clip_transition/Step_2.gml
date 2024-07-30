var _floor = global.level.lvl;

if ( _floor.GetNextFloor() > array_length( _floor ) )
{
	active = false;
};

// If we are active, enable the teleporter
if ( active )
{
	switch( current_mode )
	{
		case MODE_NEXT :
			if ( place_meeting( x, y, obj_player ) )
			{	
				instance_destroy( obj_ai_dummy );
				target_room = _floor.GetNextFloor();
				prev_room = _floor.GetCurrentFloor();
				
				obj_control.screen_alpha = 1;
				
				while( place_meeting( x, y, obj_player ) )
				{
					obj_player.x = teleport_x;
					obj_player.y = teleport_y;
					
					obj_camera_control.camera_x = teleport_x;
					obj_camera_control.camera_y = teleport_y;
					
					obj_control.LevelCheckpoint();
				};
				
				entered = true;
				change_floor( target_room, true );
			};
			break;
		case MODE_PREV :
			if ( place_meeting( x, y, obj_player ) )
			{
				instance_destroy( obj_ai_dummy );
				target_room = _floor.GetPrevFloor();
				prev_room = _floor.GetCurrentFloor();
	
				obj_control.screen_alpha = 1;
	
				while( place_meeting( x, y, obj_player ) )
				{
					obj_player.x = teleport_x;
					obj_player.y = teleport_y;
					
					obj_camera_control.camera_x = teleport_x;
					obj_camera_control.camera_y = teleport_y;
					
					obj_control.LevelCheckpoint();
				};
				
				entered = true;
				change_floor( target_room, true );
			};
			break;
	};
};