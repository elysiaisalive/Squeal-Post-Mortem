/// @desc The save-game profile class. Contains all persistent info for any single save game, upgrades, inventory, game state etc.
function cGameProfile() class {
    playerName = "";
    
    defaultFileName = "/profile.data";
    
    // The game profile seed is set once a save is created.
    profileSeed = 1337;
    difficulty = difficultyNormal()
    .Save();
    
    chapter = -1;
    chapterLabel = "";
    
    statistics = new cPlayerStats();
    
    /* 
        Stuff to be saved :
            player stats (km walked, dmg taken etc...)
            player inventory
            difficulty
            chapter #
    */
    static SetPlayerName = function( _name = "newProfile" ) {
        playerName = _name;
        
        return self;
    }
    static SetSeed = function( _seed = -1 ) {
        // Randomizing the current game seed so we can save it for this profile.
        randomize();
        
        if ( _seed != -1 ) {
            profileSeed = _seed;
        }
        else {
            profileSeed = random_get_seed();
        }
        random_set_seed( profileSeed );
        
        return self;
    }
    
    static SetDifficulty = function( _difficulty ) {
        difficulty = _difficulty;
        return self;
    }
    
    static GetSeed = function() {
        return profileSeed;
    }
    
    static Serialize = function( slot ) {
        var _profilePath = PROFILE_PATH + $"/{global.currentProfile}";
        
        if ( !is_undefined( slot ) ) {
            _profilePath = PROFILE_PATH + $"/{slot}";
        }
        
        if ( directory_exists( _profilePath ) ) {
            var _fileName = _profilePath + defaultFileName;
            var _tempSaveBuffer = buffer_create( 1, buffer_grow, 1 );
            
            buffer_seek( _tempSaveBuffer, buffer_seek_start, 0 );
            
            try {
                #region Data to serialize
                // Saving the seed to the head of the file
                buffer_write( _tempSaveBuffer, buffer_u32, profileSeed );
            
                var _encodedStats = SnapToJSON( statistics );
                
                buffer_write( _tempSaveBuffer, buffer_string, _encodedStats );
                
                #endregion
                // Compress the buffer before saving it.
                var _compressedBuffer = buffer_compress( _tempSaveBuffer, 0, buffer_tell( _tempSaveBuffer ) );
                
                // Save the buffer to the current profile folder.
                buffer_save( _compressedBuffer, _fileName );
                
                // Free buffers from memory
                buffer_delete( _compressedBuffer );
                buffer_delete( _tempSaveBuffer );
                
                global.current_save = _fileName;
                
    	        eventhandler_publish( "ev_savedprogress" );
                print( $"Save Progress success in slot {slot}" );
            }
            catch(e) {
                print( $"Error saving progress in slot {slot}" );
            }
        }
        else {
            directory_create( PROFILE_PATH + $"/{slot}" );
        }
        
        return self;
    }
    static Deserialize = function( slot ) {
        var _profilePath = PROFILE_PATH + ( slot ?? $"/{global.currentProfile}" );
    
        if ( directory_exists( _profilePath ) ) {
            var _fileName = _profilePath + defaultFileName;
            
            print( $"Attempting Load Progress in slot {slot}" );
            var _profileBuffer = buffer_load( _fileName );
            var _decompressedProfileBuffer = buffer_decompress( _profileBuffer );
        }
        else {
            directory_create( _profilePath );
        }
        
        buffer_seek( _decompressedProfileBuffer, buffer_seek_start, 0 );
        
        try {
            // Saving the seed to the head of the file
            profileSeed = buffer_read( _decompressedProfileBuffer, buffer_string );
            
    	    eventhandler_publish( "ev_loadprogress" );
            print( $"Load Progress success in slot {slot}" );
        }
        catch(e) {
            print( $"Error loading progress in slot {slot}" );
        }
        
        buffer_delete( _profileBuffer );
        buffer_delete( _decompressedProfileBuffer );
        
        return self;
    }
    
    return self;
}
/* 
    Save slot screen -> Pick slot ( 1 - 3 slots )
    profile/ game manager creates a new instance of cGameProfile in slot ( 0 )
    gameProfile methods are invoked as options are updated/modified.
    when player clicks -> ( play ) a save profile is created.
    
    Game Profile statistics are updated / saved when a player saves their progress at a save station.
*/