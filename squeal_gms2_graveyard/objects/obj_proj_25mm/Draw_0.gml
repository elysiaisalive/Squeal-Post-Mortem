draw_sprite_ext( sprite_index, bullet.proj_index, x + bullet.life * 0.25, y + bullet.life * 0.25, 1, 1, image_angle, c_black, 0.2 );
gpu_set_blendmode( bm_add );
draw_sprite_ext( sprite_index, bullet.proj_index, x, y, lerp( 0.35, max( 4, bullet_velocity * 0.15 ), 0.50 ), 1, image_angle, merge_color( c_orange, #d51210, abs( sin( bullet_sin ) ) ), 1 * bullet.life );
gpu_set_blendmode( bm_normal );