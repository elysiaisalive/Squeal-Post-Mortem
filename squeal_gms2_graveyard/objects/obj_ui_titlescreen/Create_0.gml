guiController = new cGUIController();

siner = 0;

guiController.Init = function() {
    background = new cGUIElementSprite( "background" );
    background.SetBounds( 0, 0, 480, 270 );
    background.SetAnimation( spr_mainmenu_background_slaughter, 0.075, 0 );
    background.Disable();
    
    title = new cGUIElement( "title" );
    title.SetGroup( UI_GROUPS.PANEL_MAIN );
    title.hoverTimer.SetNewTime( 60 * 10 );
    title.SetHint( LOC_STRING( "#Game.Cfg.Secret" ) );
    title.SetMovePositions( 52, 45, -240 );
    title.SetBounds( 176, 64 );
    title.Draw = function() {
        var amnt		= 0.5;
        
        var color			= merge_color( #2f0022, #66002e, abs( sin( siner + 1 ) ) );
        var color2			= merge_color( #040007, #18001e, abs( sin( siner + 1 ) ) );
        
        for( var i = 0; i < sprite_get_number( spr_ui_mainmenu_titlebg ); ++i )
        {
        	var _sin = sin( siner + ( i * amnt ) );
        	var _cos = cos( siner + ( i * amnt ) );
        	
        	draw_sprite_ext( spr_ui_mainmenu_titlebg, i, _sin + title.x + ( 23 * i ), _cos + title.y, 0.6, 0.6, 0 + _sin, merge_color( color, color2, abs( sin( siner + 1 ) ) ), title.alpha );
        }
        
        for( var i = 0; i < sprite_get_number( spr_ui_mainmenu_title ); ++i )
        {
        	var _sin = sin( siner + ( i * amnt ) );
        	var _cos = cos( siner + ( i * amnt ) );
        	
        	draw_sprite_ext( spr_ui_mainmenu_title, i, _sin + title.x + 1 + ( 24 * i ), _cos + title.y + 1, 0.6, 0.6, 0 + _cos, image_blend, title.alpha );
        }
    }
    
    #region Main Panel
    options_tab = new cGUIElement( "cfg_tab" );
    options_tab.SetGroup( UI_GROUPS.PANEL_MAIN );
    options_tab.SetMovePositions( -240, 32, 52 );
    options_tab.SetBounds( 64, 16 );
    options_tab.DoPress = function() {
        guiController.SetGroupVisibility( UI_GROUPS.PANEL_MAIN, false );
        guiController.SetGroupVisibilityEnable( UI_GROUPS.CFG_GAMEPLAY, true );
    }
    
    options = new cGUIElement( "options" );
    options.SetGroup( UI_GROUPS.PANEL_MAIN );
    options.SetHint( LOC_STRING( "#Game.Cfg.Options" ) );
    options.SetMovePositions( 52, 176, -240 );
    options.SetBounds( 128, 16 );
    options.DoPress = function() {
        guiController.SetGroupVisibility( UI_GROUPS.PANEL_MAIN, false );
        guiController.SetGroupVisibilityEnable( UI_GROUPS.CFG_GAMEPLAY, true );
    }
    #endregion
    
    #region Options Panel
    zoom_mode = new cGUIElementSelector( "zoom_mode" );
    zoom_mode.SetGroup( UI_GROUPS.PANEL_MAIN );
    zoom_mode.SetHint( LOC_STRING( "#Game.Cfg.ZoomMode" ) );
    zoom_mode.SetMovePositions( -240, 176, 52 );
    zoom_mode.SetButtonBounds( zoom_mode.x, zoom_mode.y, 16, 16, zoom_mode.x + zoom_mode.width - 16, zoom_mode.y, 16, 16 );
    zoom_mode.SetBounds( 128, 16 );
    zoom_mode.AddOptions( 0, 1, 2, 3 );
    
    sensitivity = new cGUIElementSlider( "sensitivity" );
    sensitivity.SetGroup( UI_GROUPS.PANEL_MAIN );
    sensitivity.SetHint( LOC_STRING( "#Game.Cfg.Sensitivity" ) );
    sensitivity.SetBounds( 128, 8 );
    sensitivity.SetMovePositions( -240, 196, 52 );
    sensitivity.SetValue( global.mouse_sensitivity );
    
    rawinput = new cGUIElementButtonToggle( "rawinput" );
    rawinput.SetGroup( UI_GROUPS.PANEL_MAIN );
    rawinput.SetHint( LOC_STRING( "#Game.Cfg.RawInput" ) );
    rawinput.SetValue( false );
    rawinput.SetBounds( 32, 32 );
    rawinput.SetMovePositions( -240, 208, 52 );
    #endregion
    
    guiController.AddElement( background );
    guiController.AddElement( title );
    guiController.AddElement( options_tab );
    guiController.AddElement( options );
    guiController.AddElement( sensitivity );
    guiController.AddElement( rawinput );
    guiController.AddElement( zoom_mode );
    
    // Add elements to controller and disable all
    guiController.AddElements();
    
    guiController.ActivateGroup( UI_GROUPS.PANEL_MAIN );
    guiController.DisableGroup( UI_GROUPS.CFG_GAMEPLAY );
    guiController.SetGroupVisibility( UI_GROUPS.CFG_GAMEPLAY, false );
    guiController.SetGroupVisibility( UI_GROUPS.PANEL_MAIN, true );
}

call_later( 1, time_source_units_frames, function() { 
    guiController.Init(); 
});