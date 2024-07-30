#region Wall Collisions
var col_check = collision_solid();

if ( ( gun_spd > 1 )
&& col_check.result )
{
	for( var i = 0; i < array_length( col_check.id ); ++i )
	{
		col_check.id[i].object_hit_id = id;
	
		if ( col_check.id[i].on_object_hit()
		&& ( col_check.id[i].collision_flags & BLOCK_OBJECTS ) )
		{
			while( place_meeting( x, y, col_check.id[i] ) )
			{
				move_bounce_all( true );
				gun_spd *= 0.50;
				exit;
			};
		};
	};
};
#endregion