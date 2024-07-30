if instance_exists(obj_character) {
	var dist = point_distance(obj_character.x, obj_character.y, x, y) < 16 * 2
	var interactheld = keyboard_check(ord("E"))
	var interactpress = keyboard_check_pressed(ord("E"))
	if dist && interactpress {
		playsound(sndPickupWeapon)
		obj_character.currentWeapon.ammo = obj_character.currentWeapon.maxammo
	
	}
}