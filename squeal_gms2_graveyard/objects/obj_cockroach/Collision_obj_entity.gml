steppedon = true;

instance_destroy();
playsound(snd_footstep_dirt3)
instance_create_depth(x, y, -10, objCockSplat)

repeat(4) {
var inst = instance_create_depth(x, y, -10, obj_gore_generic)
inst.sprite_index = sprCock_Gore
inst.image_index = random(3)
inst.gore_spd = 1.5
inst.direction = random(360)
inst.image_angle = random(360)
}