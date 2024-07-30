function scr_splashdraw(){

var xx = room_width / 2
var yy = room_height / 2
var scale = 1

if pc_on {
	draw_set_alpha(splash_alpha) {
		// Iris Artists Splash
		if splash_screen = 0 {
			draw_sprite_ext(spr_splashiris, -1, xx, yy, scale, scale, 0, c_white, splash_alpha)	
			}
	
		// D_P_Y
		if splash_screen = 1 {
			draw_sprite_ext(spr_splashdpy, -1, xx, yy, scale, scale, 0, c_white, splash_alpha)	
			}

		// Dennaton
		if splash_screen = 2 {
			draw_sprite_ext(spr_dennaton, animate, xx - 45, yy - 100, scale, scale, 0, c_white, splash_alpha)
			}
		}
	draw_set_alpha(1)
	}
}