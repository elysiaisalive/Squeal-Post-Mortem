//Animation
animate += 0.1
//If Keyboard pressed UP or DOWN, increase or decrease the rotation by 45 degrees.
    if (keyboard_check_pressed(vk_up)) or (keyboard_check_pressed(ord("W"))) or (mouse_wheel_up()) {
		if currentlevel_selected = true
			selected -= 0
		else { selected -= 1 }
    }
    else if (keyboard_check_pressed(vk_down)) or (keyboard_check_pressed(ord("S"))) or (mouse_wheel_down()) {
		if currentlevel_selected = true
			selected += 0
		else { selected += 1 }
	}
selected = clamp(selected, -1, 8)
//reel_rot = clamp(reel_rot, 0, 360)

//if reel_rot > 360 reel_rot = 0

if selected > 7 {
reel_rot = -360+reel_rot
selected = 0
}
if selected < 0 {
reel_rot = 360-reel_rot
selected = 7
}
reel_rot -= angle_difference(reel_rot, selected * 45) / (0.1 * room_speed);

//Poster Tube Movement
if poster_target!= poster_move {
	if poster_move > poster_target {
			poster_move -= 20
			reel_xpos -= 20
		} else {
			poster_move += 20
			reel_xpos += 20
	}
}
poster_y = clamp(300 + poster_move, 300, 600)

//Press
if pressed = 2 {
	persistent = true
	room_goto(current_level)
	obj_control.audio_music_fadeout = true;
	change = true
}
if pressed = -1 {
	persistent = false
	room_goto(rm_mainmenu)
	change = false
}

//Currently Selected Level Info
switch(selected) {
    case level_names.level_pigstay: 
        current_level=rm_squeal_f1
        level_song = ("- Song1")
        current_silouhuette = sprLevelTransition1
		current_silouhuettetiny = sprPigStaySmall
        level_titlestring=("PIGSTAY")
        level_descstring=("These swines wont evict themselves, \nturn this motel into your own personal Abattoir.")
        moon_col=make_colour_rgb(242, 151, 208);
        bg_col1=make_colour_rgb(209, 70, 70);
        bg_col2=make_colour_rgb(242, 151, 208);
        break;
    case level_names.level_stitches: 
        current_level=rm_test_f1
        current_silouhuette=sprLevelTransition2
		current_silouhuettetiny = sprPigStaySmall
        level_titlestring=("STITCHES")
        level_descstring=("Burning through fat like there's no tomorrow!")
        moon_col=make_colour_rgb(242, 151, 208);
        bg_col1=make_colour_rgb(0, 255, 76);
        bg_col2=make_colour_rgb(44, 100, 76);
        break;
    case level_names.level_h1n1: 
        current_level=rm_ai_test;
        current_silouhuette=sprLevelTransition2
		current_silouhuettetiny = spr_hud_joeID
        level_titlestring=("test")
        level_descstring=(FALLBACK_STRING)
        moon_col=make_colour_rgb(242, 151, 208);
        bg_col1=make_colour_rgb(0, 255, 76);
        bg_col2=make_colour_rgb(44, 100, 76);
        break;
    case level_names.level_guts: 
        current_level = 3
        break;
    case level_names.level_abbatoir: 
        current_level = 4
        break;
    case level_names.level_spree: 
        current_level = 5
        break;
    case level_names.level_gutter: 
        current_level = 6
        break;
    case level_names.level_midnight: 
        current_level = 7
		current_silouhuettetiny = sprMidnightSmall
		moon_col=make_colour_rgb(242, 151, 208);
        bg_col1=make_colour_rgb(0, 10, 124);
        bg_col2=make_colour_rgb(142, 65, 213);
        break;     
}