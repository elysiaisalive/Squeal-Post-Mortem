/// @self {cGameManager|object}
/// @desc Game Manager singleton responsible for pausing, ssving and managing the game state as well as several other external things like files.
function cGameManager() class {
    Init();
    
    //profile = undefined;
    // TEMP: Creating default profile.
    profile = CreateProfile();
    
    // eventhandler_subscribe( self, "ev_player_enternewroom", function() {
    //     instance_create_depth( 0, 0, -5000, obj_camera_control );
    //     instance_create_depth( 0, 0, -5000, obj_cameraclamp );
    //     instance_create_depth( 0, 0, -500, obj_cursor );
    //     instance_create_depth( 0, 0, -500, obj_hud );
    //     instance_create_depth( 0, 0, 0, obj_surface_manager );
    // } );
    
    static Init = function() {
        print( "\n======\ninitializing game manager!\n======\n" );
        
        initGlobalVariables();
        initEnums();
    	initGameDirectories();

        lang().Init();
        
        user();
        
        // // Creating the Player's Profile based on the internal defaults.
        if ( !input_profile_exists( COMPUTER_NAME, user().GetUserPort() ) ) {
            input_profile_create( COMPUTER_NAME );
            input_profile_copy( user().GetUserPort(), INPUT_AUTO_PROFILE_FOR_KEYBOARD, user().GetUserPort(), COMPUTER_NAME );
            input_profile_set( COMPUTER_NAME, user().GetUserPort() );
        }
        
        SaveControls();
        LoadControls();
        
        mapList();
        
        // Randomizing Seed
        randomize();
    	
    	// Event handler init
    	eventhandler();
    	
        audio().Init();
    	initTextures();
    	initSFX();
    	initCharacterAnimations();
        initAchievements();//
        
        SaveAchievements( SerializeAchievements() );
        LoadAchievements( DeserializeAchievements() );
        
    	// Initializing Item and Weapon definitions
        initItems();
    }
    
    #region Configuration
    #endregion
    #region Controls
    static SaveControls = function() {
        var _configData = SerializeControls();
        var _stringBytes = string_byte_length( _configData );
        var _fileName = CONFIG_PATH + "/controls.cfg";
        var _configBuffer = buffer_create( _stringBytes, buffer_fixed, 1 );
        
        buffer_seek( _configBuffer, buffer_seek_start, 1 );
        buffer_write( _configBuffer, buffer_string, _configData );
        
        buffer_save( _configBuffer, _fileName );
        buffer_delete( _configBuffer );
            
        return self;
    }
    static LoadControls = function() {
        var _dataBuffer = DeserializeControls();
        var _userPort = user().GetUserPort();
        
        if ( buffer_get_size( _dataBuffer ) <= 0 ) {
            print( $"Loaded Buffer is empty ..." );
            return;
        }
        
        var _configData = buffer_read( _dataBuffer, buffer_string );
        
        input_profile_import( _configData, COMPUTER_NAME, _userPort );
        buffer_delete( _dataBuffer );
    }
    static SerializeControls = function() {
        var _userPort = user().GetUserPort();
        var _profileData = {};
        
        _profileData = input_profile_export( COMPUTER_NAME, _userPort, true, true );
        
        return _profileData;
    }
    static DeserializeControls = function( _fileName = CONFIG_PATH + "/controls.cfg" ) {
        var _userPort = user().GetUserPort();
        var _configBuffer = buffer_load( _fileName );
        
        return _configBuffer;
    }
    #endregion
    
    static TickBegin = function() {}
    static Tick = function() {
        user().TrackTime();
        user().Listen();
        
        // Debug room reload.
        if ( keyboard_check_pressed( vk_f1 ) ) {
            print( "Resetting Random Seed and Room." );
            randomize();
            room_restart();
        }        
        if ( keyboard_check_pressed( vk_f2 ) ) {
            print( "Leaving Room" );
            AutoSave();
            room_goto( rm_debug );
        }
        
        if ( keyboard_check_pressed( vk_f6 ) ) { 
            SaveWorldState();
        }
        if ( keyboard_check_pressed( vk_f7 ) ) {
            LoadWorldState(); 
        }
        
        if ( keyboard_check_pressed( vk_f8 ) ) {
            SaveGame(); 
            SaveProfile();
        }       
        if ( keyboard_check_pressed( vk_f9 ) ) {
            LoadGame(); 
            LoadProfile();
        }
    }
    static TickEnd = function() {}
    
    static CreateProfile = function( _config = {} ) {
        profile = new cGameProfile()
        .SetSeed( _config[$ "seed"] ?? -1 )
        // .SetDifficulty( _config[$ "difficulty"] ?? DIFFICULTY.NORMAL )
        .SetPlayerName( _config[$ "playerName"] ?? COMPUTER_NAME )
        .Serialize();
        
        return profile;
    }
    
    #region Data Serialization
    static SaveAchievements = function( _data ) {
        var _fileName = PROFILE_PATH + $"valor.dat";
        var _fileData = _data;
        var _tempBuffer = buffer_create( 0, buffer_grow, 1 );
        
        if ( !file_exists( _fileName ) ) {
            SnapBufferWriteBinary( _tempBuffer, _fileData );
            
            var _compressedBuffer = buffer_compress( _tempBuffer, 0, buffer_tell( _tempBuffer ) );
        
            buffer_save( _compressedBuffer, _fileName ); 
            buffer_delete( _compressedBuffer );
        }
        else {
            _tempBuffer = buffer_load( _fileName );
            
            var _decompressedBuffer = buffer_decompress( _tempBuffer );
            
            buffer_seek( _decompressedBuffer, buffer_seek_start, 0 );
            SnapBufferWriteBinary( _tempBuffer, _fileData );
            buffer_delete( _decompressedBuffer );
        }

        buffer_delete( _tempBuffer );
        
        print( $"Saved Achievements" );
        
        return self;
    }
    static LoadAchievements = function( _data ) {
        var _achievementCount = struct_names_count( _data );
        var _achievementIDs = struct_get_names( _data );
        
        for( var i = 0; i < _achievementCount; ++i ) {
            var _achievement = _achievementIDs[i];
            
            global.achievements[$ _achievement].Deserialize();
        }
        print( $"Loaded Achievements" );
    }
    static SerializeAchievements = function() {
        var _data = {};
        var _achievementCount = struct_names_count( global.achievements );
        var _achievementIDs = struct_get_names( global.achievements );
        
        for( var i = 0; i < _achievementCount; ++i ) {
            var _achievement = _achievementIDs[i];
            
            _data[$ _achievement] = global.achievements[$ _achievement].Serialize();
        }
        
        _data = SnapToJSON( _data );
        
        return _data;
    }
    static DeserializeAchievements = function() {
        var _fileName = PROFILE_PATH + $"valor.dat";
        var _tempBuffer = buffer_load( _fileName );
        var _decompressedBuffer = buffer_decompress( _tempBuffer );
        var _achievementCount = struct_names_count( global.achievements );
        var _decodedData = SnapBufferReadBinary( _decompressedBuffer, buffer_tell( _decompressedBuffer ) );
        var _data = SnapFromJSON( _decodedData );
        
        buffer_delete( _tempBuffer );
        buffer_delete( _decompressedBuffer );
        
        return _data; 
    }
    static SaveProfile = function() {
        profile.Serialize();
    }
    static LoadProfile = function() {
        profile.Deserialize();
        profile.SetSeed();
    }
    static SaveGame = function() {
        SaveProfile();
        SaveWorldState();
    }
    static LoadGame = function() {
        LoadProfile();
        LoadWorldState();
    }
    /// @desc Returns an encoded json string to be used in SaveGame()
    static SerializeWorldState = function() {
        var _instanceCount = 0;
        var _instArray = [];
        var _data = {};
        
        print( "Attempting Serialize Worldstate ..." );
        
        /* 
            Getting all dynamic objects
        */
        with( all ) {
            if ( object_is_ancestor( object_index, obj_worldobject ) ) {
                // Only add to the list if it is a dynamic object
                if ( flags.HasFlag( OBJFLAGS.DYNAMIC ) ) {
                    //print( $"Found {object_get_name(object_index)}, {id}" );
                    
                    array_push( _instArray, id );
                    ++_instanceCount;
                }
            }
        }
        
        // Iterating over all objects that need to be saved and saving their data.
        for( var i = 0; i < _instanceCount; ++i ) {
            var _object = _instArray[i];
            
            try {
                var _objectEntry = i;
                
                // eventually just use like a level id or something.
                // Creating entries for room and nesting instances that were flagged for saving.
                _data[$ _objectEntry] = {};
                
                // Invoke Serialize.
                _data[$ _objectEntry][$ "data"] = _object.Serialize();
                
                // Writing default object properties into the entry
                _data[$ _objectEntry][$ "object_index"] = _object.object_index;
                _data[$ _objectEntry][$ "entityID"] = _object.entityID;
                _data[$ _objectEntry][$ "transform"] = _object.transform.Serialize();
                _data[$ _objectEntry][$ "classData"] = _object.__self.Serialize();
                _data[$ _objectEntry][$ "height"] = _object.height;
                _data[$ _objectEntry][$ "depth"] = _object.depth;
                
                #region Character Entities | Player, Enemies, Bosses
                // Saving characters
                if ( object_is_ancestor( _object.object_index, obj_character ) ) {
                    // Saving the KEYS of the Weapon and Animation structs.
                    // _data[$ _objectEntry][$ "weaponData"] = 0;
                    // _data[$ _objectEntry][$ "currentWeapon"] = _object.currentWeapon.Serialize();
                    
                    // Saving Animation Data.
                    _data[$ _objectEntry][$ "animationData"] = { 
                        animIndex : _object.animIndex,
                        data : _object.currentAnimation.GetData() 
                    };
                    
                    _data[$ _objectEntry][$ "height"] = _object.height;
                }
                #endregion
                #region World Objects | Puzzle objects, Locked doors, etc.
                #endregion
            }
            catch(e) {
                print( $"=====================\nSerialization Fail : Cannot deserialize WorldState.\n=====================\nException Caught : \n{e}\n=====================" );
                return;
            }
        }

        global.worldStates ??= {};
        global.worldStates[$ room_get_name( room )] = _data;
        
        print( global.worldStates );
        
        return global.worldStates;
    }
    static DeserializeWorldState = function( _encodedData ) {
        var _decodedData = _encodedData;
        
        if ( is_undefined( _decodedData ) ) {
            print( "=====================\nDecode Fail : Cannot decode the encoded string.\n=====================" );
            return;
        }
        
        var _levelRoomNames = global.currentLevel.GetRooms();
        
        var _roomIndex = room_get_name( room );
        var _roomData = _decodedData[$ _roomIndex];
        
        // We should only be deserializing if the current room matches the room data from the decoded JSON
        if ( is_undefined( _roomData ) ) {
            print( "=====================\nDeserialize Fail : Cannot deserialize a room that does not have save data or does not match the current room!\n=====================" );
            return;
        }
    }
    static AttemptLoadObjects = function( data ) {
        var _worldStateData = data;
        var _roomID = room_get_name( room );
        var _roomData = _worldStateData[$ _roomID];
        var _result = false;
        
        try {
            // Clear existing dynamic objects
            with ( all ) {
                if ( object_is_ancestor( object_index, obj_worldobject ) 
                && flags.HasFlag( OBJFLAGS.DYNAMIC ) ) {
                    instance_destroy();
                }
            }
    
            // Iterate over the saved objects and recreate them
            var _loadPercentage = 0;
            var _objectCount = struct_names_count( _roomData );
            print( $"Loading Objects ..." );
            
            for ( var i = 0; i < _objectCount; ++i ) {
                var _objectEntry = _roomData[$ i];
                var _newObj = instance_create_depth( 0, 0, _objectEntry[$ "depth"], _objectEntry[$ "object_index"] );
                
                _loadPercentage = ( i / _objectCount ) * 100;
                print( $"{_loadPercentage}%" );
                
                // Set object properties
                
                // Invoke Deserialize
                _newObj.Deserialize( _objectEntry[$ "data"] );
                
                _newObj.entityID = _objectEntry[$ "entityID"];
                _newObj.__self.Deserialize( _objectEntry[$ "classData"] );
                _newObj.transform.Deserialize( _objectEntry[$ "transform"] );
                _newObj.z = _newObj.transform.position.z;
                _newObj.height = _objectEntry[$ "height"];
                
                with( _newObj ) {
                    setPropHeight( _newObj.height );
                }
                
                #region Character Entities
                if ( object_is_ancestor( _newObj.object_index, obj_character ) ) {
                    // I cannot believe i had to use a library for this to work.
                    // _newObj.currentWeapon = json_parse_classful( _objectEntry[$ "currentWeapon"] );
                    
                    // Loading Animation Data
                    _newObj.currentAnimation = new cAnimation();
                    _newObj.currentAnimation.LoadData( _objectEntry[$ "animationData"].data );
                    _newObj.animIndex = _objectEntry[$ "animationData"].animIndex;
                    _newObj.height = _objectEntry[$ "height"];
                }
                #endregion
                
                _result = true;
            }
        }
        catch (e) {
            print( $"=====================\nObject Load Fail : Cannot Load WorldState.\n=====================\nException Caught : \n{e.message}\n=====================" );
        }
        
        if ( _result ) {
            print( $"=====================\nLoaded All Objects Successfully!\n=====================\n" );
        }
        
        return _result;
    }
    
    // Takes the current Map ID and a Data string from the serialized world state. This is used for saving later!
    // This should be called anytime a room is entered/exited.
    static PackWorldState = function( map ) {
        global.worldStates ??= {};
        global.worldStates[$ room_get_name( room )] = SerializeWorldState();
        return global.worldStates;
    }
    
    // This should be called whenever a new room is entered and when a room is exited.
    static SaveWorldState = function( _saveSlot = global.currentSaveSlot, _fileName = $"/{_saveSlot}.save", _updateFile = true ) {
        var _saveData = {};
        var _saveFile = SAVE_PATH + _fileName;
        var _saveVersion = -1;
        var _tempSaveBuffer = buffer_create( 1, buffer_grow, 1 );
        
        print( $"==================\nSAVING LEVEL : {global.currentLevel.GetName()}, VERSION : {GAME_VERSION}\n==================\n" );
        
        // Writing the save file version for backwards compat.
        _saveData[$ "saveVersion"] ??= GAME_VERSION;
        
        // Enforced params
        _saveData[$ "playerState"] ??= {};
        _saveData.playerState[$ "inventory"] ??= {};
        _saveData[$ "worldState"] ??= {};
        
        // Checking if a save is already created so we can append it.
        if ( _updateFile
        && file_exists( _saveFile ) ) {
            var _existingData = buffer_load( _saveFile );
            var _decompressedBuffer = buffer_decompress( _existingData );
            
            print( "Appending Save File ..." );
            
            try {
                // If the existing data has more than 0 bytes we will read it.
                if ( buffer_get_size( _decompressedBuffer ) > 0 ) {
                    buffer_seek( _decompressedBuffer, buffer_seek_start, 0 );
                }
                
                // If data exists, the JSON file we are creating should match the existing SAVE file.
                if ( !is_undefined( _decompressedBuffer ) ) {
                    _saveData = SnapBufferReadBinary( _decompressedBuffer, buffer_tell( _decompressedBuffer ) );
                }
            }
            catch(e) {
                print( $"Error Appending File : \n{e.message}\n" );
            }
            
            buffer_delete( _existingData );
            buffer_delete( _decompressedBuffer );
        }
        
        #region Invoking Serialize Methods and Saving Data
        // Setting files worldState to the worldState that was packed.
        _saveData.worldState = SerializeWorldState();
        _saveData.playerState.inventory = user().GetInventory().Serialize();
        
        // Writing the entire encoded string.
        SnapBufferWriteBinary( _tempSaveBuffer, _saveData );
        
        var _compressedBuffer = buffer_compress( _tempSaveBuffer, 0, buffer_tell( _tempSaveBuffer ) );
        var _saveSize = buffer_get_size( _compressedBuffer );
        
        // Saving the buffer to a file
        buffer_save( _compressedBuffer, _saveFile );
        #endregion
        
        // Free the buffers from memory
        buffer_delete( _tempSaveBuffer );
        buffer_delete( _compressedBuffer );
        
        print( $"==================\nSAVED {bytes_get_size( _saveSize )}\n==================\n" );
    }
    static GetWorldState = function( _saveSlot = global.currentSaveSlot, _fileName = $"/{_saveSlot}.save" ) {
        var _saveFileData = {};
        var _saveFileName = _fileName;
        var _saveFilePath = SAVE_PATH + _saveFileName;
        var _saveVersion = -1;
        
        // Check if the save file exists
        if ( !file_exists( _saveFilePath ) ) {
            print( $"Save file {global.currentProfile} not found." );
            return;
        }
    
        // Load the compressed buffer from the file
        var _loadedBuffer = buffer_load( _saveFilePath );
        
        // Decompress the buffer
        var _decompressedBuffer = buffer_decompress( _loadedBuffer );
        
        // Read the encoded string from the buffer
        _saveFileData = SnapBufferReadBinary( _decompressedBuffer, buffer_tell( _decompressedBuffer ) );

        // Check if decoding was successful
        if ( _saveFileData == undefined ) {
            print( $"Error decoding save data for slot {global.currentProfile}." );
            return;
        }

        // Reading the save version
        var _saveVersion = _saveFileData.saveVersion;
        var _currentLevelName = global.currentLevel.GetName();
        
        if ( _saveVersion != GAME_VERSION ) {
            print( $"######\nWARNING!\n######\nSave File being loaded is a different version than Game Version.\nGAME VER:{GAME_VERSION}\nSAVE VER:{_saveVersion}" );
        }
        print( $"==================\nLOADING LEVEL : {_currentLevelName}, VERSION : {_saveVersion}\n==================\n" );
        
        #region Loading Worldstate
        // Restore world state
        var _worldStateLevelData = struct_get_names( _saveFileData.worldState );
        var _worldStateRoomName = 0;
        var _worldStateRoomID = 0;
        
        var _levelRoomNames = global.currentLevel.GetRooms();
        var _load = false;
        
        if ( is_undefined( _worldStateLevelData ) ) {
            throw $"Cannot Load worldState Data as it is undefined ...";
        }
        
        // ============================================
        // This is ass.
        // ============================================
        // Loop through all the rooms in the current level
        // for( var i = 0; i < array_length( _levelRoomNames ); ++i ) {
        //     var _levelName = _levelRoomNames[i].roomID;
        //     var _currentLevel = asset_get_index( _levelName );
            
        //     // Check if they match any of the rooms in the save file
        //     for( var j = 0; j < array_length( _worldStateLevelData ); ++j ) {
        //         _worldStateRoomName = _worldStateLevelData[j];
        //         _worldStateRoomID = asset_get_index( _worldStateRoomName );
        //         break;
        //     }
        //     break;
        // }
        // ============================================
        #endregion
        // Free the buffers from memory
        buffer_delete( _loadedBuffer );
        buffer_delete( _decompressedBuffer );
        
        return {
            data : _saveFileData,
            roomID : _worldStateRoomID
        }
    }
    static LoadWorldState = function( _worldState = GetWorldState() ) {
        if ( !struct_exists( _worldState, "data" ) ) {
            print( $"Cannot Load Worldstate | Data does not exist!" );
            return;
        }
        
        var _worldStateData = _worldState.data.worldState;
        var _worldStateRoomID = _worldState.roomID;
        var _playerState = _worldState.data.playerState;
        
        // if ( room == _worldStateRoomID ) {
            AttemptLoadObjects( _worldStateData );
            
            if ( !is_undefined( _playerState ) ) {
                user().GetInventory().Deserialize( _playerState.inventory );
            }
        // }
    }
    // This should be called every time there needs to be a quick save or autosave.
    static AutoSave = function() {
        return SaveWorldState( , $"/autosave.save", false );
    }
    #endregion
    
    return self;
}