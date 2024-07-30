if instance_exists(obj_character) {
		var dist = point_distance(obj_character.x, obj_character.y, x, y) < 16 * 2
	if dist 
		scr_draw_outline(x, y, 0, 1, image_angle, c_red, 1)
}
draw_self();
