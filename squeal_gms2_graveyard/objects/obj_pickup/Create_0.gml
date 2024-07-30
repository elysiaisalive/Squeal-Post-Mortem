event_inherited();

flags.SetFlags( OBJFLAGS.DYNAMIC );

height = 8;
Solid_ClearFlags();

item = new cItem();
userDistance = 0;
maxDistance = 8;
animSpeed = 0.1;
rotSpeed = random_range( -2, 2 );
rot = 0;
animIndex = 0;

glintPosition = new Vector2( x, y );

GetItem = function() {
    if ( !is_undefined( item ) ) {
        return item;
    }
}