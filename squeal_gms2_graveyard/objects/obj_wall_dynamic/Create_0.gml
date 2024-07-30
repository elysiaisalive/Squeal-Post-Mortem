event_inherited();

hp				= 200;
hp_max			= 200;

hitcount			= 0;

shadow_depth		= 1.5;
draw_simpleshadow	= false;

setWallHeight( 62 );

Solid_SetFlags( BLOCK_ALL );

on_proj_hit = function()
{
	effects_generic_spark( proj_hit_id );
	return true;
};
on_object_hit = function()
{
	effects_generic_itemhit( object_hit_id, random_range( 2, 3 ) );
	
	object_hit_id.gun_spd *= 0.50;
	object_hit_id.bounce();
	playsound_at( snd_impact_wall, object_hit_id.x, object_hit_id.y );
};