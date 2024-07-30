function scr_uidraw() {
// Drawing Saving ... Text
if saving {
		var scale = 2
		var xx = 12
		var yy = window_get_height() - (32 * 2) - 12
		draw_set_color(c_white)
		draw_set_halign(fa_left)
		draw_set_valign(fa_bottom)
		draw_set_font(fnt_squeal)
		draw_sprite_ext(spr_savingpig_base, anim, xx, yy, abs( sin( scale ) ), scale, 0, c_white, text_timer)
		draw_set_font(fntDebug)
	}	
}