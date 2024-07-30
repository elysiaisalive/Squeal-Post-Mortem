if ( saveOnTouch ) {
    var collision_check = collision_rectangle( bbox_left, bbox_top, bbox_bottom, bbox_right, global.input_target, false, true );
    
    if ( collision_check
    && active
    && global.input_target ) {
        gamestate_tempsave();
        active = false;
    }
}