function cHotbar() class {
    maxItems = 4;
    items = array_create( maxItems, undefined );
    
    static Serialize = function() {
        var _serializedItems = SnapToJSON( items );
        
        return _serializedItems;
    }
    static Deserialize = function( encodedString ) {
        var _deserializedItems = SnapFromJSON( encodedString );
        
        return _deserializedItems;
    }
    static AssignToSlot = function( itemName, _slot = 0 ) {
        var _hotbarSize = array_length( items ) - 1;
        
        if ( _hotbarSize < maxItems ) {
            if ( !SlotIsAssigned( _slot ) ) {
                items[_slot] = itemName;
                print( items );
                return;
            }
        }
    }
    static SlotIsAssigned = function( index ) {
        var _hotbarSize = array_length( items );
        
        _result = false;
        
        if ( index > _hotbarSize ) {
            show_error( $"Desired index is out of Hotbar range.", true );
        }
        
        if ( !is_undefined( items[index] ) ) {
            _result = true;
        }
        
        return _result;
    }    
    static ClearSlot = function( index ) {
        var _hotbarSize = array_length( items );
        
        if ( index > _hotbarSize ) {
            show_error( $"Desired index is out of Hotbar range.", true );
        }
        
        if ( !is_undefined( items[index] ) ) {
            items[index] = undefined;
        }
        
        return;
    }
    static GetSlot = function( index ) {
        var _hotbarSize = array_length( items );
        var _result = undefined;
        
        if ( index > _hotbarSize ) {
            show_error( $"Desired index is out of Hotbar range.", true );
        }
        if ( !is_undefined( items[index] ) ) {
            _result = items[index];
        }
        
        return _result;
    }
    static RemoveItem = function( itemName ) {
        var _indexToRemove = -1;
        var _hotbarSize = array_length( items );

        for( var i = 0; i < _hotbarSize; ++i ) {
            if ( items[i] == itemName ) {
                _indexToRemove = i;
                break;
            }
        }
        
        if ( _indexToRemove == -1 ) {
            return;
        }
        
        items[_indexToRemove] = undefined;
    }
}