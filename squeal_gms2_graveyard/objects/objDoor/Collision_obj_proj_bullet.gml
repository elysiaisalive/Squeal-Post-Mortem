//hp -= other.hp_damage
//hp = clamp(hp, 0, 100)

//if other.ammo_type = BULLETCAL.LOW
//	instance_destroy(other);

//if other.ammo_type = BULLETCAL.PELLET {
//	hitcount ++
//}
//if hp <= 0 && hitcount = 8 {
//	inst = instance_create_depth(x, y, -5, obj_debris_generic)
//	inst.sprite_index = spr_door_destroyed
//	inst.speed = random_range(5, 6)
//	inst.friction = random_range(0.3, 0.4)
//	inst.direction = other.direction
//	inst.image_angle = inst.direction
//	inst.image_index = 1
//	repeat(random_range(6, 12)) {
//	inst = instance_create_depth(x, y, -8, obj_debris_generic)
//	inst.sprite_index = spr_door_debris_small
//	inst.speed = random_range(4, 6)
//	inst.friction = random_range(0.2, 0.5)
//	inst.direction += other.direction + random(360)
//	inst.image_angle = inst.direction + random(360)
//	inst.image_index = random(5)
//	}
//}