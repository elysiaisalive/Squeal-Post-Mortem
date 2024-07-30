event_inherited();

setWallHeight( 30 );
Solid_SetFlags( BLOCK_MOVEMENT );

on_break = function( xx, yy, dir  )
{
    height = 1;
    depth = z - height;
    
	var impact_snd = choose
	(
		snd_break_glass,
		snd_break_glass1,
		snd_break_glass2,
		snd_break_glass3,
		snd_break_glass4
	);

	if ( hp > 0 )
	{
		hp = 0;
		
		playsound_at( impact_snd, xx, yy );
		effects_debris_windowglass( xx, yy, dir );
	};
	
	image_index = 1;
};

on_proj_hit = function()
{
    on_break( proj_hit_id.x, proj_hit_id.y, proj_hit_id.direction );
	return true;
};
on_object_hit = function()
{
    on_break( object_hit_id.x, object_hit_id.y, object_hit_id.direction );
	return true;
};
on_melee_hit = function( xx, yy, dir )
{
    on_break( xx, yy, dir );
	return true;
};