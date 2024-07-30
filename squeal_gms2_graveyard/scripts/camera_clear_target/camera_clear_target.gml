function camera_clear_target() {
    if ( instance_exists( global.camera_target ) ) {
        global.camera_target = noone;
    }
}