if ( global.debug ) {
    draw_set_color( active ? c_lime : c_red );
    draw_rectangle( bbox_left, bbox_top, bbox_bottom, bbox_right, true );
    draw_set_color( c_white );
}