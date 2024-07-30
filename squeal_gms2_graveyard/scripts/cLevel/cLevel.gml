/* 
    The Level Class. Levels are a collection of rooms and their state variables.
*/
function cLevel() class {
    /* 
        name <- The level name.
        state <- A collection of values that represent different aspects of a levels state, like generators being active or some other global change.
        rooms <- An array of all rooms within the level.
    */
    name = "";
    state = {};
    rooms = [];
    
    #region Set
    static SetName = function( _name ) {
        name = _name;
        return self;
    }
    static AddState = function( stateName, value ) {
        state[$ stateName] = value;
        return self;
    }
    static AddRoom = function( _room ) {
        var _roomData = {
            roomID : _room, // ID of the room
            visited : false // Boolean for save/load
        }
        
        array_push( rooms, _roomData );
        return self;
    }
    #endregion
    #region Get
    static GetName = function() {
        return name;
    }
    static GetState = function( stateName ) {
        var _state = undefined;
        
        if ( struct_exists( state, stateName ) ) {
            _state = struct_get( state, stateName );
        }
        
        return _state;
    }
    static GetRooms = function() {
        return rooms;
    }
    #endregion
    
    return self;
}