var divfactor	= 2;

var _x			= room_width / divfactor;
var _y			= room_height / divfactor;

target_x = (_x / 2);
target_rot = 0;
start_rot = 180;
start_x = -600;
move = 0.05;
alpha = 0;
siner = 0;
unpausing = false;

// Main, Sub Option
option[0][0] = "Resume";
option[1][0] = "Restart Level";
option[2][0] = "Restart Floor";
option[3][0] = "Options";
option[4][0] = "Quit";

option[0][1] = "Graphics";
option[1][1] = "Audio";
option[2][1] = "Controls";
option[3][1] = "";
option[4][1] = "";

controller	= new element_get_input();

debug		= new create_element_button( 52, 112, 96, 32, "DEBUG" );
debug.OnClick = function()
{
	global.room_clean = true;
	global.exit_room = rm_debug;
	global.pause = false;
	music_stop();
	sprite_delete( global.pause_png );
	room_persistent = false;	
	room_goto( rm_debug );
	//change_room( global.level.lvl._floors[0][0] );
};