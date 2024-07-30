global.camera = undefined;
global.camera = new cCameraOrthographic();

instance_create_depth( room_width/2, room_height/2, -50, objPrompter );

var _testAmmoBox = new c3dModel()
.SetName( "ammoBox" )
.SetModel( CACHE_PATH + "testAmmo" )
.SetRotation( -32, 0, 320 )
.SetTextureFromSprite( texAmmo );

var _testKey = new c3dModel()
.SetName( "key" )
.SetModel( CACHE_PATH + "testKey" )
.SetRotation( 30, 15, -6 )
.SetTextureFromSprite( texKey );

var _testBandage = new c3dModel()
.SetName( "key" )
.SetModel( CACHE_PATH + "testBandage" )
.SetRotation( 30, 15, 170 )
.SetTextureFromSprite( texBandage );

var cube = new c3dModel()
.SetName( "cube" )
.SetModel( CACHE_PATH + "testCube" )
.SetRotation( 30, 15, 170 );

var _revolver = new c3dModel()
.SetName( "revolver" )
.SetModel( CACHE_PATH + "revolver" )
.SetRotation( 30, 15, 170 )
.SetTextureFromSprite( texMissing );

// modelRenderer().AddModel( _revolver );

// Calling resolution change 1 step later because GameMaker does not like you. >: ()
call_later( 10, time_source_units_frames, function() {
    resolution_manager().InitWindow();
}, false );

animo_init();
animo_populate_by_tag( "Bob" );
animo_populate_by_tag( "Guy" );

print( $"Result:{global.__animoAnimationMap}" );

draw = false;