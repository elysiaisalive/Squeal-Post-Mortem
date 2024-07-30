function hud_derby()
{
	var scale = 1;
	
	bob = 4;
	var c_gum = (make_color_rgb (238, 105, 127))
	//var c_gum = merge_color(c_gum1, merge_color(c_white, c_gum1, abs(sin(gradmove))), abs(sin(gradmove)))
	var x1 = (camera_get_view_width(CURRENT_VIEW) + 250) * scale
	var y1 = (camera_get_view_height(CURRENT_VIEW) + 250) * scale
	var x2 = (camera_get_view_width(CURRENT_VIEW) / x1 - 250) * scale
	var y2 = (camera_get_view_height(CURRENT_VIEW) / y1 - 250) * scale
	
	#region Ammo
	draw_sprite_ext(
		sprDerbyGum, 
		0, 
		(camera_get_view_width(CURRENT_VIEW) / 11) * scale,
		(camera_get_view_height(CURRENT_VIEW) - 44) * scale, 
		scale,
		scale, 
		0,
		c_white, 1
		)
	draw_sprite_ext(
		sprDerbyGum, 
		1, 
		(camera_get_view_width(CURRENT_VIEW) - 32) * scale, 
		(camera_get_view_height(CURRENT_VIEW) / 9) * scale, 
		scale, 
		scale,
		0,
		c_white,
		1
		)
	draw_set_font(fntDerby)
	draw_set_valign(fa_middle)
	draw_set_halign(fa_center)
	if obj_player.currentWeapon.ammo > 0 {
		draw_set_color(c_gum)
	    draw_text_transformed(
			(camera_get_view_width(CURRENT_VIEW) / 11 + 1) * scale, 
			(camera_get_view_height(CURRENT_VIEW) - 38 + 1) * scale,
			string(obj_player.currentWeapon.ammo), 
			scale, 
			scale,
			-0 + 8
			)
	    draw_set_color(c_white)
	    draw_text_transformed(
			(camera_get_view_width(CURRENT_VIEW) / 11) * scale, 
			(camera_get_view_height(CURRENT_VIEW) - 38) * scale, 
			string(obj_player.currentWeapon.ammo),
			scale, 
			scale,
			0 + 5
			)
	} else {
	    draw_sprite_ext(
			sprDerbyNoAmmoSkull, 
			0, 
			(camera_get_view_width(CURRENT_VIEW) / 11 + 1) * scale,
			(camera_get_view_height(CURRENT_VIEW) - 38 + 1) * scale, 
			scale,
			scale,
			-0 + 8, 
			c_gum,
			1
			)
	    draw_sprite_ext(
			sprDerbyNoAmmoSkull, 
			0, 
			(camera_get_view_width(CURRENT_VIEW) / 11) * scale, 
			(camera_get_view_height(CURRENT_VIEW) - 38) * scale, 
			scale, 
			scale,
			0 + 5,
			c_white, 
			1
			)
	}
	#endregion
	#region Derby Meter + Health
	draw_sprite_ext(
		sprDerbyMeter, 
		derby_special,
		(camera_get_view_width(CURRENT_VIEW) / 14) * scale, 
		(camera_get_view_height(CURRENT_VIEW) - 195) * scale,
		scale, 
		scale,
		0,
		c_white,
		1
		)
	draw_sprite_ext(
		sprDerbyRoxy, 
		derby_health, 
		(camera_get_view_width(CURRENT_VIEW) / 12) * scale, 
		(camera_get_view_height(CURRENT_VIEW) - 230) * scale,
		scale, 
		scale,
		0,
		c_white,
		1
		)
	#endregion
	#region Combo
	draw_sprite_ext(
		sprDerby_ScoreSkull, 
		derby_scoreanim,
		(camera_get_view_width(CURRENT_VIEW) - 32 + 1) * scale,
		(camera_get_view_height(CURRENT_VIEW) - 232 + 1) * scale,
		scale, 
		scale,
		0, 
		c_gum,
		1
		)
	draw_sprite_ext(
		sprDerby_ScoreSkull, 
		derby_scoreanim,
		(camera_get_view_width(CURRENT_VIEW) - 32) * scale, 
		(camera_get_view_height(CURRENT_VIEW) - 232) * scale,
		scale, 
		scale,
		0,
		c_white, 
		1
		)
	draw_sprite_ext(
		sprDerby_ScoreSkull_Bow,
		0, 
		(camera_get_view_width(CURRENT_VIEW) - 32) * scale, 
		(camera_get_view_height(CURRENT_VIEW) - 232)* scale,
		scale, 
		scale, 
		0, 
		c_white, 
		1
		)
	#endregion
	#region Combo Text
	if global.score.combo > 1 {
		draw_text_transformed_color(
			(camera_get_view_width(CURRENT_VIEW) - 52 + 1) * scale, 
			(camera_get_view_height(CURRENT_VIEW) - 212 + 1) * scale,
			string(global.score.combo),
			scale / 1.5,
			scale / 1.5,
			12 + -0,
			c_gum,
			c_gum,
			c_gum,
			c_gum,
			1
		)
		draw_text_transformed_color(
			(camera_get_view_width(CURRENT_VIEW) - 52) * scale, 
			(camera_get_view_height(CURRENT_VIEW) - 212) * scale,
			string(global.score.combo),
			scale / 1.5,
			scale / 1.5,
			12 + 0,
			c_white,
			c_white,
			c_white,
			c_white,
			1
		)
		var combo_time_x = global.score.combo_time / global.combo_time_max * 45;
		var combo_time_y = 5;
		draw_roundrect_color(
			(camera_get_view_width(CURRENT_VIEW) - 48 + 1) * scale, 
			(camera_get_view_height(CURRENT_VIEW) - 196 + 1) * scale,			
			combo_time_x + (camera_get_view_width(CURRENT_VIEW) - 48 + 1) * scale, 
			combo_time_y + (camera_get_view_height(CURRENT_VIEW) - 196 + 1) * scale,
			c_gum,
			c_gum,
			false
		)
		draw_roundrect_color(
			(camera_get_view_width(CURRENT_VIEW) - 48) * scale, 
			(camera_get_view_height(CURRENT_VIEW) - 196) * scale,			
			combo_time_x + (camera_get_view_width(CURRENT_VIEW) - 48) * scale, 
			combo_time_y + (camera_get_view_height(CURRENT_VIEW) - 196) * scale,
			c_white,
			c_white,
			false
		)
		draw_text_transformed_color(
			(camera_get_view_width(CURRENT_VIEW) - 38 + 1) * scale, 
			(camera_get_view_height(CURRENT_VIEW) - 206 + 1) * scale,
			"X",
			scale / 2,
			scale / 2,
			12 + 0,
			c_gum,
			c_gum,
			c_gum,
			c_gum,
			1
		)
		draw_text_transformed_color(
			(camera_get_view_width(CURRENT_VIEW) - 38) * scale, 
			(camera_get_view_height(CURRENT_VIEW) - 206) * scale,
			"X",
			scale / 2,
			scale / 2,
			12 + -0,
			c_white,
			c_white,
			c_white,
			c_white,
			1
		)
	}
		draw_set_font(fntDebug)
		draw_text_transformed_color(
			(camera_get_view_width(CURRENT_VIEW) - 38) * scale,
			(camera_get_view_height(CURRENT_VIEW) - 186) * scale,
			"Modifier" + " : " + string(ds_queue_head(ScoreQueue)),
			scale / 2,
			scale / 2,
			0,
			c_white,
			c_white,
			c_white,
			c_white,
			1
		)
		draw_set_font(fntDerby)
	#endregion
	#region Score Text
		draw_set_halign(fa_center)
		draw_text_transformed_color(
			(camera_get_view_width(CURRENT_VIEW) - 52) * scale, 
			(camera_get_view_height(CURRENT_VIEW) - 32) * scale,
			string(global.score.total_score),
			scale / 2.5,
			scale / 2.5,
			0,
			c_gum,
			c_gum,
			c_gum,
			c_gum,
			1
		)
		draw_set_halign(fa_center)
		draw_text_transformed_color(
			(camera_get_view_width(CURRENT_VIEW) - 52 + 1) * scale, 
			(camera_get_view_height(CURRENT_VIEW) - 32 + 1) * scale,
			string(global.score.total_score),
			scale / 2.5,
			scale / 2.5,
			-0,
			c_white,
			c_white,
			c_white,
			c_white,
			1
		)
		draw_text_transformed_color(
			(camera_get_view_width(CURRENT_VIEW) - 52) * scale, 
			(camera_get_view_height(CURRENT_VIEW) - 12) * scale,
			"PoInTs",
			scale / 2.4,
			scale / 2.4,
			-0,
			c_white,
			c_white,
			c_white,
			c_white,
			1
		)
	#endregion
}