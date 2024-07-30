draw_sprite_ext( sprite_index, bullet_index, x + bullet_life * 0.25, y + bullet_life * 0.25, 1, 1, image_angle, c_black, 0.2 );
gpu_set_blendmode( bm_add );
draw_sprite_ext( sprite_index, bullet_index, x, y, 1, 1, image_angle, merge_color( c_white, #13b96f, abs( sin( bullet_sin ) ) ), 1 * bullet_life );
gpu_set_blendmode( bm_normal );