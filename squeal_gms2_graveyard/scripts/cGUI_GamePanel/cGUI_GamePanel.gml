function cGUI_GamePanel( _parent = undefined, _name = "game_panel" ) : cGUI_Panel( _parent, _name ) constructor
{
	SetFlag( FGUI.COPY_PARENT_SIZE );
	
	viewPort = new cGUI_Viewport( self, "viewport", 0, true );
};
