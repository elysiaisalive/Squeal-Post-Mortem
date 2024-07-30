function scr_draw_hud(  ) {	
	var scale = window_get_width() / camera_get_view_width(CURRENT_VIEW);
	if (!instance_exists(obj_player))
	{ 
		exit
	}
	else
	{
	#region Derby
	if obj_player.char = "Derby" {
	    bob = 4;
		var c_gum = (make_color_rgb (238, 105, 127))
		//var c_gum = merge_color(c_gum1, merge_color(c_white, c_gum1, abs(sin(gradmove))), abs(sin(gradmove)))
		var x1 = (camera_get_view_width(CURRENT_VIEW) + 250) * scale
		var y1 = (camera_get_view_height(CURRENT_VIEW) + 250) * scale
		var x2 = (camera_get_view_width(CURRENT_VIEW) / x1 - 250) * scale
		var y2 = (camera_get_view_height(CURRENT_VIEW) / y1 - 250) * scale
		
		#region Filter
		draw_set_alpha(0.01) 
		{
		gpu_set_blendmode(bm_subtract)
		draw_ellipse_color(
			x1,
			y1,
			x2,
			y2,
			merge_color(c_black, c_ltgray, 0.01),
			c_ltgray,
			false
		)
		}
		draw_set_alpha(1)
		gpu_set_blendmode(bm_normal)
		#endregion
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
				-hudbob + 8
				)
	        draw_set_color(c_white)
	        draw_text_transformed(
				(camera_get_view_width(CURRENT_VIEW) / 11) * scale, 
				(camera_get_view_height(CURRENT_VIEW) - 38) * scale, 
				string(obj_player.currentWeapon.ammo),
				scale, 
				scale,
				hudbob + 5
				)
	    } else {
	        draw_sprite_ext(
				sprDerbyNoAmmoSkull, 
				0, 
				(camera_get_view_width(CURRENT_VIEW) / 11 + 1) * scale,
				(camera_get_view_height(CURRENT_VIEW) - 38 + 1) * scale, 
				scale,
				scale,
				-hudbob + 8, 
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
				hudbob + 5,
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
			hudbob,
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
			hudbob, 
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
			hudbob,
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
			hudbob, 
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
				12 + -hudbob,
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
				12 + hudbob,
				c_white,
				c_white,
				c_white,
				c_white,
				1
			)
			var combo_time_x = global.score.combo_time / 3;
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
				12 + hudbob,
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
				12 + -hudbob,
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
				hudbob,
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
				-hudbob,
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
				-hudbob,
				c_white,
				c_white,
				c_white,
				c_white,
				1
			)
		#endregion
	}
	#endregion
	#region Joe
	if (obj_player.char = "Joe")
	{
		draw_set_font(fntJoe)
		
		bob = 4;
		var c_badge = make_color_rgb(251, 255, 159)
		var c_2 = make_color_rgb(255, 0, 198)
		var c_joe = merge_color(c_2, c_badge, hudbob / 16)
		//var style = obj_character.style;
		var ammo_string = obj_player.currentWeapon.ammo
		
		obj_player.style = clamp( obj_player.style, 0, obj_player.style_max );
		
		#region Ammo Counter
		if (obj_player.currentWeapon.ammo == 0)
		{
			ammo_string = "Empty"
		}
		
		draw_set_color(c_joe)
		draw_text_transformed(
			hud_joe_ammostartposx * scale, 
			(camera_get_view_height(CURRENT_VIEW) - 36) * scale,
			ammo_string,
			scale / 2,
			scale / 2,
			-hudbob + 1
			)
		draw_set_color(c_white)
		draw_text_transformed(
			hud_joe_ammostartposx * scale, 
			(camera_get_view_height(CURRENT_VIEW) - 36) * scale,
			ammo_string,
			scale / 2,
			scale / 2,
			hudbob + 1
			)
			
		draw_sprite_ext(
			spr_hud_joe_bullets,
			0,
			hud_joe_bulletstartposx * scale,
			(camera_get_view_height(CURRENT_VIEW) - 36) * scale,
			scale,
			scale,
			0,
			c_white,
			1
		)
		#endregion		
		#region Slow Meter
		draw_sprite_ext(
			spr_hud_joe_slometer,
			0,
			(camera_get_view_width(CURRENT_VIEW) / 2) * scale,
			hud_joe_slowmeterstartposy * scale,
			scale,
			scale,
			0,
			c_white,
			image_alpha
		)
		
		draw_text_transformed(
			(camera_get_view_width(CURRENT_VIEW) / 2) * scale,
			hud_joe_slowmeterstartposy * scale,
			string(obj_player.stats.style),
			scale / 2,
			scale / 2,
			hudbob + 5
		)
		#endregion
		#region Combo
		draw_sprite_ext(
			spr_hud_joe_glasses,
			2,
			hud_joe_combo_glasses_startposx * scale,
			(camera_get_view_height(CURRENT_VIEW) - 246) * scale,
			scale,
			scale,
			-hudbob + 15,
			c_joe,
			image_alpha
		)
		draw_sprite_ext(
			spr_hud_joe_glasses,
			0,
			hud_joe_combo_glasses_startposx * scale,
			(camera_get_view_height(CURRENT_VIEW) - 246) * scale,
			scale,
			scale,
			hudbob + 15,
			c_white,
			image_alpha
		)
		draw_sprite_ext(
			spr_hud_joe_glasses,
			1,
			hud_joe_combo_glasses_startposx * scale,
			(camera_get_view_height(CURRENT_VIEW) - 246) * scale,
			scale,
			scale,
			hudbob + 15,
			c_white,
			image_alpha
		)
		
		draw_set_color(c_joe)
		draw_text_transformed(
			hud_joe_combostartposx * scale + 4,
			(camera_get_view_height(CURRENT_VIEW) - 236) * scale,
			string(global.score.combo),
			scale / 2,
			scale / 2,
			-hudbob + 5
		)
		draw_text_transformed(
			hud_joe_combo_x_startposx * scale + 4,
			(camera_get_view_height(CURRENT_VIEW) - 232) * scale,
			"X",
			scale / 2,
			scale / 2,
			0
		)
		draw_set_color(c_white)
		draw_text_transformed(
			hud_joe_combostartposx * scale,
			(camera_get_view_height(CURRENT_VIEW) - 236) * scale,
			string(global.score.combo),
			scale / 2,
			scale / 2,
			-hudbob + 5
		)
		draw_text_transformed(
			hud_joe_combo_x_startposx * scale,
			(camera_get_view_height(CURRENT_VIEW) - 232) * scale,
			"X",
			scale / 2,
			scale / 2,
			0
		)
			
		#endregion
		#region Score
		draw_text_transformed_color(
			(camera_get_view_width(CURRENT_VIEW) - 52 + 1) * scale, 
			(camera_get_view_height(CURRENT_VIEW) - 32 + 1) * scale,
			string(global.score.DisplayedScore),
			scale / 2.5,
			scale / 2.5,
			-hudbob,
			c_joe,
			c_joe,
			c_joe,
			c_joe,
			1
		)
		draw_text_transformed_color(
			(camera_get_view_width(CURRENT_VIEW) - 52) * scale, 
			(camera_get_view_height(CURRENT_VIEW) - 32) * scale,
			string(global.score.DisplayedScore),
			scale / 2.5,
			scale / 2.5,
			hudbob,
			c_white,
			c_white,
			c_white,
			c_white,
			1
		)
		#endregion
		draw_set_font(fnt_terminal)	
	}
	#endregion
	}
}