var dist = point_distance(x, y, obj_character.x, obj_character.y) < 16 * 2
if dist {	
	whore += 0.1
	scare = max(0, scare - 1)
	image_angle = point_direction(x, y, obj_character.x, obj_character.y)
}else{
	scary = false
	if whore > 0
		whore -= 0.1
	image_angle += 1
}
var time = 30
if scare = 0 {
	scary = true;
	scare = 200
	playsound(snd_immisterrage, false)
	time = max(0, time - 1)
}
	if time = 0 {
		time = 30
		scary_alpha = max(0, scary_alpha - 0.5)
	}