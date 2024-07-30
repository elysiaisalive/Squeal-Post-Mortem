event_inherited();
setPropHeight( 55 );

image_speed		= 0;

shadow_depth	= 1;

Solid_RemoveFlag( BLOCK_VISION | BLOCK_PROJECTILE | BLOCK_OBJECTS );

on_proj_hit = function()
{
	effects_impact_metalspark( proj_hit_id );
	return true;
};