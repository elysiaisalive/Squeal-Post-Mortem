depth = -1;

scale					= global.settings.gfx_surfquality;
_w						= room_width;
_h						= room_height;				

// Surface Creation
surf = -1;
body_surf = -1;

GetSurf = function()
{
	if ( !surface_exists( surf ) )
	{
		surf = surface_create( _w * scale, _h * scale );
	};
	
	return surf;
};
GetBodySurf = function()
{
	if ( !surface_exists( body_surf ) )
	{
		body_surf = surface_create( _w * scale, _h * scale );
	};
	
	return body_surf;
};

SaveState = function( buf = global.checkpoint )
{
	buffer_get_surface( buf, GetSurf(), buffer_tell( buf ) );
	buffer_get_surface( buf, GetBodySurf(), buffer_tell( buf ) );
};
LoadState = function( buf = global.checkpoint )
{
	var width = surface_get_width( GetSurf() );	
	var height = surface_get_height( GetSurf() );
	
	buffer_set_surface( buf, GetSurf(), buffer_tell( buf ) );
	buffer_seek( buf, buffer_seek_relative, ( width * height ) * 4 );	
	
	buffer_set_surface( buf, GetBodySurf(), buffer_tell( buf ) );
	buffer_seek( buf, buffer_seek_relative, ( width * height ) * 4 );
};