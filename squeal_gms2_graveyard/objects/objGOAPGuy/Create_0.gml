// GOAP FSM states
enum STATES {
    IDLE,
    MOVE,
    PERFORMING
}

z = 8;

image_speed = 0;

state = STATES.IDLE;
frame = 0;
animSpeed = 1;
height = 50;

// testing
transform = {
    position : new Vector3( x, y, depth - height ),
    rotation : 0,
    scale : new Vector2( 1, 1 )
}
// Example use 
// entity.transform.position.x OR entity.transform.scale
depth = -30;

animationLibrary = new cAnimationLibrary();
animationLibrary.AddSection( "movement" );
animationLibrary.AddSection( "combat" );
animationLibrary.AddAnimation( new cAnimoData(), "walk", "movement" );
animationLibrary.AddAnimation( new cAnimoData().SetSprite( sprSharkSegments ).AddEnterCondition( function() { if ( state == STATES.IDLE ) { return false; }; } ), "run", "movement" );
animationLibrary.AddAnimation( new cAnimoData(), "shooting", "combat" );

animationPlayer = new cAnimationPlayer();
animationPlayer.QueueAnimation( animationLibrary.GetAnimation( "walk", "movement" ) );

animationTree = new cAnimationTree( animationPlayer );
animationTree.AddNode( new cNode() );

print( animationTree );