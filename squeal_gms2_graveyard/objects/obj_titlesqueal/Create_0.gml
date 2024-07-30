// Setting the main menu options
var filepath = string(filename_drive(APPDATA_PATH))
var programname = string("squeal2" + ".exe")
var user = string("User")
//var user = string(environment_get_variable("USERNAME"))

Option_Start = filepath + "/" + user + "/" + ">" + "start.exe"
Option_Chapters = filepath + "/" + user + "/" + "chapters" + "/" + ">"
Option_Extra = filepath + "/" + user + "/" + ">" + "xtras.reg"
Option_Options = filepath + "/" + user + "/" + ">" + "config.ini"
Option_Quit = filepath + "/" + user + "/" + ">" + "taskkill" + " " + programname

Option_Volume = filepath + "/" + user + "/" + "config.ini" + "." + "volume" + "/" + ">"
Option_Controls = filepath + "/" + user + "/" + "config.ini" + "." + "controls" + "/" + ">"
Option_Graphics = filepath + "/" + user + "/" + "config.ini" + "." + "graphics" + "/" + ">"

Option_YN = "Are you sure?" + " " + "Y" + "/" + "N"

// Temp
music_cpu_theme = choose(APPDATA_PATH + "\\Music\\MainMenu\\menu_temp.ogg", APPDATA_PATH + "\\Music\\MainMenu\\menu_xtal.ogg", APPDATA_PATH + "\\Music\\MainMenu\\menu_loli.ogg")

if (!global.music_playing)
{
	music_play(music_cpu_theme, true)
	global.music_playing = true;
}
//
main_option[Main_Menu][0] = Option_Start;
main_option[Main_Menu][1] = Option_Chapters;
main_option[Main_Menu][2] = Option_Extra;
main_option[Main_Menu][3] = Option_Options;
main_option[Main_Menu][4] = Option_Quit;

// Setting the Sub Menu options
main_option[Sub_Menu][0] = Option_Volume;
main_option[Sub_Menu][1] = Option_Controls;
main_option[Sub_Menu][2] = Option_Graphics;

// Quit Menu
main_option[Quit_Menu][0] = Option_YN;
// Cursor
cursor_selected = 0;
cursor_speed = 0;
cursor_custom = noone;

// Offsets for spacing menu options
offset_x = 0.5;
offset_y = 8;

// Bounding boxes
bound_x = 120;
bound_y = 30;

// Currently selected menu option (default=0)
selected = 0;
sub_option = 0;

// Inputs
input_up = 0;
input_left = 0;
input_down = 0;
input_right = 0;

// BG Anim
background = choose(
	spr_mainmenu_background_slaughter, 
	spr_mainmenu_background_control,
	spr_mainmenu_background_asire,
	spr_mainmenu_background_temp
	);
title = 0;
background_index = 0;
is_animated = false;
anim_speed = 0.09;
font = fntSqueal
align = fa_left;
titleanim = 0.05;
titleindex = 0;
title_offx = 0;
selecty = 0;
select_sound = noone;
hover_sound = noone;
// Pressed
pressed = 0;

//Direction.
dir = 0;

// Music
musicpitch = 1;

// Rectangle Pos
option_0 = 128;
option_1 = 142;
option_2 = 156;
option_3 = 170;
option_4 = 184;
option_5 = 198;