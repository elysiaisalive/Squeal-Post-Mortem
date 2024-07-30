#region Input Detection
input_up = clamp(keyboard_check_pressed(ord("W")) + keyboard_check_pressed(vk_up) + mouse_wheel_up(), 0, 1)
input_left = clamp(keyboard_check_pressed(ord("A")) + keyboard_check_pressed(vk_left) + mouse_wheel_up(), 0, 1)
input_down = clamp(keyboard_check_pressed(ord("S")) + keyboard_check_pressed(vk_down) + mouse_wheel_down(), 0, 1)
input_right = clamp(keyboard_check_pressed(ord("D")) + keyboard_check_pressed(vk_right) + mouse_wheel_down(), 0, 1)
input_click = clamp(keyboard_check_pressed(vk_enter) + mouse_check_button(mb_left), 0, 1)
#endregion

#region UI Sounds
switch(background) {
	case spr_mainmenu_background_slaughter :
	select_sound = snd_ui_button_select
	hover_sound = snd_ui_button_hover
		break;
	case spr_mainmenu_background_control :
	select_sound = snd_ui_computer_select
	hover_sound = snd_ui_computer_hover
		break;
}
#endregion

#region Selections
if input_down
	if pressed = 1 {
		playsound(hover_sound, false);
		selected += 0
	}else{
		selected ++
		playsound(hover_sound, false);
	}

if input_up
	if pressed = 1 {
		playsound(hover_sound, false);
		selected -= 0
	}else{
		selected --
		playsound(hover_sound, false);
	}
#endregion

#region Volume Sliders
if sub_option = Volume_Menu && pressed = 1 && selected = 0 {

	if keyboard_check(input_left)
		global.settings.vol_master_volume -= 0.05
		
	if keyboard_check(input_right)
		global.settings.vol_master_volume += 0.05
}
if sub_option = Volume_Menu && pressed = 1 && selected = 1 {

	if keyboard_check(input_left)
		global.settings.music_volume -= 0.05
		
	if keyboard_check(input_right)
		global.settings.music_volume += 0.05
}
if sub_option = Volume_Menu && pressed = 1 && selected = 2 {

	if keyboard_check(input_left)
		global.settings.vol_sfx_volume -= 0.05
		
	if keyboard_check(input_right)
		global.settings.vol_sfx_volume += 0.05
}

// Volume Clamps
global.settings.vol_master_volume = clamp(global.settings.vol_master_volume, 0, 1)
global.settings.music_volume = clamp(global.settings.music_volume, 0, 1)
global.settings.vol_sfx_volume = clamp(global.settings.vol_sfx_volume, 0, 1)
#endregion

#region Graphics Options

#region Cursor Customize
if sub_option = Cursor_Custom && pressed = 1 && selected = 0 {
	if input_right {
		obj_control.cursor_type ++
	}

	if input_left {
		obj_control.cursor_type --
	}
if ( obj_control.cursor_type == CURSOR.DEFAULT )
	obj_control.cursor_index = 0
}
if sub_option = Cursor_Menu && pressed = 1 && selected = 1 {
	if input_right {
		obj_control.cursor_index --
	}

	if input_left {
		obj_control.cursor_index ++
	}
}
#endregion

#region Cursor Scale
if sub_option = Cursor_Menu && pressed = 1 && selected = 2 {

	if keyboard_check(input_left)
		cursor_scale --
		
	if keyboard_check(input_right)
		cursor_scale ++
}#endregion

#region Cursor Anim Speed
if sub_option = Cursor_Menu && pressed = 1 && selected = 3 {

	if keyboard_check(input_left)
		cursor_animationspeed -= 0.1
		
	if keyboard_check(input_right)
		cursor_animationspeed += 0.1
}#endregion

#region Cursor Folder
if sub_option = Cursor_Menu && selected = 5 {
	
	if input_click {
		var directory = environment_get_variable("APPDATA") + "\\Squeal_2_Main\\config\\Cursors\\"
		shell_do("open", directory)
		show_debug_message(directory)
	}
}#endregion

#region Cursor Clamps
obj_control.cursor_index = clamp(obj_control.cursor_index, 0, 3)
obj_control.cursor_type = clamp(obj_control.cursor_type, 0, 2)
cursor_scale = clamp(cursor_scale, 0, 8)
cursor_speed += cursor_animationspeed
cursor_animationspeed = clamp(cursor_animationspeed, 0, 4)
#endregion
#endregion

#region Menu Selection
if selected >= array_length(main_option[sub_option])
  selected = 0
if selected < 0
  selected = array_length(main_option[sub_option]) - 1
#endregion

#region Cursor Selection
if cursor_selected >= array_length(obj_control.cursor_option[obj_control.cursor_type][obj_control.cursor_index])
	cursor_selected = 0
if cursor_selected < 0
	cursor_selected = array_length(obj_control.cursor_option[obj_control.cursor_type][obj_control.cursor_index]) - 1
#endregion

background_index += anim_speed

switch(sub_option) {
	case Quit_Menu :
		switch(selected)
			{
				case 0:
					if keyboard_check_direct(ord("Y"))
						game_end();
					if keyboard_check_direct(ord("N")) {
						playsound(select_sound, false);
						sub_option = Main_Menu
					}
						break;
			}
}

if keyboard_check_direct(ord("1")) {
	background = spr_mainmenu_background_slaughter
}
if keyboard_check_direct(ord("Z")) {
	room_goto(rm_controls)
}
if keyboard_check_direct(ord("2")) {
	background = spr_mainmenu_background_control
}
	
//var musicvol = global.settings.music_volume * global.settings.vol_master_volume
var target_pitch = 0.80;
var target_pitch2 = 1;

//var target_vol = 1
//var volume = 0;
//volume = lerp(volume, target_vol, 0.1)
if (!global.music_playing)
{
	music_play(music_cpu_theme, true)
	global.music_playing = true;
}
if (sub_option = Quit_Menu)
{
	global.music_pitch = lerp(global.music_pitch, target_pitch, 0.05)
}
else
{
	global.music_pitch = lerp(global.music_pitch, target_pitch2, 0.1)
}

switch(selected) {
	case 0 :
		selecty = option_0
		break;
	case 1 :
		selecty = option_1
		break;
	case 2 :
		selecty = option_2
		break;
	case 3 :
		selecty = option_3
		break;
	case 4 :
		selecty = option_4
		break;
	case 5 :
		selecty = option_5
		break;
}