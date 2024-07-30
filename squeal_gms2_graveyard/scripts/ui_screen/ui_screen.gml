function hud_letterbox( element_name ) : hud_item( element_name ) constructor
{
	letterbox_width = 0;
	letterbox_height = 0;
	
	static SetHeight = function( new_value )
	{
		letterbox_height = new_value;
	};	
	
	static SetWidth = function( new_value )
	{
		letterbox_width = new_value;
	};
};

function ui_screen() : hud_controller() constructor
{
//	if ( live_call() ) return live_result;
	
	static Primary		= #ffffff;
	static Secondary	= #ff00c6;
	static Tertiary		= #27008a;
	
	static Init = function()
	{
		// Text prompt for items
		itemTextPrompt = new hud_item( "itemTextPrompt" );
		itemTextPrompt.SetLerpX( 225 );
		itemTextPrompt.SetLerpY( 205, 275 );
		itemTextPrompt.SetValue( "" );
		itemTextPrompt.Draw = method( itemTextPrompt, function() {
			draw_set_color( c_white );
			draw_set_halign( fa_center );
			draw_set_font( fnt_chaptertitle );
			draw_text_transformed_color( elem_x, elem_y, elem_value, 0.50, 0.50, 0, c_white, c_white, c_white, c_white, elem_alpha );
		});
		
		chaptertitle = new hud_item( "chapter" );
		chaptertitle.SetLerpX( 240 );
		chaptertitle.SetLerpY( 262, 280 );
		chaptertitle.SetOpacity( 1 );
		chaptertitle.SetValue( LOC_STRING( "#Game.Chapters.00" ) );
		chaptertitle.Draw = function() {
			draw_set_color( Primary );
			draw_set_halign( fa_center );
			draw_set_font( fnt_chaptertitle );
			draw_text_transformed_color( chaptertitle.elem_x, chaptertitle.elem_y, chaptertitle.elem_value, 0.30, 0.30, 0, Primary, Primary, Primary, Primary, chaptertitle.elem_alpha );
		};
		
		box_top = new hud_letterbox( "box_top" );
		box_top.SetLerpX( 0 );
		box_top.SetLerpY( 0, -10 );
		box_top.SetOpacity( 1 );
		box_top.Draw = method( box_top, function() {
			// x, y, w, h
			DrawRect( elem_x, elem_y, 480, 10 );
		});
		
		box_bottom = new hud_letterbox( "box_bottom" );
		box_bottom.SetLerpX( 0 );
		box_bottom.SetLerpY( 270, 280 );
		box_bottom.SetOpacity( 1 );
		box_bottom.Draw = method( box_bottom, function()
		{
			DrawRect( elem_x, elem_y, 480, -10 );
		});	
		
		AddElement( box_top );
		AddElement( box_bottom );
		AddElement( chaptertitle );
		AddElement( itemTextPrompt );
	};
};