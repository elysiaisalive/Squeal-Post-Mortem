if point_distance(obj_character.x, obj_character.y, x, y) < 16 * 12 {
	roof_opacity -= 0.1
	}else{
	roof_opacity += 0.1
	}
roof_opacity = clamp(roof_opacity,0, 0.7);