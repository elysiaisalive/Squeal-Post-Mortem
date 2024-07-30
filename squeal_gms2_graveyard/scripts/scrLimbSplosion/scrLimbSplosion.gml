function scrLimbSplosion(argument0, argument1) {
	repeat (14) {
	blood=instance_create_depth(x, y, -7, objExplosionGore)
	blood.sprite_index=sprFatBodyGore
	blood.image_index=random(7)
	blood.gore_spd = random_range(8, 12)
	blood.gore_frc = random_range(0.5, 0.7)
	blood.direction=+random_range(0, 360)
	blood.image_angle=blood.direction+random_range(0, 360)
	}
	{
	blood=instance_create_depth(x, y, -10, objExplosionGore)
	blood.sprite_index=sprFatHeadGore
	blood.image_index=random(2)
	blood.gore_spd = random_range(8, 12)
	blood.gore_frc = random_range(0.5, 0.7)
	blood.direction=+random_range(0, 360)
	blood.image_angle=blood.direction+random_range(0, 360)
	}
	{
	blood=instance_create_depth(x, y, -10, objExplosionGore)
	blood.sprite_index=sprFatHeadGore
	blood.image_index=random(2)
	blood.gore_spd = random_range(8, 12)
	blood.gore_frc = random_range(0.5, 0.7)
	blood.direction=+random_range(0, 360)
	blood.image_angle=blood.direction+random_range(0, 360)
	}
	repeat (3) {
	blood=instance_create_depth(x, y, -10, objExplosionGore)
	blood.sprite_index=sprFatHeadGore2
	blood.image_index=random(3)
	blood.gore_spd = random_range(8, 12)
	blood.gore_frc = random_range(0.5, 0.7)
	blood.direction=+random_range(0, 360)
	blood.image_angle=blood.direction+random_range(0, 360)
	}
	repeat (2) {
	blood=instance_create_depth(x, y, -10, objExplosionGore)
	blood.sprite_index=sprFatArms
	blood.image_index=random(3)
	blood.gore_spd = random_range(8, 12)
	blood.gore_frc = random_range(0.5, 0.7)
	blood.direction=+random_range(0, 360)
	blood.image_angle=blood.direction+random_range(0, 360)
	}
	repeat (2) {
	blood=instance_create_depth(x, y, -10, objExplosionGore)
	blood.sprite_index=sprFatLegs
	blood.image_index=random(3)
	blood.gore_spd = random_range(8, 12)
	blood.gore_frc = random_range(0.5, 0.7)
	blood.direction=+random_range(0, 360)
	blood.image_angle=blood.direction+random_range(0, 360)
	}
}
