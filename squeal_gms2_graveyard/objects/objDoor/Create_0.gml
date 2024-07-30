/// @description most of this is temp.
setWallHeight( 62 );

is_vertical = false

door_angle = 0

swingspeed = 0

swinger = 0
swinger_id = noone

locked = false;

hp = 100;
inst = 0;

remember_angle=image_angle;
visual_angle=0;

hitcount = 0;
image_speed = 0;

Solid_SetFlags( BLOCK_VISION | BLOCK_PROJECTILE );

if ( locked )
{
	Solid_SetFlags( BLOCK_VISION | BLOCK_PROJECTILE | BLOCK_MOVEMENT );
}