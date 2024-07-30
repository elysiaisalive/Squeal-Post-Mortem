draw_set_alpha( alpha );
draw_set_font( fnt_test );
draw_set_color( c_white );
draw_circle_color( hitx, hity, 2, c_green, c_green, false );
draw_text_transformed( x, y, string( valstring ), scale, scale, 0 );
draw_set_alpha( 1 );