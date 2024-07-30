/* 
    The Map class. Used to build maps for displaying in the UI.
*/
function cMap() class {
    mapData = {};
    mapLegend = {
        wall : {
            color : c_white,
            size : 8
        },
        ground : c_gray
    };
    
    static GetMapData = function() {
        // Need to get: cINDEXmINDEXrINDEX
        // this is all so stupid idk what im doing or how i want to do this
        // Getting all room names.
        // var _mapArray = global.currentLevel.GetRooms();
        // var _mapArraySize = array_length( _mapArray );
            
        // for( var i = 0; i < _mapArraySize; ++i ) {
        //     var _roomName = room_get_name( _mapArray[i] );
        //     var _roomInfo = room_get_info( _mapArray[i], false, true, false, false, false );
        //     var _roomData = _roomInfo.instances;
            
        //     mapData[$ _roomName] = {};
        // }
        
        // var _instCount = array_length( _roomData );
        
        // for( var i = 0; i < _instCount; ++i ) {
        //     var _objectName = object_get_name( asset_get_index( _roomData[i].object_index ) );

        //     if ( object_is_ancestor( asset_get_index( _roomData[i].object_index ), obj_wall ) ) {
        //         mapData[$ _roomName][$ $"wall{i}"] = {};
        //         mapData[$ _roomName][$ $"wall{i}"][$ "object_index"] = asset_get_index( _roomData[i].object_index );
        //         mapData[$ _roomName][$ $"wall{i}"][$ "position"] = { x : _roomData[i].x, y : _roomData[i].y };
        //         mapData[$ _roomName][$ $"wall{i}"][$ "angle"] = _roomData[i].angle;
        //     }
        // }
        
        // print( $"Map Data :\n {mapData}" );
    }
    static BuildMap = function() {
        
    }
    static DrawMap = function() {
        var _mapSize = 64;
        var _position = { x : 0, y : 0 };
        
        draw_set_color( mapLegend.ground );
        draw_rectangle( _position.x, _position.y, _position.x + _mapSize, _position.y + _mapSize, false );
        draw_set_color( mapLegend.wall.color );
        for( var i = 0; i < variable_struct_names_count( mapData[$ "c1m3armoury"][$ $"wall{i}"] ); ++i ) {
            var _mapWalls = mapData[$ "c1m3armoury"][$ $"wall{i}"];
            
            draw_circle( _mapWalls[$ "position"].x, _mapWalls[$ "position"].y, 1, false );
        }
        draw_set_color( c_white );
    }
    
    return self;
}