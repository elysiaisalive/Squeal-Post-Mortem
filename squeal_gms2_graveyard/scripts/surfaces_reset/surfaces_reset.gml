function surfaces_reset( id ) {

	if ( surface_exists( id ) )
	{
		surface_free( id );
	}
}