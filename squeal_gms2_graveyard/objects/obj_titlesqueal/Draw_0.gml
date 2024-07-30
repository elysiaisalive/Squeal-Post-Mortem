// Setting Volume Options
main_option[Volume_Menu][0] = "Master Volume";
main_option[Volume_Menu][1] = "Music Volume";
main_option[Volume_Menu][2] = "SFX Volume";

#region Drawing UI

// Background
switch(background) {
	default:
		draw_sprite(background, background_index, room_width / 2, room_height / 2)
		title = sprTitle
		is_animated = true;
		anim_speed = 0.09;
		offset_x = 0.5;
		title_offx = 0;
		break;
	case spr_mainmenu_background_slaughter :
		draw_sprite(background, background_index, room_width / 2, room_height / 2)
		font = fntSqueal
		title = sprTitle
		is_animated = true;
		anim_speed = 0.09;
		title_offx = 0;
		offset_x = 0.5;
		offset_y = 10;
		align = fa_center;
		break;
	case spr_mainmenu_background_control :
		draw_sprite(background, background_index, room_width / 2, room_height / 2)
		font = fnt_terminal
		title = spr_title_alt2
		is_animated = false;
		offset_x = -0.15; //0.07
		title_offx = -50;
		offset_y = 7;
		align = fa_left;
		break;
	case spr_mainmenu_background_temp :
		draw_sprite(background, background_index, room_width / 2, room_height / 2)
		title = spr_title_alt2
		is_animated = false;
		break;
	case spr_scarey :
		draw_sprite(background, background_index, room_width / 2, room_height / 2)
		title = spr_title_alt2
		is_animated = false;
		break;
}
// Drawing Title
draw_sprite_ext(title, titleindex, room_width / 2 + 110 + title_offx, room_height / 2-60, 1, 1, 0, c_white, 1)

#endregion

#region Graphics Options
// Graphics Sub Menu
main_option[Cursor_Menu][0] = "Cursor";

// Graphics Options
main_option[Graphics_Menu][0] = "Cursor Customization"

// Cursor Options
main_option[Cursor_Menu][0] = "Cursor Type";
main_option[Cursor_Menu][1] = "Cursor Style" + " " + string(obj_control.cursor_index);
main_option[Cursor_Menu][2] = "Cursor Size" + " " + string(cursor_scale);
main_option[Cursor_Menu][3] = "Cursor Animation Speed" + " " + string(cursor_animationspeed);
main_option[Cursor_Menu][4] = "Cursor Color"
main_option[Cursor_Menu][5] = "Cursor Folder"

main_option[Cursor_Custom][0] = "Cursor Type"
#endregion

#region Audio Text
if sub_option = Volume_Menu {	
	var xx = room_width  / 2 + 190;
	var yy = room_height / 2;
	var vol_x = global.settings.vol_master_volume;
	var vol_y = 4;
	draw_set_color(c_lime)
	draw_rectangle(
		xx, 
		yy,
		xx + (vol_x * 32),
		yy + (vol_y),
		false
	)
	draw_set_color(c_white)
}
#endregion

#region Drawing Customization Text
if sub_option = Cursor_Custom {
	switch(obj_control.cursor_type) {
		case CURSOR.DEFAULT:
			draw_text(room_width / 2 + (x * offset_x), (room_height / 2 + 20), "Default")
			break;	
		case CURSOR.ALT:
			draw_text(room_width / 2 + (x * offset_x), (room_height / 2 + 20), "Alternate")
			break;													
		case CURSOR.CUSTOM:
			draw_text(room_width / 2 + (x * offset_x), (room_height / 2 + 20), "Custom")
			break;
	}
}
if sub_option = Cursor_Menu
	draw_sprite_ext(
		obj_control.cursor_option[obj_control.cursor_type][obj_control.cursor_index], 
		cursor_speed + cursor_animationspeed, 
		room_width / 2 + 100, 
		room_height / 2 - 50, 
		cursor_scale, 
		cursor_scale, 
		0, 
		c_white, 
		1
		)
#endregion

#region Menu Options
var _x = room_width / 2
var _y = room_height / 2

draw_set_halign(align)
draw_set_font(font)

// This whole thing is really bad.
var xx = room_width / 2 - 40;
var yy = selecty;
var vol_x = 600;
var vol_y = 13;
draw_rectangle_color(
	xx, 
	yy,
	xx + (vol_x),
	yy + (vol_y),
	c_lime,
	c_lime,
	c_lime,
	c_lime,
	false
);

for (var select = 0; select < array_length(main_option[sub_option]); ++select) {
    draw_set_color(c_white);
    if select==selected 
	if pressed = 0 {
		draw_set_color(c_white)
	}else{ 
		draw_set_color(c_white)
	}
	
    draw_text(
		_x + (_x * offset_x), 
		_y - 8 + (select * offset_y * 2), 
		string_hash_to_newline(string(main_option[sub_option][select]))
		);
	draw_set_color(c_white)
}#endregion