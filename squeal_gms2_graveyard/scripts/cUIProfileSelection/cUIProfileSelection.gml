function cUIProfileSelection() extends cGUI() class {
    selectedProfile = 0;
    profiles = [undefined, undefined, undefined];
    controller = new cGUIController();
    
    GetProfiles();
    
    static GetProfiles = function() {
        var _profilePath = PROFILE_PATH + $"/{global.currentProfile}";
        
        for( var i = 0; i < 3; ++i ) {
            if ( directory_exists( PROFILE_PATH + $"/{i}" ) ) {
                // Getting the profile file from each Profile Folder and adding them to the array.
                if ( file_exists( PROFILE_PATH + $"/{i}.save" ) ) {
                    profiles[i] = PROFILE_PATH + $"/{i}.save";
                }
            }
        }
    }
    static Tick = function() {
    }
    static Draw = function() {
        init_camera_gui( 480, 270 );
    }
}