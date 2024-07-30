if ( check )
{ 
    draw_set_color( c_blue );
}
else
{
    draw_set_color( c_red );
};
draw_rectangle( bbox_left, bbox_top, bbox_right, bbox_bottom, true );
draw_set_color( c_white );

// for( var i = 0; i < array_length( nodes ); ++i ) {
//     draw_line( x, y, nodes[i].x, nodes[i].y );
// }

draw_text( x, y, string( ent_name ) );
draw_text( x + string_width( ent_name ), y, string( audioCurrentVolume ) );
draw_text( x, y + 16, "Gain : " + string( audio_sound_get_gain( ambience ) ) );