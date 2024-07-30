/// @returns {object}
function camera_get_target() {
    if ( instance_exists( global.camera_target ) ) {
        return global.camera_target;
    }
}