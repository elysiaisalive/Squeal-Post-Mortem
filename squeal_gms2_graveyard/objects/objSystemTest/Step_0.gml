resolution_manager().Update();
gui().Tick();
// mapTest.Tick();
// lockPick.Tick();

musicPlayer.Tick();

// switch( keyboard_lastchar ) {
//     case 0 :
//         resolution_manager().ChangeResMode( RES_MODE.FULLSCREEN );
//         break;    
//     case 1 :
//         resolution_manager().ChangeResMode( RES_MODE.WINDOWED );
//         break;  
//     case 2 :
//         resolution_manager().ChangeResMode( RES_MODE.BORDERLESS );
//         break;    
//     case 3 :
//         global.camera.ClearFocus();
//         break;    
//     case 4 :
//         global.camera.SetFocusPositionAligned( mouse_x, mouse_y, 0, 0 );
//         break;

// }

if ( !is_undefined( global.camera ) ) {
    global.camera.Tick();
}