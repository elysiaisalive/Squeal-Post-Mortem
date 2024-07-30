//Create a new occluder that the player will use to block light
occluder = new BulbStaticOccluder( obj_lightingengine.renderer );
occluder.UpdatePos( x, y );

occluder.AddEdge( bbox_left  - x, bbox_top    - y, bbox_right - x, bbox_top    - y );
occluder.AddEdge( bbox_right - x, bbox_top    - y, bbox_right - x, bbox_bottom - y );
occluder.AddEdge( bbox_right - x, bbox_bottom - y, bbox_left  - x, bbox_bottom - y );
occluder.AddEdge( bbox_left  - x, bbox_bottom - y, bbox_left  - x, bbox_top    - y );