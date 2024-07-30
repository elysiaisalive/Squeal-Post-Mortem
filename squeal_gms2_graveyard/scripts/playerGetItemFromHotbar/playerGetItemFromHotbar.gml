/// @desc Returns an item from the hotbar
/// @param {int} slot
/// @returns {struct}
function playerGetItemFromHotbar( slot ) {
    var _desiredItem = noone;
    
    if ( slot > array_length( self.hotbar ) ) {
        return;
    }
    
    for( var i = 0; i < array_length( self.hotbar ); ++i ) {
        if ( !is_undefined( slot ) ) {
            _desiredItem = self.hotbar[slot];
            break;
        }
        else {
            _desiredItem = self.hotbar[i];
            break;
        }
    }
    
    return _desiredItem;
}