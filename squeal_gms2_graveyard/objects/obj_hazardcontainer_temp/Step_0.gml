var dist = point_distance(obj_character.x, obj_character.y, x, y) < 16 * 2 
if dist {
	crate_index += 0.5 * delta
	}else{
	crate_index -= 0.5 * delta
}
crate_index = clamp(crate_index, 0, 3)