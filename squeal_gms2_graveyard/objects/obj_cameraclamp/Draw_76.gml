var xx = camera_get_view_x( CURRENT_VIEW );
var yy = camera_get_view_y( CURRENT_VIEW );

camera_set_view_pos( 
    CURRENT_VIEW, 
    clamp( xx, bbox_left, bbox_right - camera_get_view_width( CURRENT_VIEW ) - 16 ), 
    clamp( yy, bbox_top, bbox_bottom - camera_get_view_height( CURRENT_VIEW ) - 16 ) 
);