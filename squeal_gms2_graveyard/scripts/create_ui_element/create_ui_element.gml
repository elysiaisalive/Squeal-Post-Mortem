/// @function					create_element_button( x, y, width, height, name );
/// @param			{real}		x			x
/// @param			{real}		y			y
/// @param			{real}		width		Bounding box width
/// @param			{real}		height		Bounding box height
/// @param			{string}	name		Button name
function create_element_button( _x, _y, _w, _h, _name, _sprite = undefined, _xpad = 0, _ypad = 0 ) constructor
{
	// Bounding box
	x				= _x;
	y				= _y;
	xpad			= _xpad;
	ypad			= _ypad;
	name			= _name;
	width			= _w + ( string_length( name ) * 8 );
	height			= _h;
	hovered			= false;
	control			= global.element;	// controller
	sprite			= _sprite ?? FALLBACK_SPRITE;

	ds_list_add( control.element_list, self );
	
	#region Get / Set methods
	static GetName = function()
	{
		return name;
	}
	
	static GetSprite = function()
	{
		return sprite;
	}
	
	static GetSpriteWidth = function()
	{
		return sprite_get_width( sprite );
	}
	
	static GetSpriteHeight = function()
	{
		return sprite_get_height( sprite );
	}
	
	static GetX = function()
	{
		return x;
	}

	static GetY = function()
	{
		return y;
	}
	
	static GetWidth = function()
	{
		return width;
	}

	static GetHeight = function()
	{
		return height;
	}
	
	static GetValue = function()
	{
		return setting;
	}
	
	static SetSpriteFromIndex = function( _sprite )
	{
		return sprite = _sprite;
	}
	
	static SetValue = function( value )
	{
		return setting = value;
	}
	
	static SetFocus = function()
	{
		control.ui_focused = self;
	}
	#endregion
	
	static IsHovered = function()
	{
		if ( point_in_rectangle( mouse_x, mouse_y, x, y, x + width, y + height  ) )
		{	
			OnHover();
			return true;
		}
		else
		{
			return false;
		}
	}
	
	static HasFocus = function()
	{
		return ( control.ui_focused == self );
	}
	
	static RemoveFocus = function()
	{
		control.ui_focused = undefined;
	}
	
	static InputClick = function()
	{
		SetFocus();
		OnClick();
	}
	
	static OnClick = function(){};
	
	static OnHover = function(){};
	
	static step = function()
	{	
		if ( mouse_check_button_pressed( mb_left ) && point_in_rectangle( mouse_x, mouse_y, x, y, x + width, y + height  ) )
		{
			InputClick();
			control.can_click = false;
		}
	}
	
	static draw = function()
	{	
		draw_text( x, y, string( name ) );
	}
	
	static destroy = function()
	{
		var ind = ds_list_find_index( control.element_list, self );
		
		ds_list_delete( control.element_list, ind );
	}
}

//function create_element_checkbox() : create_element_button() constructor
//{
//}

function element_get_input() constructor
{
	global.element = self;
	
	element_list = ds_list_create();
	
	ui_focused = undefined;
	can_click = true;
	
	
	static step = function()
	{
		if ( mouse_check_button_pressed( mb_left ) && ( ui_focused == undefined ) )
		{
			can_click = true;
		}
		
		// Activating step event on all button objects
		var list_size = ds_list_size( element_list );
		
		for( var i = 0; i < list_size; ++i )
		{
			element_list[| i ].step();
		}
	}
	
	static draw = function()
	{	
		// Activating draw event on all button objects
		var list_size = ds_list_size( element_list );
		
		for( var i = 0; i < list_size; ++i )
		{
			element_list[| i ].draw();
		}
	}
	
	static destroy = function()
	{
		// Activating draw event on all button objects
		var list_size = ds_list_size( element_list ) - 1;
		
		for( var i = list_size; i >= 0; --i )
		{
			element_list[| i ].destroy();
		}
		
		ds_list_destroy( element_list );
		
		delete global.element;
		global.element = undefined;
	}
	
}