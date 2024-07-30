siner += 0.10 * delta;

arrow_xmove = x + lengthdir_x( sin( siner ) * arrow_intensity, image_angle );
arrow_ymove = y + lengthdir_y( sin( siner ) * arrow_intensity, image_angle );

if ( !instance_exists( obj_ai_dummy ) )
{
	active = true;
};

if ( entered )
{
	image_index = 1;
};