event_inherited();
setPropHeight( 20 );
image_speed = 0;

if ( bSortDepth ) {
	call_later( 1, time_source_units_frames, function() {
		with obj_solid_furniture if ( id != other.id )
		with other
		{
			if place_meeting( x, y, other )
			&& z != ( other.z - other.height )
			{
				print( "Sorting depth!" );
				depth = other.depth - 1;
			}
		}
	}, false );
}