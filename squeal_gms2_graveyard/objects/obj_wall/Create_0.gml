event_inherited();

impact_snd			= noone;
break_snd			= noone;

wall_hp				= 200;
wall_maxhp			= 200;

hitcount			= 0;

shadow_depth		= 1.5;
draw_simpleshadow	= false;

wall_mat			= noone;
setWallHeight( 62 );

Solid_SetFlags( BLOCK_ALL );

on_proj_hit = function() {
	effects_generic_spark( proj_hit_id );
	return true;
};
on_object_hit = function() {
	effects_generic_itemhit( object_hit_id, random_range( 2, 3 ) );
	playsound_at( snd_impact_wall, object_hit_id.x, object_hit_id.y );
	return true;
};
on_melee_hit = function( xx, yy, dir ) {
	effects_generic_itemhit( , random_range( 2, 3 ), xx, yy, dir );
	playsound_at( snd_impact_wall, xx, yy );
};

