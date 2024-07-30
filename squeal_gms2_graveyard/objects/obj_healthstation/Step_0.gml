if instance_exists(obj_character) {
	var dist = point_distance(obj_character.x, obj_character.y, x, y) < 16
	var interactheld = keyboard_check(ord("E"))
	var interactpress = keyboard_check_pressed(ord("E"))

	if dist && interactheld && obj_character.hp < obj_character.hp_max && hp_resource > 0 {
		healing = true
		if healing {
			hp_gain_timer -= 1
			hp_gain_timer = clamp(hp_gain_timer, 0, 28)
			if hp_gain_timer = 0 {
				hp_gain_timer = 28
				playsound(snd_healthstation_charge)
				hp_resource -= 5
				obj_character.hp += 5
				hp_resource = clamp(hp_resource, 0, 100)
				}
			}
	}else{ 
		healing = false
		if dist && interactpress && hp_resource = 0 or dist && interactpress && obj_character.hp = obj_character.hp_max
			playsound(snd_healthstation_denied);
		}
}
switch (hp_resource) {
	case 125:
		image_index = 0
		break;
	case 50:
		image_index = 1
		break;
	case 25:
		image_index = 2
		break;
	case 0:
		image_index = 3
		break;
}