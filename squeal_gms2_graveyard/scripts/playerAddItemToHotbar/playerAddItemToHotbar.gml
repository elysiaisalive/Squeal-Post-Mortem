/// @desc Adds an item to a characters hotbar with an optionally specified slot.
/// @param {struct} item 
/// @param {int} ?slot
function playerAddItemToHotbar( item, _slot ) {
    if ( !is_instanceof( item, cItem ) ) {
        return;
    }
    
    if ( _slot > array_length( self.hotbar ) ) {
        return;
    }
    
    for( var i = 0; i < array_length( self.hotbar ); ++i ) {
        if ( !is_undefined( _slot ) 
        && is_undefined( self.hotbar[i] ) ) {
            self.hotbar[_slot] = item;
            break;
        }
        else if ( is_undefined( self.hotbar[i] ) ) {
            self.hotbar[i] = item;
            break;
        }
    }
    
    return;
}