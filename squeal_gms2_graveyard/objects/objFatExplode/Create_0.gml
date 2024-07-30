event_inherited()
image_speed=0
image_angle=random_range(0, 360)
advancespeed=0.5
done=0
repeat (2) {
puss=instance_create_depth(x,y,-7,obj_gore_blood_splat)
puss.gore_spd=2
puss.gore_frc=0.5+random(0.4)
puss.direction=+random_range(0, 360)
puss.image_angle=(360)+puss.direction
}
repeat(2) {
puss=instance_create_depth(x,y,-7,obj_gore_blood_splat)
puss.gore_spd=3
puss.gore_frc=0.5+random(0.4)
puss.direction=+random_range(0, 360)
puss.image_angle=(360)+puss.direction
}

