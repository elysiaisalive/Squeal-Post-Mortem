check = collision_rectangle( bbox_left, bbox_top, bbox_right, bbox_bottom, global.input_target, false, true );

if ( check
&& global.currentambience ) {
    if ( instance_exists( obj_ambientscape ) ) {
        with( obj_ambientscape ) {
            CleanupAmbience();
        }
    }
}