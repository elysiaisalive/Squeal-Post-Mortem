if ( IsColliding( user().GetController() ) ) {
    room_persistent = true;
    user().GetController().persistent = true;
}