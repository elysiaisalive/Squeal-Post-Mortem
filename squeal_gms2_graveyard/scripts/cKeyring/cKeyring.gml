/* 
    The Keyring class.
    The keyring class is responsible for holding ALL key-items for the User instance.
    
    The Keyring is only available in Normal Difficulties. In hardcore difficulties the keyring is ignored and they are presented as normal items.
*/
function cKeyring() class {
    keys = [];
    
    /// @param {struct|cItem} key an Item struct.
    static AddKey = function( key ) {
        array_push( keys, key );
    }
    
    #region Serialization
    static Serialize = function() {
        var _encodedItems = SnapToJSON( keys );
        
        if ( _encodedItems != -1 ) {
            return _encodedItems;
        }
    }
    #endregion
}