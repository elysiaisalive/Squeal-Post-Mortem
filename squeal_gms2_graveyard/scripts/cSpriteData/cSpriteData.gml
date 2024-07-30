/* 
   The sprite data class. Contains a key stored as a string and an animation speed.
*/
function cSpriteData() class {
    animKey = "";
    animSpeed = 0;
    
    static SetAnimation = function( animationKey ) {
        if ( !is_string( animationKey ) ) {
            show_error( $"Key is not valid string", true );
        }
        
        animKey = animationKey;
        return self;
    }  
    static SetAnimSpeed = function( animSpd ) {
        if ( !is_real( animSpd ) ) {
            show_error( $"Animation Speed is not valid number", true );
        }
        
        animSpeed = animSpd;
        return self;
    }
    
    return self;
}