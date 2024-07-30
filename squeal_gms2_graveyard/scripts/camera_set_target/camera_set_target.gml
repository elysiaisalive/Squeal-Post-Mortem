/// @param {object}
function camera_set_target( target ) {
    if ( instance_exists( target ) ) {
        global.camera_target_previous = global.camera_target;
        global.camera_target = target;
    }
}