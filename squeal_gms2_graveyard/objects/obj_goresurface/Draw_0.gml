if ( surface_exists( gore ) )
{
	draw_surface_stretched( gore, 0, 0, room_width, room_height );
} 
else 
{ 
	gore = surface_create( room_width * scale, room_height * scale );
}

if ( surface_exists( body ) )
{
	draw_surface_stretched( body, 0, 0, room_width, room_height );
} 
else 
{ 
	body = surface_create( room_width * scale, room_height * scale );
}

if ( surface_exists( bullet ) )
{
	draw_surface_stretched( bullet, 0, 0, room_width, room_height );
} 
else 
{ 
	bullet = surface_create( room_width * scale, room_height * scale );
}
