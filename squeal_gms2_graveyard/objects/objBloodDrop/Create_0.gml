event_inherited();
sprite_index = (sprBloodDrop)
image_speed = 0
image_blend=merge_color(c_red,c_red,1)
done = false
animated = true;
if gore_spd <= 0 {
	repeat (4) {
	splat=instance_create_depth(x,y,-3,obj_gore_blood_splat)
		splat.gore_spd = random_range(3, 5)
		splat.gore_frc = random_range(0.5, 0.6)
		splat.direction = random_range(0, 360)
		splat.image_angle = (360) + splat.direction
	}
}
