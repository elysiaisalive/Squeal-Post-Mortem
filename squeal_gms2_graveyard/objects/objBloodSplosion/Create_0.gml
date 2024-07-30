event_inherited();

advancespeed = 0.5
animated = true;
done = false;
depth = -1

repeat (18) {
	puss=instance_create_depth(x,y,-3,objBloodSpeck)
		puss.gore_spd = random_range(3, 6)
		puss.gore_frc = 0.5+random(0.4)
		puss.direction=random_range(0, 360)
		puss.image_angle=  (360) + puss.direction
}
repeat(16) {
	puss=instance_create_depth(x,y,-3,obj_gore_blood_splat)
		puss.gore_spd = random_range(3, 6)
		puss.gore_frc = 0.5 + random(0.4)
		puss.direction = random_range(0, 360)
		puss.image_angle = (360)+puss.direction
}