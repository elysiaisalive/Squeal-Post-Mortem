if ( !spawned )
{
	var inst	= instance_create_layer( x + sprite_xoffset + 16, y + sprite_yoffset + 16, "Ground_Entity", player );
	instance_create_depth( x, y, depth, obj_saver );
	
	spawned		= true;
	
	if ( instance_exists( player ) )
	{
		println( "Spawned" + " [" + string( object_get_name( player ) ) + "] " );
	}
}