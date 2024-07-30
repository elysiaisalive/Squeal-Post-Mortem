/* 
    The spawner group class is used for spawning groups of randomly placed items that are positioned based with the obj_spawn_marker object.
    Spawns are seeded based on the current game profile seed.
*/
function cSpawnerGroup() class {
    label = "";
    objects = {};
    active = true;
    
    static Activate = function() {
        active = false;
    }
    
    static Deactivate = function() {
        active = false;
    }
    
    static SetLabel = function( newLabel ) {
        label = newLabel;
        
        return self;
    }
    
    static Spawn = function() {
        var _markerArray = [];
        
        // Getting the amount of markers and pushing their ID's to the Spawn Array.
        with( obj_spawn_marker ) {
            array_push( _markerArray, [id, false] );
        }
        
        if ( array_length( _markerArray ) <= 0 ) {
            return;
        }
        
        var _objectCount = struct_get_names( objects );
        
        // Iterate through the object data struct
        for( var i = 0; i < array_length( _objectCount ); ++i ) {
            var _objectData = struct_get( objects, _objectCount[i] );
            
            if ( is_undefined( _objectData ) ) {
                print( $"==========\nSpawn Error! Object Data is undefined?\n==========" );
                return;
            }
            
            /* 
                BUG:
                    Sometimes items do not spawn if they have a 100% chance.
            */
            
            var _randomPercentage = _objectData.spawnWeight;
            var _randomRange = random_range( 0, 1 );
        
            if ( _randomRange <= _randomPercentage ) {
                // Iterate through all markers and spawn items
                for( var j = 0; j < array_length( _markerArray ); ++j ) {
                    var _randomMarkerIndex = random_range( 0, array_length( _markerArray ) - 1 );
                    var _markerPosition = { x : _markerArray[_randomMarkerIndex][0].x, y : _markerArray[_randomMarkerIndex][0].y };
                    var _markerLabel = _markerArray[_randomMarkerIndex][0].label;
                    var _currentMarker = _markerArray[_randomMarkerIndex];
                    
                    // If our marker label matches and it hasn't been used to spawn an item yet.
                    if ( self.label == _markerLabel 
                    && !_currentMarker[1] ) {
                        if ( _objectData.currentSpawns < _objectData.maxSpawns ) {
                            var _instance = instance_create_depth( _markerPosition.x, _markerPosition.y, -HEIGHT.TORSO, _objectData.assetIndex );
                            _instance.image_angle = random_range( -360, 360 );
    
                            ++_objectData.currentSpawns;
                            _currentMarker[1] = true;
                        }
                    }
                }
            }
        }
    }
    
    /// @param {asset} object
    /// @param {number} spawnWeight
    static AddObject = function( object, spawnWeight, _maxSpawns = 1 ) {
        var _objectName = object_get_name( object );
        var _objectAssetIndex = asset_get_index( _objectName );
        
        /* 
            assetIndex      : The asset index that will be used to spawn the object
            spawnWeight     : The chance that this item will spawn at it's possible spawns.
            currentSpawns   : The current amount of times this object has spawned
            maxSpawns       : The maximum amount of this item that can spawn.
        */
        objects[$ _objectName] = {};
        objects[$ _objectName].assetIndex = _objectAssetIndex;
        objects[$ _objectName].spawnWeight = spawnWeight;
        objects[$ _objectName].currentSpawns = 0;
        objects[$ _objectName].hasSpawned = false;
        objects[$ _objectName].maxSpawns = _maxSpawns;
        
        return self;
    }
}