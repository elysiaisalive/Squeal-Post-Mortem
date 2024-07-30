event_inherited();
var puss;
sprite_index=choose(sprPussSplat1,sprPussSplat2,sprPussSplat3)
image_speed=0
advancespeed = random_range(0.2, 0.5)
done = false;
animated = true;
repeat random_range(4, 12) {
puss=instance_create_depth(x,y,-10,objPussSpeck)
puss.gore_spd = random_range(6, 8)
puss.gore_frc = random_range(0.4, 0.6)
puss.direction=random_range(0, 360)
puss.image_angle=puss.direction
}
