function bulb_set_ambientlight_colour( colour = #ffce70, amount = 1 ) {
	global.amblight_colour = merge_color( global.amblight_colour, colour, amount );
}