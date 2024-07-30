// Converts FPS to floating point decimals
function fpsToDecimal( FPS ) {
    if ( !is_real( FPS ) ) {
        show_error( $"Cannot convert a value that is not a number.", true );
    }
    
    return ( 1 / GAME_FPS ) * FPS;
}