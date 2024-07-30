var _dir		= point_direction( 0, 0, door_offset[0], door_offset[1] );
var _dist	= point_distance( 0, 0, door_offset[0], door_offset[1] );

var door_x	= x + lengthdir_x( _dist, _dir + image_angle );
var door_y	= y + lengthdir_y( _dist, _dir + image_angle );

draw_sprite_ext( sprite_index, image_index, x + 1.5, y + 1.5, image_xscale, image_yscale, image_angle, c_black, 0.5 );
draw_sprite_ext( sprite_index, 1, x, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha );
draw_sprite_ext( door_sprite, image_index, door_x + 1.5, door_y + 1.5, image_xscale, image_yscale, door_angle + image_angle, c_black, 0.5 );
draw_sprite_ext( door_sprite, image_index, door_x, door_y, image_xscale, image_yscale, door_angle + image_angle, image_blend, image_alpha );
draw_sprite_ext( sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha );