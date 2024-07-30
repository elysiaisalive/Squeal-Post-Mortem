draw_self();

if ( CanType )
{
	switch( global.typed_char )
	{
		case 1 :
			str = "1";
			break;
		case 2 :
			str = "2";
			break;
		case 3 :
			str = "3";
			break;
		case 4 :
			str = "4";
			break;
		case 5 :
			str = "5";
			break;
		case 6 :
			str = "6";
			break;
		case 7 :
			str = "7";
			break;
		case 8 :
			str = "8";
			break;
		case 9 :
			str = "9";
			break;
		case 10 :
			str = "";
			break;
		case 11 :
			str = "0";
			break;
		case 12 :
			str = "";
			break;
	}
}

//saved_string = string_insert( saved_string, str, string_length( str ) );

draw_set_halign( fa_left );
draw_set_font( fnt_keypad );

draw_text( x + 6, y - 28, string( saved_string ) );

draw_sprite( sprCursor_Alt1, image_number, mouse_x, mouse_y );