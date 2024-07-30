// Surface Recreation if surface does not exist.

if ( !surface_exists( body_surf ) )
{
	body_surf = surface_create( _w * scale, _h * scale );
};
if ( !surface_exists( surf ) )
{
	surf = surface_create( _w * scale, _h * scale );
};