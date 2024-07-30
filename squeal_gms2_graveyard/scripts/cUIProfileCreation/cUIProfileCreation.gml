function cUIProfileCreation() extends cGUI() class {
    currentSelection = 0;
    controller = new cGUIController();
    
    profileName = "";
    profileSeed = random_get_seed();
    profileDifficulty = 0;

    static Tick = function() {
        if ( input_check_pressed( "key_ui_confirm" ) ) {
            gameManager().CreateProfile();
        }
    }
    static Draw = function() {
        init_camera_gui( 480, 270 );
        
        draw_text( 480/2, 270/2, $"Name:{0}" );
        draw_text( 480/2, 270/2+16, $"Seed:{0}" );
        draw_text( 480/2, 270/2+16, $"Difficulty:{0}" );
    }
}