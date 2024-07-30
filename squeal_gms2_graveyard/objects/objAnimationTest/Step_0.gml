animationPlayer.Tick();
fsm.Tick();


// if ( keyboard_check_pressed( ord( "R" ) )
// && !pressingR ) {
//     animationPlayer.QueueAnimation( animationLibrary.GetAnimation( "reloadColtEnter", "combat" ) );
//     animationPlayer.QueueAnimation( animationLibrary.GetAnimation( "coltReloadHold", "combat" ) );
//     pressingR = true;
// }
// else if ( keyboard_check_released( ord( "R" ) ) ) {
//     animationPlayer.QueueAnimation( animationLibrary.GetAnimation( "reloadColtExit", "combat" ) );
//     animationPlayer.QueueAnimation( animationLibrary.GetAnimation( "coltIdle", "combat" ) );
//     pressingR = false;
// }
// if ( keyboard_check( ord( "R" ) ) ) {
// if ( mouse_check_button_pressed( mb_left ) ) {
//     animationPlayer.QueueAnimation( animationLibrary.GetAnimation( "reloadColt", "combat" ) );
//     animationPlayer.QueueAnimation( animationLibrary.GetAnimation( "coltReloadHold", "combat" ) );
// }
// }

var _inputLeftRight = ( keyboard_check( ord( "D" ) ) - keyboard_check( ord( "A" ) ) );
var _inputUpDown = ( keyboard_check( ord( "S" ) ) - keyboard_check( ord( "W" ) ) );
var _inputMagnitude = point_distance( 0, 0, _inputLeftRight, _inputUpDown );

var _pitchSpeed = _inputUpDown * 2;
var _yawSpeed = _inputLeftRight * 2;
var _rollSpeed = _inputLeftRight * 2;

x += _yawSpeed;
y += _pitchSpeed;