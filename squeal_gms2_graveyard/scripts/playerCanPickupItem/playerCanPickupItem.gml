/// @param {struct} item
/// @returns {bool}
function playerCanPickupItem( item ) {
    var _result = true;
    
    if ( item.isStackable
    && self.inventory.GetItemAmount( item.itemName ) > 0 ) {
            _result = true;
    }
    else if ( self.inventory.GetOccupiedSlotsCount() >= self.inventory.GetInventorySize() ) {
        _result = false;
    }
    
    return _result;
}