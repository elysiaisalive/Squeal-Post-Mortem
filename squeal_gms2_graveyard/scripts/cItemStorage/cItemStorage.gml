function cItemStorage() class {
    storedItems = [];
    
    #region Data Serialization
    static Serialize = function() {
        // Get Item Names
        // Get Item Amounts
        // Save to Json
    }
    static Deserialize = function() {
        // Load json
        // Load item names
        // Lookup item names in global itemList
        // Create new cItem structs
        // Load daat accordingly
    }
    #endregion
    static StoreItem = function( item, _amount = -1 ) {
        if ( _amount != -1 ) {
            array_push( storedItems, item );
        }
        else {
            var _itemToStore = item;
            var _stackToStore = _itemToStore.stackSize - _amount;
            
            if ( _amount > item.maxStackSize
            || _amount > item.stackSize ) {
                array_push( storedItems, item );
                return;
            }
            
            _itemToStore.stackSize = _stackToStore;
            item.stackSize -= _amount;
            
            array_push( storedItems, item );
        }
    }
    static RetrieveItem = function( itemName, _amount = -1 ) {
        var _storedArraySize = array_length( storedItems );
        
        for( var i = 0; i < _storedArraySize; ++i ) {
            var _item = storedItems[i];
            
            if ( _item.itemName == itemName ) {
                return _item;
            }
        }
    }
}