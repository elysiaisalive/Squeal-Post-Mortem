if ( instance_exists( obj_player ) )
{
	obj_player.x = x + ( sprite_xoffset + 16 );
	obj_player.y = y + ( sprite_yoffset + 16 );
	
	instance_destroy();
}