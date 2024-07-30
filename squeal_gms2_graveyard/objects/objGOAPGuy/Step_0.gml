animationPlayer.Tick();

if ( keyboard_check_pressed( ord( "G" ) ) ) {
animationPlayer.QueueAnimation( animationLibrary.GetAnimation( "run", "movement" ) );
}

// if ( animationPlayer.AnimationIsPlaying( "walk" ) ) {
//     print( "haha yes..." );
// }

x = transform.position.x;
y = transform.position.y;
image_angle = transform.rotation;
direction = transform.rotation;

// Ping Pong animation.
// if ( image_index < image_number ) {
//     image_index += animSpeed;
// }
// else {
//     image_index -= animSpeed;
// }

if ( mouse_check_button( mb_right ) ) {
    var target_pos = new Vector3( mouse_x, mouse_y, 0 );
    
    transform.position.x = target_pos.x;
    transform.position.y = target_pos.y;
}