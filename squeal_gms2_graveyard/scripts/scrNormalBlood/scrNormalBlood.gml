function scrNormalBlood() {
	var blood;
	repeat (8) {
		blood=instance_create_depth(x, y, -3, objBloodSplat)
		blood.sprite_index = choose(sprBloodSplat, sprBloodSplat2, sprBloodSplat3)
		blood.gore_spd = random_range(3, 6)
		blood.gore_frc = random_range(0.4, 0.5)
		blood.direction = random_range(0, 360)
	}
	repeat (12) {
		blood=instance_create_depth(x, y, -3, objBloodSplat)
		blood.sprite_index = choose(sprBloodSplat4, sprBloodSplat5)
		blood.gore_spd = random_range(4, 7)
		blood.gore_frc = random_range(0.4, 0.6)
		blood.direction = random_range(0, 360)
	}
}