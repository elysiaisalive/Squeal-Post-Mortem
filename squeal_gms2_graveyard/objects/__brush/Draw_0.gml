surface_set_target( __renderSurface ); {
    camera_apply( global.camera.GetCamera() );
    draw_sprite( __brushProperties.sprite, -1, mouse_x, mouse_y );
}
draw_reset();
surface_reset_target();