draw_sprite_ext( sprite_index, 0, x + 1, y + 1, 1, 1, image_angle, c_black, 0.50 );
draw_sprite_ext( sprite_index, 0, x, y, 1, 1, image_angle, image_blend, 1 );

for( var i = 0; i < path_get_number( drivepath ); ++i )
{
    var xx = path_get_point_x( drivepath, i );
    var yy = path_get_point_y( drivepath, i );

    draw_circle_color( xx, yy, 2, c_white, c_lime, false );
};

draw_text( x, y + 40, shot_timer.GetTime() );