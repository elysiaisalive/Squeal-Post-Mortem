function reset_surface( surface_obj, surface ) {

	with( surface_obj )
	{
		surfaces_reset( surface );
	}
	
	if ( !surface_exists( surface ) )
	{
		println( "Surface" + " [" + string( surface ) + "] " + " " + "Reset" );
	}
}