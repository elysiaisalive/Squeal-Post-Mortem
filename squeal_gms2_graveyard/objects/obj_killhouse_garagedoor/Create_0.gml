event_inherited();

setPropHeight( 55 );
Solid_SetFlags( BLOCK_ALL );

image_speed = 0;

shadow_depth = 4;


on_proj_hit = function()
{
	effects_impact_metalspark( proj_hit_id );
	return true;
};
on_object_hit = function()
{
	effects_generic_itemhit( object_hit_id, random_range( 2, 3 ) );
	
	object_hit_id.gun_spd *= 0.50;
	object_hit_id.bounce();
	playsound_at( snd_impact_wall, object_hit_id.x, object_hit_id.y );
};