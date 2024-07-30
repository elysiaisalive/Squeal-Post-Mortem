var xx = room_width / 2;
var yy = room_height / 2;


draw_rectangle_color( 0, 0, 0 + room_width, 0 + room_height, background_c, background_c, background_c, background_c, false );

draw_sprite_ext( spr_, -1, xx + random_range( -global.shake, global.shake ), yy + random_range( -global.shake, global.shake ), scale, scale, 0, c_white, 1 );

draw_set_font( fnt_0 );
draw_set_halign( fa_center );
draw_set_color( c_white );

for( var i = 1; i <= string_length( caption ); ++i )
{
	var _sin	= sin( siner + ( i * 2 ) );
	
	draw_text_color( _sin + xx - 32 + ( 8 * i ), -_sin + yy + 32, string_char_at( caption, i ), text_c, text_c, text_c, text_c, text_a );
}