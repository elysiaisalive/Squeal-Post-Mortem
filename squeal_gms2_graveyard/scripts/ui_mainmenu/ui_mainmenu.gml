function create_mainmenu_button( _x, _y, _w, _h, _name, _sprite, _xpad = 0, _ypad = 0 ) : create_element_button( _x, _y, _w, _h, _name, _sprite, _xpad, _ypad ) constructor
{
	siner			= 0;
	amnt			= 0.4;
	
	color			= merge_color( #e50928, #8f0067, abs( sin( siner + 1 ) ) );
	color2			= merge_color( #66002e, #e50928, abs( sin( siner + 1 ) ) );
	color3			= merge_color( #2f0022, #66002e, abs( sin( siner + 1 ) ) );
	color4			= merge_color( #040007, #18001e, abs( sin( siner + 1 ) ) );
	
	static step = function()
	{	
		if ( mouse_check_button_pressed( mb_left ) && point_in_rectangle( mouse_x, mouse_y, x, y, x + width, y + height  ) )
		{
			InputClick();
			control.can_click = false;
			amnt = 16;
		}
		
		if ( IsHovered() )
		{
			color = #e50928;
			color2 = #e50928;
			
			amnt	= lerp( amnt, 8, 0.1 );
		}
		else
		{
			color			= merge_color( #e50928, #8f0067, abs( sin( siner + 1 ) ) );
			color2			= merge_color( #66002e, #e50928, abs( sin( siner + 1 ) ) );
			
			control.can_playsound = true;
			amnt	= lerp( 0.9, 0.1, 0.1 );
		}
		
		siner += 0.03;
	}
	
	static draw = function()
	{			
		draw_set_halign( fa_middle );
		draw_set_valign( fa_center );
		
		for( var i = 0; i < sprite_get_number( sprite ); ++i )
		{
			var _sin	= sin( siner + ( i * amnt ) );
			var _cos	= cos( siner + ( i * amnt ) );
			
			draw_sprite_ext( sprite, 0, -_sin + x, _cos + y + ( i * 32 ), 1, 1, 0, c_white, 1 );
		}
		
		draw_set_color( c_white );
		draw_set_halign( fa_middle );
		draw_set_valign( fa_center );
		draw_set_font( fnt_squeal );
		
		for( var i = 1; i <= string_length( name ); ++i )
		{
			var _sin	= sin( siner + ( i * amnt ) );
			var _cos	= cos( siner + ( i * amnt ) );
			
			draw_text_transformed_color( -_cos + x + 24 + ( 16 * i ), -_cos + y + 14, string_char_at( name, i ), 0.8, 0.8, 0 + _cos * 8, color3, color3, color4, color4, 1  );
			draw_text_transformed_color( _sin + x + 24 + ( 16 * i ), -_cos + y + 16, string_char_at( name, i ), 0.8, 0.8, 0 + _sin, color, color, color2, color2, 1  );
		}
	}
}