// Cock vars
cock_animate = 0.2
cock_scale = random_range(0.5, 0.8)
steppedon = 0;
steppedon = false;

_state = choose(0, 1)
scaredof = obj_character;
target_wall = noone;
idle_timer = 0
turnvolc = 0
turnacc = 0.3
turnspeed = 15
spd = 0
spd_max = 2
dir = random(360)
acc = 0.4;
dec = 0.3;
alertdir = 0;

path = path_add();
grid = mp_grid_create(0, 0, room_width / 16, room_height / 16, 16, 16)

image_blend = merge_colour(c_white, c_lime, random(0.5))

image_xscale = cock_scale
image_yscale = cock_scale

RoachMove = function() {
    x += lengthdir_x(spd * delta, dir)
    y += lengthdir_y(spd * delta, dir)
	collision_enable();
    if !place_free(x, y) {
        x = xprevious
        y = yprevious
        dir = random(360)
    }
    collision_disable();
}