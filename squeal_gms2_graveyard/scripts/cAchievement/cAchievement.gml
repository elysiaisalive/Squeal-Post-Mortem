function cAchievement() class {
    #region Class Properties
    unlocked = false;
    icon = FALLBACK_SPRITE;
    achID = 0;
    title = "";
    description = "";
    progress = 0;
    targetProgress = 0;
    #endregion
    #region Class Methods
    static Register = function() {
        global.achievements[$ self.achID] = self;
        print( $"Registered Achievement {self.achID}" );
        return self;
    }
    static OnUnlock = function(){};
    #endregion
    #region Data Serialization
    static Serialize = function() {
        var _encodedString = SnapToJSON( {
            unlocked : unlocked,
            progress : progress
        } );
        
        return _encodedString;
    }
    static Deserialize = function( data ) {
        var _decodedData = SnapFromJSON( data );
        
        if ( !is_undefined( _decodedData ) ) {
            unlocked = data.unlocked;
            progress = data.progress;
        }
    }
    #endregion
    #region Set
    static SetIcon = function( achIcon ) {
        icon = achIcon;
        return self;
    }
    static SetID = function( ID ) {
        achID = ID;
        return self;
    }      
    static SetTitle = function( achTitle ) {
        title = achTitle;
        return self;
    }    
    static SetDesc = function( achDesc ) {
        description = achDesc;
        return self;
    }
    static SetProgressTarget = function( amount ) {
        targetProgress = amount;
        return self;
    }
    static AddProgress = function( amount ) {
        progress = min( progress + amount, targetProgress );
        
        if ( progress >= targetProgress ) {
            progress = targetProgress;
            Unlock();
        }
        return self;
    }
    static Unlock = function() {
        unlocked = true;
        OnUnlock();
        print( $"Unlocked Achievement {global.achievements[$ achID]}" );
        return self;
    }
    #endregion    
    #region Get
    static GetIcon = function() {
        return icon;
    }    
    static GetID = function() {
        return achID;
    }
    static GetTitle = function() {
        return title;
    }
    static GetDesc = function() {
        return description;
    }
    static GetProgress = function() {
        return progress;
    }
    static GetProgressTarget = function() {
        return targetProgress;
    }
    #endregion
    
    return self;
}