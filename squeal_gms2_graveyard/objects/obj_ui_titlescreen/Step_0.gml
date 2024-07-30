siner += 0.025;

/* 
    TODO :
        Add checks for whether or not the player is interacting with a menu item???
*/
if ( guiController.GetCurrentVisibleGroup() != UI_GROUPS.PANEL_MAIN ) {
    if ( input_check_pressed( "key_ui_deny" ) ) {
        // Setting all groups visible to false and then setting main panel stuff to be visible
        guiController.SetAllGroupVisibilityExcept( UI_GROUPS.PANEL_MAIN, true );
        guiController.DisableAllExcept( UI_GROUPS.PANEL_MAIN );
        guiController.SetGroupVisibility( UI_GROUPS.PANEL_MAIN, true );
    }
}