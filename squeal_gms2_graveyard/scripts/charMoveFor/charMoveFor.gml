function charMoveFor( move_speed, move_direction, _time = 10 ) {
    // Dont set new time each step
    movementTimer.SetNewTime( _time );
    movementTimer.Unpause();
    
    /* 
        BUG: This doesn't work, the movement or velocity are being set to 0 every frame somewhere.
    */
    if ( movementTimer.GetTime() > 0 ) {
        global.input_enabled = false;
        canMoveMouse = false;
        
        self.movementDirection = move_direction;
        self.charVelocity = move_speed;
    }
    
    // On timer end, reenable input, pause and set timer to 0
    movementTimer.OnTimerEnd = function() {
        print( "Ending the timer" );
        global.input_enabled = true;
        canMoveMouse = true;
        movementTimer.Pause();
        movementTimer.SetNewTime( 1 );
    }
}