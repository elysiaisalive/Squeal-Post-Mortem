animSpd = 0.15;
image_speed = 0;
depth = -50;

animDelay = new cTimer( 60 * 4, false );
spawnDelay = new cTimer( 60 * 4, false, true );
global.input_target = noone;
global.camera_target = self.id;
obj_camera_control.camera_x = x;
obj_camera_control.camera_y = y;