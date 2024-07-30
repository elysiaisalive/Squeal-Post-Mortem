var _level = global.level.lvl;

if ( _level.IsLevelComplete() )
{
	active = true;
	color = c_lime;
}
	
if ( active && place_meeting( x, y, obj_player ) )
{				
	obj_control.screen_alpha = 1;
	global.room_clean = true;
	global.exit_room = exit_room;

	change_room( _level._floors[0][0] );
}