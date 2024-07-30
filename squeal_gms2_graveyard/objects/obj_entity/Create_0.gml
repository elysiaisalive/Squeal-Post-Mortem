event_inherited();

image_speed = 0;
z = depth;

transform.SetNewPos( x, y, z );
transform.angle = image_angle;

xscale = 1;
yscale = 1;

height = 32;
eyes = 16;

collision_flags = 0;
no_collide = false;

audio_overrides = {
	force_stereo : false
};