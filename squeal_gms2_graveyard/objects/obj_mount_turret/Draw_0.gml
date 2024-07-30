// Gun
draw_sprite_ext( sprite_index, image_index, x + 1, y + 1, image_xscale, image_yscale, image_angle, c_black, 0.5 );
draw_sprite_ext( sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, c_white, 1 );

// Ammo Box
draw_sprite_ext( sprite_index, 1, x + 1, y + 1, image_xscale, image_yscale, ammo_angle, c_black, 0.5 );
draw_sprite_ext( sprite_index, 1, x, y, image_xscale, image_yscale, ammo_angle, c_white, 1 );

// Overheated Barrel
var c_heat = merge_color( c_red, c_orange, 0.2 );

draw_sprite_ext( sprite_index, 2, x, y, image_xscale, image_yscale, image_angle, c_heat, barrel_heat );
