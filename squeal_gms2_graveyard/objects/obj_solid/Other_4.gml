if ( bulb_renderer_exists() ) { // temp
	if ( !HasLightMask ) {
		if ( collision_flags & BLOCK_LIGHT ) {
			print( $"Adding Occluder : {object_get_name( object_index )}" );
			occluder = new BulbStaticOccluder( obj_lightingengine.renderer );
			occluder.UpdatePos( x, y );

			occluder.AddEdge( bbox_left  - x, bbox_top    - y, bbox_right - x, bbox_top    - y );
			occluder.AddEdge( bbox_right - x, bbox_top    - y, bbox_right - x, bbox_bottom - y );
			occluder.AddEdge( bbox_right - x, bbox_bottom - y, bbox_left  - x, bbox_bottom - y );
			occluder.AddEdge( bbox_left  - x, bbox_bottom - y, bbox_left  - x, bbox_top    - y );
		}
	}
}