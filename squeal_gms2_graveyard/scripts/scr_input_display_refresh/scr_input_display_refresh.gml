function scr_input_display_refresh() {

controls_list[0]	= "UP"		+ " : " +	input_key_to_name(global.inputs.key_up)
controls_list[1]	= "DOWN"	+ " : " +	input_key_to_name(global.inputs.key_down)
controls_list[2]	= "LEFT"	+ " : " +	input_key_to_name(global.inputs.key_left)
controls_list[3]	= "RIGHT"	+ " : " +	input_key_to_name(global.inputs.key_right)
controls_list[4]	= "ABILITY" + " : " +	input_key_to_name(global.specialkey)
controls_list[5]	= "ALT-FIRE"+ " : " +	input_key_to_name(global.altfirekey)
controls_list[6]	= "LOOK"	+ " : " +	input_key_to_name(global.inputs.key_zoom)
}