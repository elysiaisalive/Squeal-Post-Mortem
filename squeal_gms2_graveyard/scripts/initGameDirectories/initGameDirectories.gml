function initGameDirectories() {
	#macro APPDATA_PATH ( environment_get_variable( "APPDATA" ) + @"\squeal\" )
	#macro GAME_PATH ( IDE_MODE ? @"C:\Users\capnb\Projects and Modding\Projects\WIP\Squeal 2\" : ( program_directory + @"\" ) )
	
	#macro ROOT_PATH ( program_directory + @"\" )
	#macro DATA_PATH ( APPDATA_PATH + @"data\" )
	#macro CACHE_PATH ( DATA_PATH + @"cache\" )
	#macro BULB_PATH ( CACHE_PATH + @"bulb\" )
	
	#macro CONFIG_PATH ( DATA_PATH + @"config\" )
	#macro RESOURCE_PATH ( DATA_PATH + @"resource\" )
	#macro LOGS_PATH ( DATA_PATH + @"logs\" )
	#macro PROFILE_PATH ( DATA_PATH + @"profiles\" )
	#macro SAVE_PATH ( PROFILE_PATH + $"{global.currentProfile}" + "/saves" )
	
	#macro LANG_PATH ( CONFIG_PATH + @"lang\" )
	#macro SFX_PATH ( RESOURCE_PATH + @"sfx\" )
	#macro MUSIC_PATH ( RESOURCE_PATH + @"music\" )
    
    print( "initializing game directories" );
    
    // Init Game Config
    directory_create( APPDATA_PATH + "\\data\\" );
    directory_create( DATA_PATH + "\\resource\\" );
    directory_create( DATA_PATH + "\\config\\" );
    directory_create( DATA_PATH + "\\logs\\" );
    directory_create( CONFIG_PATH + "\\lang\\" );
    directory_create( RESOURCE_PATH + "\\sfx\\" );
    directory_create( RESOURCE_PATH + "\\music\\" );
    
    // Init Save Profile Folders
    for( var i = 0; i < 3; ++i ) {
        if ( !directory_exists( PROFILE_PATH + $"/{i}" ) ) {
            directory_create( PROFILE_PATH + $"/{i}" );
        }    
        
        // creating cache folders for saving SAVES within profiles...
        if ( !directory_exists( SAVE_PATH ) ) {
            directory_create( SAVE_PATH );
        }   
    }
};