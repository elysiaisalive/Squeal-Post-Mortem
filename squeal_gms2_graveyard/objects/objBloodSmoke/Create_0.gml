event_inherited();
image_speed = 0
image_angle = random_range(0, 360)
advancespeed = 0.2

if gore_spd = 0 && image_index >= 4 {
	blood = instance_create_depth(x, y, -3, objBloodDrop)
	blood.gore_spd = random_range(4, 5)
	blood.gore_frc = random_range(0.4, 0.5)
}