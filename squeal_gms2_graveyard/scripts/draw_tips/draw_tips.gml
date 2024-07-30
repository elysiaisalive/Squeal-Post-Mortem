function draw_tips( tip_type = TEXT_TIP.TIP_DEFAULT, color = c_white, halign = fa_middle, valign = fa_center, offset_x = 0, offset_y = 0, _scale = 1 ) {
	
	var scale = window_get_width() / camera_get_view_width(CURRENT_VIEW);
	var _x = camera_get_view_width(CURRENT_VIEW);
	var _y = camera_get_view_height(CURRENT_VIEW);
	var tip_string = "";
	
	switch( tip_type )
	{
		case TEXT_TIP.TIP_DEFAULT :
			tip_string = "";
			break;
		case TEXT_TIP.TIP_STYLEUPGRADE :
			tip_string = "Adrenaline will permanently boost your style meter";
			break;
		case TEXT_TIP.TIP_HPUPGRADE :
			tip_string = "Pill Bottles will permanently boost your max health";
			break;
	}
	
	
	draw_set_font( fnt_terminal );
	draw_set_halign( halign );
	draw_set_valign( valign );
	
	draw_text_transformed_color( _x / 2 + ( offset_x + 0.3 ) * scale, _y / 2 + ( offset_y + 0.3 ) * scale, tip_string, _scale, _scale, 0, c_black, c_black, c_black, c_black, tip_alpha );
	
	draw_text_transformed_color( _x / 2 + ( offset_x ) * scale, _y / 2 + ( offset_y ) * scale, tip_string, _scale, _scale, 0, color, color, color, color, tip_alpha );

}