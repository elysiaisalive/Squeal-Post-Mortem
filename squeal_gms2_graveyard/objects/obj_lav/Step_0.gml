var dir		= 175;
var dist	= 20;

shake -= 1 * delta;
shake = clamp( shake, 0, 128 );

turret.turret_x = x + lengthdir_x( dist, dir + image_angle );
turret.turret_y = y + lengthdir_y( dist, dir + image_angle );

shot_timer.Tick();

// var offset = 96;
// var dir = turret.turret_dir;
// var bullet_x = turret.turret_x + lengthdir_x( offset, dir );
// var bullet_y = turret.turret_y + lengthdir_y( offset, dir );
// var inst = instance_create_depth( bullet_x, bullet_y, -50, obj_proj_25mm );