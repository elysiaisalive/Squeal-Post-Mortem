event_inherited();
image_speed=0
if (gore_spd > 0) {
    inst = instance_create_depth(x, y, -1, objBloodTrail)
    inst.direction = random_range(0, 360)
    inst.image_angle = inst.direction - 6 + random(12)
}