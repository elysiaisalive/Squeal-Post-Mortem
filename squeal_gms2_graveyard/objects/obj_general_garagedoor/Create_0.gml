event_inherited();

ceiling_height = 63;
//doorspeed = 1;

setPropHeight( ceiling_height );


Solid_SetFlags( BLOCK_PROJECTILE | BLOCK_MOVEMENT | BLOCK_VISION | BLOCK_OBJECTS );

image_speed		= 0;

shadow_depth	= 1;
open = false;


SaveState = function( buf = global.checkpoint )
{
	buffer_write( buf, buffer_u8, open );
};
LoadState = function( buf = global.checkpoint )
{
	open = buffer_read( buf, buffer_u8 );
};

TriggerEvent = function()
{
	open = true;
};

on_proj_hit = function()
{
	effects_impact_metalspark( proj_hit_id );
	return true;
};