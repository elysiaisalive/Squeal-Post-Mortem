function scrBarrelBits(argument0, argument1) {
	repeat (24) {
	debris=instance_create_depth(x+argument0,y+argument1, -4, objDebris)
	debris.speed=6+random(2)+random(1)
	debris.friction=0.5
	debris.direction=+random_range(0, 360)
	}
	repeat (4) {
	debris=instance_create_depth(x+argument0,y+argument1, -4, objDebris)
	debris.speed=4+random(1)
	debris.friction=0.5
	debris.direction=+random_range(0, 360)
	}



}
