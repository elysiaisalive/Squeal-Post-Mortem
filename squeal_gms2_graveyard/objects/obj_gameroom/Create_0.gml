use_gui = false;
if ( use_gui )
{
	application_surface_draw_enable( false );
	println( "gui: creating gamepanel" );
	gamePanel = ( use_gui ) ? new cGUI_GamePanel( gui().GetRootPanel(), "gamepanel" ) : undefined;
}