function cGUI() class {
	mousePosition = new Vector2( 0, 0 );
	guiScale	= 1;
	enabled = false;
	debug = false;
	
	currentMouseFocus = noone;
	currentKeyboardFocus = noone;
	
	static ToggleDebug = function() {
		debug = !debug;
	}
	
	#region Helpers
	static GetMouseFocus = function() {
		return currentMouseFocus;
	}
	
	static SetMouseFocus = function( _panel = undefined ) {
		currentMouseFocus = _panel;
	}
	#endregion
	
	static Tick = function(){};
	
	static TickMouse = function() {
		var _last_mouse_focus = GetMouseFocus();
		var _mouse_x_new = ( display_mouse_get_x() - window_get_x() ) / guiScale;
		var _mouse_y_new = ( display_mouse_get_y() - window_get_y() ) / guiScale;
		
		if ( _mouse_x_new != mousePosition.x
		|| _mouse_y_new != mousePosition.y ) {
			mousePosition.x = _mouse_x_new;
			mousePosition.y = _mouse_y_new;
		}
	}
	
	static Draw = function(){};

	static DrawDebug = function(){};
};

function gui() {
	static s_Class = new cGUI();
	return s_Class;
}