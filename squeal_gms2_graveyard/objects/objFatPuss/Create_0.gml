event_inherited();
var puss;
sprite_index=(choose(sprPuss1,sprPuss2,sprPuss3))
image_speed=0
advancespeed = random_range(0.2, 0.3)
done = false;
animated = true;
repeat random_range(4, 8) {
puss=instance_create_depth(x,y,-1,objPussSpeck)
puss.gore_spd = random_range(4, 6)
puss.gore_frc = random_range(0.4, 0.6)
puss.direction=random_range(0, 360)
puss.image_angle=puss.direction
}