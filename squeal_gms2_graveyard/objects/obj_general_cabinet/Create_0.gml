event_inherited();
setPropHeight( 48 );

image_speed		= 0;

shadow_depth	= 1;

extend			= false;
extend_dir		= 0;
extend_range	= irandom_range( 2, 18 );

Solid_AddFlag( BLOCK_PROJECTILE );
Solid_RemoveFlag( BLOCK_VISION );

on_proj_hit = function()
{
	extend = true;
}