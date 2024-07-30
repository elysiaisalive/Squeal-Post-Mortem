event_inherited();

gpu_set_blendmode( bm_add );
draw_set_alpha( abs( sin( image_index / 2 ) ) );
draw_circle_color( x - 1, y - 1, 1.80 * image_index, c_red, c_black, false );
draw_set_alpha( 1 );
gpu_set_blendmode( bm_normal );