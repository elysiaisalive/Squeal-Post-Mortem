renderer.ambientColor = global.amblight_colour;

if ( !globalflags_is_set( GLOBALFLAGS.NOLIGHT ) ) {
	renderer.UpdateFromCamera( CURRENT_VIEW );
	renderer.DrawOnCamera( CURRENT_VIEW );
}