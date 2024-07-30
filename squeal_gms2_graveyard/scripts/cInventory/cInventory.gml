/// @self {cInventory|object}
function cInventory( _rows = 5, _columns = 2 ) class {
    rows = _rows;
    columns = _columns;
    itemGrid = [[]];
    hotbar = -1;
    eventBus = new cEventHandler();
    
    Init();

    static Init = function( _rows = rows, _cols = columns ) {
        for( var row = 0; row < _rows; ++row ) {
            itemGrid[row] = [];
            
            for( var col = 0; col < _cols; ++col ) {
                itemGrid[row][col] = undefined;
            }
        }
        return self;
    }
    #region Serialize
    /// @desc returns a json string of the inventory
    static Serialize = function() {
        // Save Item Name, Amount and Position.
        var _saveData = {
            inventorySize : { rows, columns },
            items : []
        };
        var _serializedData = {};
        var _rowSize = array_length( itemGrid );
        var _colSize = array_length( itemGrid[1] );
        
        if ( InventoryIsEmpty() ) {
            print( $"Inventory Is Empty, Nothing to save!" );
            return;
        }
        
        for ( var row = 0; row < _rowSize; ++row ) {
            for ( var col = 0; col < _colSize; ++col ) {
                var _currentItem = itemGrid[row, col];
                var _itemName = $"{row}{col}";
                
                if ( !is_undefined( _currentItem ) ) {
                    _itemName = {
                        itemName : _currentItem.itemName,
                        itemAmount : _currentItem.stackSize,
                        itemResource : _currentItem.resourceAmount,
                        itemPosition : {
                            row : row, 
                            column : col
                        }
                    };
                    
                    array_push( _saveData.items, _itemName );
                }
            }
        }
        
        print( _saveData );
        _saveData = SnapToJSON( _saveData );
        return _saveData;
    }
    static Deserialize = function( encodedData ) {
        var _decodedInventoryData = SnapFromJSON( encodedData );
    
        if ( is_undefined( _decodedInventoryData ) ) {
            print( $"Item Data is invalid ...\n" );
            return;
        }
    
        var _inventorySize = _decodedInventoryData.inventorySize;
    
        Init( _inventorySize.rows, _inventorySize.columns );
    
        var _saveDataItemList = _decodedInventoryData.items;
    
        for ( var i = 0; i < array_length( _saveDataItemList ); ++i ) {
            var _saveDataItem = _saveDataItemList[i];
            var _saveDataItemName = _saveDataItem.itemName;
            var _saveDataAmount = _saveDataItem.itemAmount;
            var _saveDataResource = _saveDataItem.itemResource;
            var _saveDataPosition = _saveDataItem.itemPosition;
            var _registeredItem = getRegisteredItem( _saveDataItemName );
    
            if ( !is_undefined( _registeredItem ) ) {
                itemGrid[_saveDataPosition.row, _saveDataPosition.column] = _registeredItem;
                itemGrid[_saveDataPosition.row, _saveDataPosition.column].stackSize = _saveDataAmount;
                itemGrid[_saveDataPosition.row, _saveDataPosition.column].resourceAmount = _saveDataResource;
            } 
            else {
                print( $"Error: Item {_saveDataItemName} not registered.\n" );
            }
        }
    }
    #endregion
    
    static CanAddItem = function() {
        var _result = false;
        
        if ( !InventoryIsFull() ) {
            _result = true;
        }
        else {
            eventBus.Publish( "ev_inventory_is_full" );
        }
        
        return _result;
    }
    static CanFit = function( inputItem, gridPos ) {
        var _result = false;
        var _itemWidth = inputItem.sizeWidth;
        var _itemHeight = inputItem.sizeHeight;
        var _rowSize = array_length( itemGrid );
        var _colSize = array_length( itemGrid[1] );
        
        for ( var row = 0; row < _rowSize; ++row ) {
            for ( var col = 0; col < _colSize; ++col ) {
                
            }
        }
        
        return _result;
    }
    /// @param {cItem} inputItem
    /// @param {Vector2} ?gridPos
    /// @param {function} ?callback Optional callback invoked when an item is successfully added
    static AddItem = function( inputItem, gridPos, _callback = function(){} ) {
        var _successMsg = $"Add Success! {inputItem.itemName}";
        var _failureMsg = $"Add Failure. {inputItem.itemName}";
        var _stackMsg = $"Attempting Stack. {inputItem.itemName}";
        var _itemAddedSuccessfully = false;
        
        if ( !is_instanceof( inputItem, cItem ) ) {
            throw $"Cannot add:{inputItem} as it is not {cItem}";
        }
        
        var _rowSize = array_length( itemGrid );
        var _colSize = array_length( itemGrid[1] );
        
        // Adding item to empty slot.
        if ( !is_undefined( gridPos ) ) {
            var _itemAtTarget = GetItemAt( gridPos.x, gridPos.y );
            
            // If target position has no item, then we add it!
            if ( is_undefined( _itemAtTarget ) ) {
                // Add !
                itemGrid[gridPos.x, gridPos.y] = inputItem;
                _callback();
            }
            // If the target position has an item ...
            else {
                // If the item at the grid Pos can be stacked to
                if ( CanStackItem( inputItem, gridPos.x, gridPos.y ) ) {
                    // Add !
                    itemGrid[gridPos.x, gridPos.y] = AttemptStackItem( inputItem, gridPos );
                }
            }
        }
        else {
            // If the occupied slots are less than the max amount of items we can hold
            for ( var row = 0; row < _rowSize; ++row ) {
                for ( var col = 0; col < _colSize; ++col ) {
                    // If the slot has no item defined, add one to the inventory
                    if ( is_undefined( itemGrid[row, col] )
                    && !ItemExists( inputItem )
                    && !CanStackItem( inputItem, row, col ) ) {
                        itemGrid[row, col] = inputItem;
                        _callback();
                        _itemAddedSuccessfully = true;
                    }
                    // If there is no item in the slot, and one already exists, AND we can stack it...
                    else if ( !is_undefined( itemGrid[row, col] )
                    && ItemExists( inputItem )
                    && CanStackItem( inputItem, row, col ) ) {
                        var _attemptStack = AttemptStackItem( inputItem, new Vector2( row, col ) );
                        
                        // Stack!
                        if ( !is_undefined( _attemptStack ) ) {
                            itemGrid[row, col] = _attemptStack;
                            _itemAddedSuccessfully = true;
                        }
                        // Unless...
                        else {
                            // Look for new slot and add new item!
                            _itemAddedSuccessfully = false;
                        }
                    }
                    
                    if ( _itemAddedSuccessfully ) {
                        break;
                    }
                }
                if ( _itemAddedSuccessfully ) {
                    break;
                }
            }
            
            // If stacking failed, find a new slot and add the item as a new item
            if ( !_itemAddedSuccessfully ) {
                for ( var row = 0; row < _rowSize; ++row ) {
                    for ( var col = 0; col < _colSize; ++col ) {
                        if ( is_undefined(itemGrid[row, col] ) ) {
                            itemGrid[row, col] = inputItem;
                            _itemAddedSuccessfully = true;
                            break;
                        }
                    }
                    if ( _itemAddedSuccessfully ) {
                        break;
                    }
                }
            }
        }
        
        // Success and Failure prints.
        if ( _itemAddedSuccessfully ) {
            eventBus.Publish( "ev_inventory_item_add_success" );
        }
        else {
            eventBus.Publish( "ev_inventory_item_add_failure" );
        }
    }
    /// @desc This function gets the total number of a type of item from an inventory, NOT the stack size
    /// @param {string} item_name
    /// @returns {int} Returns the total amount of the specified item that exists in the inventory
    static GetItemAmount = function( item_name ) {
        var _amount = 0;
        var _rowSize = array_length( itemGrid );
        var _colSize = array_length( itemGrid[1] );
        
        for( var row = 0; row < _rowSize; ++row ) {
            for ( var col = 0; col < _colSize; ++col ) {
                // If our input name matches the item name, return the item associated.
                if ( !is_undefined( itemGrid[row, col] ) ) {
                    if ( itemGrid[row, col].itemName == string_lower( item_name ) ) {
                        ++_amount;
                    }
                }
            }
        };
        
        return _amount;
    }
    /// @desc Returns whether or not this item exists in the inventory at all.
    static ItemExists = function( item ) {
        var _result = false;
        var _rowSize = array_length( itemGrid );
        var _colSize = array_length( itemGrid[1] );
        
        for( var row = 0; row < _rowSize; ++row ) {
            for ( var col = 0; col < _colSize; ++col ) {
                if ( !is_undefined( itemGrid[row, col] ) ) {
                    // If our input matches the item name, return the FIRST item associated.
                    if ( string_lower( itemGrid[row, col].itemName ) == string_lower( item.itemName ) ) {
                        _result = true;
                        break;
                    }
                }
            }
            if ( _result ) {
                break;
            }
        }
        
        return _result;
    }
    /// @param {string} item_name
    /// @returns {struct} item  Returns the struct of the specified item
    static GetItem = function( item_name ) {
        var _desired_item = -1;
        var _rowSize = array_length( itemGrid );
        var _colSize = array_length( itemGrid[1] );
        
        for( var row = 0; row < _rowSize; ++row ) {
            for ( var col = 0; col < _colSize; ++col ) {
                if ( !is_undefined( itemGrid[row, col] ) ) {
                    // If our input name matches the item name, return the FIRST item associated.
                    if ( string_lower( itemGrid[row, col].itemName ) == string_lower( item_name ) ) {
                        _desired_item = itemGrid[row, col];
                        break;
                    }
                }
            }
        };
        
        return _desired_item;
    }    
    /// @param {int} row
    /// @param {int} col
    /// @returns {struct} item  Returns the struct of the specified item
    static GetItemAt = function( row, col ) {
        var _desired_item = undefined;
        
        if ( !is_undefined( itemGrid[row, col] ) ) {
            _desired_item = itemGrid[row, col];
        }
        
        return _desired_item;
    }
    /// @param {string} item_name
    /// @returns {int} item  Returns the stack of all instances of the specified item
    static GetItemStack = function( item_name ) {
        var _total_stack = 0;
        var _rowSize = array_length( itemGrid );
        var _colSize = array_length( itemGrid[1] );
        var _occupied_count = 0;
        
        for( var row = 0; row < _rowSize; ++row ) {
            for ( var col = 0; col < _colSize; ++col ) {
                if ( !is_undefined( itemGrid[row, col] ) ) {
                    if ( string_lower( itemGrid[row, col].itemName ) == string_lower( item_name ) ) {
                        _total_stack += itemGrid[row, col].stackSize;
                    }
                }
            }
        };
        
        return _total_stack;
    }
    /// @param {int} row
    /// @param {int} col
    /// @returns {bool}
    static CanPlaceItem = function( row, col ) {
        var _result = false;
        
        if ( is_undefined( itemGrid[row, col] ) ) { 
            _result = true;
        }
        
        return _result;
    }  
    /// @param {cItem} inputItem
    /// @param {Vector2} gridPos
    static AttemptStackItem = function( inputItem, gridPos = -1 ) {
        // RETURN THE STACKED ITEM
        var _stackTarget = GetItemAt( gridPos.x, gridPos.y );
        var _modifiedItem = undefined;
        
        if ( is_undefined( _stackTarget ) ) {
            show_error( $"No Item to stack", true );
            return;
        }
        
        var _spaceLeft = _stackTarget.maxStackSize - _stackTarget.stackSize;
        // If we have space left in the stack to add to it
        if ( _spaceLeft > 0 ) {
            var _amount = min( inputItem.stackSize, _spaceLeft );
            print( $"We are stacking : {_amount}" );
            
            // Add to the item's stack and update item's stack size
            itemGrid[gridPos.x, gridPos.y].stackSize += _amount;
            inputItem.stackSize -= _amount;
            
            _modifiedItem = itemGrid[gridPos.x, gridPos.y];
            
            print( $"New stack is : {_modifiedItem.stackSize}" );
            _modifiedItem.OnStackChange();
            
            return _modifiedItem;
        }
    }
    /// @param {cItem} inputItem
    /// @param {int} row
    /// @param {int} col
    /// @returns {bool}
    static CanStackItem = function( inputItem, row, col ) {
        var _result = false;
        var _item = GetItemAt( row, col );
        
        if ( !is_undefined( _item ) ) {
            if ( inputItem.isStackable 
            && _item.isStackable
            && inputItem.maxStackSize <= _item.maxStackSize
            && inputItem.itemName == _item.itemName ) {
                _result = true;
            }
        }
        
        return _result;
    }
    static ItemIsResource = function( inputItem ) {
        var _result = false;
        
        if ( !is_undefined( inputItem ) ) {
            if ( inputItem.isResource ) {
                _result = true;
            }
        }
        return _result;
    }
    static MoveItemToInventory = function( destInventory, srcGridPos, destGridPos ) {
        var _srcItem = GetItemAt( srcGridPos.x, srcGridPos.y );
        
        // If the destination inventory exists
        if ( !is_undefined( destInventory ) ) {
            var _itemAtDest = destInventory.GetItemAt( destGridPos.x, destGridPos.y );
            
            // If the destination slot is empty!
            if ( is_undefined( _itemAtDest ) ) {
                // Set the destination slot to the item!
                destInventory.itemGrid[destGridPos.x, destGridPos.y] = _srcItem;
                // Remove the source item.
                RemoveItemAt( srcGridPos );
                
                print( $"Moved {_srcItem.itemName} To : {destInventory.itemGrid}" );
            }
        }
    }
    /// @param {int} srcRow
    /// @param {int} srcCol     
    /// @param {int} destRow
    /// @param {int} destCol 
    static SwapItem = function( srcRow, srcCol, destRow, destCol ) {
        var _sourceItem = GetItemAt( srcRow, srcCol );
        var _destItem = GetItemAt( destRow, destCol );
        
        itemGrid[srcRow, srcCol] = _destItem; 
        itemGrid[destRow, destCol] = _sourceItem; 
        
        return _destItem;
    }
    static AttemptAddResource = function( srcRow, srcCol, destRow, destCol ) {
        var _sourceItem = GetItemAt( srcRow, srcCol );
        var _destItem = GetItemAt( destRow, destCol );
        var _spaceLeft = _destItem.maxResourceAmount - _destItem.resourceAmount;
        var _result = false;
        
        // If we have space left in the stack to add to it
        if ( _spaceLeft > 0
        && _destItem.ValidateResource( _sourceItem.GetName() )
        && _sourceItem != _destItem ) {
            var _amount = min( _sourceItem.stackSize, _spaceLeft );
            // Check if the item we want to add as a resource is valid.
            _destItem.AddResource( _sourceItem.GetName(), _amount );
            RemoveItem( _sourceItem.GetName(), _amount, srcRow, srcCol );
            _destItem.OnResourceChange();
            _result = true;
        }
        
        return _result;
    }
    /// @param {Vector2} gridPos
    static RemoveItemAt = function( gridPos ) {
        var _result = false;
        var _itemGridPos = GetItemAt( gridPos.x, gridPos.y );
        
        if ( !is_undefined( _itemGridPos ) ) {
            itemGrid[gridPos.x, gridPos.y] = undefined;
            _result = true;
        }
        
        return _result;
    }
    /// @param {string} item_name
    /// @param {int} ?amount
    /// @param {int} ?row
    /// @param {int} ?col
    static RemoveItem = function( item_name, _amount = 0, _row = -1, _col = -1 ) {
        var _result = false;
        
        if ( _row != -1
        && _col != -1 ) {
            if ( !is_undefined( itemGrid[_row, _col] ) ) {
                var _desiredItem = itemGrid[_row, _col];
                // If our input name matches the item name, return the item associated.
                if ( string_lower( _desiredItem.itemName ) == string_lower( item_name ) ) {
                    if ( _desiredItem.isStackable 
                    && _amount > 0 ) {
                        var _stackRemainder = _desiredItem.stackSize - _amount;
                        
                        _desiredItem.stackSize = max( _stackRemainder, 0 );
                        _desiredItem.OnStackChange();
                        
                        if ( _stackRemainder <= 0 ) {
                            itemGrid[_row, _col] = undefined;
                        }
                        
                        _result = true;
                    }
                    else {
                        itemGrid[_row, _col] = undefined; 
                        _result = true;
                    }
                }
            }
        }
        
        return _result;
    }
    /// @param {Vector2} gridPos
    /// @param {Vector2} itemPosition
    /// @param {int} ?itemDepth
    static DiscardItemAt = function( gridPos, itemPosition, itemDepth = HEIGHT.GROUND ) {
        var _canDiscard = false;
        var _desiredItem = GetItemAt( gridPos.x, gridPos.y );
        
        if ( !is_undefined( _desiredItem ) ) {
            _canDiscard = true;
        }
        
        if ( _canDiscard ) {
            var _discardedItem = instance_create_depth( itemPosition.x, itemPosition.y, itemDepth, obj_pickup );

            _discardedItem.item = _desiredItem;
            _discardedItem.sprite_index = _discardedItem.item.worldSprite ?? FALLBACK_SPRITE;
            _discardedItem.image_angle = random( 360 );
            
            // Removing the discarded item from the inventory.
            RemoveItemAt( gridPos );
        }
        else {
            show_error( $"Could not discard item ...", true );
        }
        
        return;
    }
    static OnItemAdd = function() {}; // Empty method that will be overwritten by other game objects
    static GetInventorySize = function() {
        var _rowSize = array_length( itemGrid );
        var _colSize = array_length( itemGrid[1] );
        
        return ( _rowSize * _colSize );
    };
    static GetOccupiedSlotsCount = function() {
        var _rowSize = array_length( itemGrid );
        var _colSize = array_length( itemGrid[1] );
        var _occupiedCount = 0;
        
        if ( _rowSize <= 0 
        || _colSize <= 0 ) {
            _occupiedCount = 0;
            return _occupiedCount;
        }
        
        for( var row = 0; row < _rowSize; ++row ) {
            for ( var col = 0; col < _colSize; ++col ) {
                if ( !is_undefined( itemGrid[row, col] ) ) {
                    ++_occupiedCount;
                }
            }
        }
        
        return _occupiedCount;
    }
    static InventoryIsFull = function() {
        var _occupiedSize = GetOccupiedSlotsCount();
        var _result = false;
        
        if ( _occupiedSize == GetInventorySize() ) {
            _result = true;
        }
        
        return _result;
    }    
    static InventoryIsEmpty = function() {
        var _occupiedSize = GetOccupiedSlotsCount();
        var _result = false;
        
        if ( _occupiedSize == 0 ) {
            _result = true;
        }
        
        return _result;
    }
    return self;
};