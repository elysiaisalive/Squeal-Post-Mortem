event_inherited();
setPropHeight( 60 );

image_speed		= 0;

shadow_depth	= 1;

on_proj_hit = function()
{
	while( place_meeting( x, y, id ) )
	{
		proj_hit_id.x -= lengthdir_x( 1, proj_hit_id.direction );
		proj_hit_id.y -= lengthdir_y( 1, proj_hit_id.direction );
	};
	
	effects_generic_spark( proj_hit_id );
	
	return true;
};