if ( IsColliding( obj_player ) ) {
    active = true;
}

if ( active ) {
    bulb_set_ambientlight_colour( colour, ( time / 1000 ) );
}