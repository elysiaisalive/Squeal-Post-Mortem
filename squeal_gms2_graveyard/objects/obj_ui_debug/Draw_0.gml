draw_set_color( c_white );
draw_text( 32, 32, "ROOM LIST" );

for( var i = 0; i < array_length( options ); ++i )
{
	if ( selected == i )
	{
		draw_set_color( c_red );
	}
	else
	{
		draw_set_color( c_white );
	};
	
	draw_set_font( fnt_test );
	
	var scale = 0.75;
	
	draw_text_transformed( 240 + dsin( ( 12.95 * i ) * siner ), 62 + ( 10 * ( scale * i ) ), room_get_name( options[i] ), scale, scale, 0 );
}

controller.draw();