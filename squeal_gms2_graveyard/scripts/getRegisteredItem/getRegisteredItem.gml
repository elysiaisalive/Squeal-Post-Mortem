/// @param {string} itemName
/// @returns {struct}
function getRegisteredItem( itemName ) {
    var _itemListSize = array_length( global.itemList );
    var _desiredItemName = string_lower( itemName );
    var _desiredItem = undefined;
    
    if ( _itemListSize <= 0 ) {
        _desiredItem = new cItem();
        return _desiredItem;
    }
    
    for( var i = 0; i < _itemListSize; ++i ) {
        var _currentItem = global.itemList[i];
        var _currentItemName = string_lower( _currentItem.GetName() );
        
        if ( _currentItemName == _desiredItemName ) {
            _desiredItem = _currentItem;
            break;
        }
    }
    
    if ( !_desiredItem ) {
        print( "Desired item not found, returning fallback item ..." );
        _desiredItem = new cItem();
    };
    
    return _desiredItem;
}