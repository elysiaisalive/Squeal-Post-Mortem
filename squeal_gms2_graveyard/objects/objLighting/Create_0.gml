renderer = new BulbRenderer( c_white, BULB_MODE.HARD_BM_MAX, false );
occlusionSurface = surface_create( room_width, room_height );

CreateOccluderWithMask = function( maskTexture ) {
    var _instance = instance_create_depth( 0, 0, -15, objOccluder );
    _instance.occluder = new BulbStaticOccluder( objLighting.renderer );
    _instance.occluder.SetSprite( maskTexture, image_index );
    _instance.occluder.x = 0;
    _instance.occluder.y = 0;
    
    return _instance;
}
BakeOccluders = function() {
    print( $"Starting Occlusion Bake" );
    
    // test
    var _percentage = 0;
    var i = 0;
    var amount = 64;
    
    repeat( amount ) {
        print( $"Propogating Occluders... {_percentage}%" );
        var _inst = instance_create_depth( random( room_width ), random( room_height ), -15, objWall );
        _inst.image_angle = random( 360 ) % 90;
        ++i;
        _percentage = ( i / amount ) * 100;
    }
    //
    
    if ( surface_exists( occlusionSurface ) ) {
        surface_set_target( occlusionSurface );
        draw_set_colour( c_black );

        with( objWall ) {
            draw_sprite_ext( sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, c_black, 1 );
        }
        surface_reset_target();
        
        var _surfaceScale = new Vector2( surface_get_width( occlusionSurface ), surface_get_height( occlusionSurface ) );
        var _surfaceSprite = sprite_create_from_surface( occlusionSurface, 0, 0, _surfaceScale.x, _surfaceScale.y, false, false, 0, 0 );
    
        surface_free( occlusionSurface );
        sprite_save( _surfaceSprite, 0, BULB_PATH + $"__occlusion{room_get_name( room )}.png" );
        
        var _sprite = sprite_add( BULB_PATH + $"__occlusion{room_get_name( room )}.png", 0, false, false, 0, 0 );
        
        CreateOccluderWithMask( _sprite );
        draw_set_colour( c_white );
    }
}