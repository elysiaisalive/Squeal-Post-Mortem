function get_tilematerial( fX, fY )
{
    static s_aTileLayers =
    [
        "Ground_Tile_MaterialDirt",
        "Ground_Tile_MaterialMetal",
        "Ground_Tile_MaterialTile",
        "Ground_Grass"
    ];
    
    
    for ( var i = 0; i < array_length( s_aTileLayers ); i++ )
    {
        var sTileLayer = s_aTileLayers[i];
        var pTileLayer = layer_get_id( sTileLayer );
        if !layer_exists( pTileLayer )
            continue;
        
        var pTileMap = layer_tilemap_get_id( pTileLayer );
        if !layer_tilemap_exists( pTileLayer, pTileMap )
            continue;
        
        var iTile = tilemap_get_at_pixel( pTileMap, fX, fY );
        
        if !( iTile)
            continue;
        
        return sTileLayer;
    }
}