resolution_manager().Update();
// modelRenderer().Tick();

if ( !is_undefined( global.camera ) ) {
    global.camera.Tick();
    
    if ( global.camera.ObjectInView( objAnimationTest ) ) {
        draw = true;
    }
    else {
        draw = false;
    }
}

switch( keyboard_lastchar ) {
    case 0 :
        resolution_manager().ChangeResMode( RES_MODE.FULLSCREEN );
        break;    
    case 1 :
        resolution_manager().ChangeResMode( RES_MODE.WINDOWED );
        break;  
    case 2 :
        resolution_manager().ChangeResMode( RES_MODE.BORDERLESS );
        break;    
    case 3 :
        global.camera.ClearFocus();
        break;    
    case 4 :
        global.camera.SetFocusPosition( 256, 192 );
        break; 
}