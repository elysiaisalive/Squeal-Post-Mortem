draw_sprite_ext( sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, c_mortar, alpha );

var _dir	= point_direction( mortar_startx, mortar_starty, mortar_targetx, mortar_targety );
var _dis	= point_distance( x, mortar_starty, x, mortar_targety );
var scale	= _dis * 0.02;

scale = clamp( scale, 0.8, 4 );

draw_sprite_ext( spr_mortar_shell, image_index, mortar_startx + ( _dis * 0.15 ), mortar_starty + ( _dis * 0.15 ), scale, scale, _dir, c_black, mortaralpha );

draw_sprite_ext( spr_mortar_shell, image_index, mortar_startx, mortar_starty, scale, scale, _dir, image_blend, 1 );