enum FGUI
{
	REDRAW				= 1 << 0,
	DRAW				= 1 << 1,
	M_INPUT 			= 1 << 2,
	KB_INPUT			= 1 << 3,
	VISIBLE				= 1 << 4,
	ENABLED				= 1 << 5,
	POPUP				= 1 << 6,
	DRAWBACKGROUND		= 1 << 7,
	RESIZE				= 1 << 8,
	LAYOUT				= 1 << 9,
	COPY_PARENT_SIZE	= 1 << 10,
	DELETE				= 1 << 11,
}

function cGUI_Panel( _parent = undefined, _name = undefined ) constructor
{
	Parent = noone;
	Window = noone;
	
	panelSurf		= -1;
	panelCursor		= cr_default;
	
	fPanelScale		= 1;
	fAlpha = 1;
	
	iBGColor = c_gray;
	fBGAlpha = 1;
	
	x = 0;
	y = 0;
	
	iPanelWidth		= 32;
	iPanelHeight	= 32;
	
	iPanelMinWidth  = 0;
	iPanelMinHeight = 0;
	
	bVisible = false;
	bDrawPopups = false;
	bIsPopup = false;
	bEnabled = false; // interactable ? 
	m_bVisible = false;
	bRedraw = false;
	bMouseHovered = false;
	bMouseEnabled = false;
	bKeyboardEnabled = false;
	
	panelName = _name ?? instanceof( self );
	
	panelFlags = 0;
	
	SetEnabled( true );
	SetVisible( true );
	
	SetFlag( FGUI.LAYOUT );
	SetFlag( FGUI.DRAW | FGUI.DRAWBACKGROUND, true );
	
	aPanelChildren = [];
	
	//println( string( "Created Panel {0}", _name ) );
	
	if ( _parent )
	{
		SetParent( _parent );
	}
	
	static Cleanup = function()
	{
		if ( Parent )
		{
			Parent.RemoveChild( self );
		}
		
		array_foreach( aPanelChildren, function( Child ) { Child.Cleanup() }, infinity, -infinity );
		
		OnCleanup();
		
		if surface_exists( panelSurf )
		{
			surface_free( panelSurf );
			panelSurf = -1;
		}
	}
	
	static OnCleanup = function() {}
	
	static SetParent = function( _inst )
	{
		if ( _inst == self )
			return;
		if ( Parent )
			Parent.RemoveChild( self );
		Parent  = _inst;
		Parent.AddChild( self );
	}
	
	static AddChild = function( _inst )
	{
		if ( _inst ) && !( array_contains( aPanelChildren, _inst ) )
		{
			array_push( aPanelChildren, _inst );
		}
	}
	
	static RemoveChild = function( _inst )
	{
		if ( _inst )
		{
			for ( var i = 0; i < array_length( aPanelChildren ); i++ )
			{
				if ( aPanelChildren[i] == _inst )
				{
					array_delete( aPanelChildren, i--, 1 );
				}
			}
		}
	}
	
	static SetFlag = function( _newflag = 0, _enable = true )
	{
		if ( _enable )
			panelFlags |= _newflag;
		else 
			panelFlags &= ~_newflag;
	}
	
	static HasFlag = function( _flag )
	{
		return ( panelFlags & _flag );
	}
	
	static Redraw = function()
	{
		SetFlag( FGUI.REDRAW );
	}
	
	static IsPopUp = function()
	{
		return false;
	}
	
	static SetVisible = function( enable = true )
	{
		if ( bVisible != enable )
		{
			bVisible = enable;
			SetFlag( FGUI.VISIBLE, enable );
			Redraw();
		}
	}
	
	static IsVisible = function()
	{
		if ( !m_bVisible )
		|| ( !HasFlag( FGUI.VISIBLE ) )
		|| ( iPanelWidth < 1 ) || ( iPanelHeight < 1 )
			return false;
		return true;
	}
	
	static SetEnabled = function( enable = true )
	{
		if ( bEnabled != enable )
		{
			bEnabled = enable;
			SetFlag( FGUI.ENABLED, enable );
			Redraw();
		}
	}
	
	static IsEnabled = function()
	{
		if ( !bEnabled )
		|| ( !HasFlag( FGUI.ENABLED ) )
			return false;
		return true;
	}
	
	static TickPanel = function()
	{
		if HasFlag( FGUI.ENABLED )
			Tick();
		
		if HasFlag( FGUI.DELETE )
		{
			Cleanup();
			return;
		}
		
		if IsVisible()
		{
			if HasFlag( FGUI.LAYOUT )
			{
				PanelUpdateLayout();
			}
			if HasFlag( FGUI.RESIZE )
			{
				ResizeSurface();
			}
		}
		
		array_foreach( aPanelChildren, function( _item ) { _item.TickPanel(); })
	}
	
	static Tick = function() {}
	
	static NeedsRedraw = function()
	{
		return HasFlag( FGUI.REDRAW );
	}
	
	static EnableShader = function()
	{
		shader_set( shd_viewport );
	};
	
	static EnableBlending = function()
	{
		gpu_set_blendmode_ext( bm_one, bm_inv_src_alpha );
	};
	
	static DrawPanel = function( _bRedraw = false, _DrawPopups )
	{
		if ( iPanelWidth < 1 
		|| iPanelHeight < 1 )
			return;
		
		if ( !bDrawPopups ) 
		&& ( IsPopUp() )
		{
			return;
		}
			
		var _Parent = ( IsPopUp() ) ? noone : Parent;
			
		if ( _Parent )
		{
			if ( x > _Parent.iPanelWidth
			|| ( y > _Parent.iPanelHeight )
			|| ( x + iPanelHeight < 0 )
			|| ( y + iPanelHeight < 0 ) )
			{
				return;
			}
		}
		
		if ( NeedsRedraw() )
		{
			bRedraw = true;
		}
			
		if ( bRedraw )
		{
			SetFlag( FGUI.REDRAW, false );
				
			surface_set_target( GetSurface() );
				
			draw_clear_alpha( c_black, 0 );
			
			// ddraw background
			if ( HasFlag( FGUI.DRAWBACKGROUND ) )
			{
				gpu_push_state();
				EnableShader();
				EnableBlending();
				DrawBackground();
				gpu_pop_state();
			};	
			// draw normally
			if ( HasFlag( FGUI.DRAW ) )
			{
				gpu_push_state();
				EnableShader();
				EnableBlending();
				Draw();
				gpu_pop_state();
			};
			
			surface_reset_target();
			
			// draw the child panels
			for( var i = 0; i < array_length( aPanelChildren ); ++i )
			{
				var _child = aPanelChildren[i];
					
				if ( bDrawPopups 
				|| !_child.IsPopUp() )
				{
					_child.DrawPanel( false, false );
				};
			};
			
			// draw ontop of children
			surface_set_target( GetSurface() );
			gpu_push_state();
			
			EnableShader();
			EnableBlending();
			PostChildDraw();
			
			// draw a debug sprite to check what panels are currently redrawing
			if ( true )
			{
				var _debugscale = 1 / 3;
				draw_sprite_ext( spr_default, 0, 16 * _debugscale, 16 * _debugscale, _debugscale, _debugscale, current_time / 60, c_white, 1 );
			}
			
			gpu_pop_state();
			surface_reset_target();
			
			// draw self onto the parent surface
			if ( Parent ) && ( !bDrawPopups || !IsPopUp() )
			{
				surface_set_target( Parent.GetSurface() );
				gpu_push_state();
				EnableShader();
				EnableBlending();
				
				draw_surface_ext( GetSurface(), x, y, iPanelWidth, iPanelHeight, 0, c_white, fAlpha );
				draw_set_alpha( 1 );
				gpu_pop_state();
				
				surface_reset_target();
			}
			else
			{
				gpu_push_state();
				
				draw_surface_ext( GetSurface(), x, y, fPanelScale, fPanelScale, 0, c_white, fAlpha );
				
				gpu_pop_state();
			};
			
		}
	}
	
	static DrawBackground = function()
	{
		draw_clear_alpha( iBGColor, fBGAlpha );
	}
	
	static Draw = function() {}
	
	static PostChildDraw = function() {}
	
	#region Helpers
	static GetSurface = function()
	{
		if ( !surface_exists( panelSurf ) )
		{
			surface_depth_disable( true );
			panelSurf = surface_create( max( 1, iPanelWidth ), max( 1, iPanelHeight ) );
			Redraw();
		}
		
		return panelSurf;
	}
	
	static SetPosition = function( _x = x, _y = y )
	{
		if ( x == _x ) && ( y == _y )
			return;
		
		x = ~~( _x );
		y = ~~( _y );
		
		if ( Parent )
			Parent.Redraw();
		else
			Redraw();
	}
	
	static SetSize = function( width = iPanelWidth, height = iPanelHeight )
	{
		width = max( width, iPanelMinWidth );
		height = max( height, iPanelMinHeight );
		if ( width != iPanelWidth ) || ( height != iPanelHeight )
		{
			var oldwidth = iPanelWidth;
			var oldheight = iPanelHeight;
			iPanelWidth = width;
			iPanelHeight = height;
			if ( iPanelWidth > 0 ) && ( iPanelHeight > 0 ) && surface_exists( panelSurf )
			{
				SetFlag( FGUI.RESIZE );
			}
			
			OnResized( oldwidth, oldheight );
			
			for ( var i = 0, count = array_length( aPanelChildren ); i < count; i++ )
			{
				var child = aPanelChildren[i];
				if ( child.HasFlag( FGUI.COPY_PARENT_SIZE ) )
					child.CopyParentSize();
				child.OnParentResized( oldwidth, oldheight );
			}
		}
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
		return iPanelWidth;
	}
	
	static GetHeight = function()
	{
		return iPanelHeight;
	}
	
	static SetRegion = function( _x1 = x, _y1 = y, _x2 = x + iPanelWidth, _y2 = y + iPanelHeight )
	{
		SetPosition( _x1, _y1 );
		SetSize( _x2 - _x1, _y2 - _y1 );
		
	}
	
	static SetRectangle = function( _x = x, _y = y, _w = iPanelWidth, _h = iPanelHeight )
	{
		SetPosition( _x, _y );
		SetSize( _w, _h );
	}
	
	static OnResized = function( oldwidth = iPanelWidth, oldheight = iPanelHeight )
	{
		InvalidateLayout();
	}
	
	static OnParentResized = function()
	{
		InvalidateLayout();
	}
	
	static CopyParentSize = function()
	{
		if ( IsPopUp() )
		{
			if ( Parent )
			{
				SetRectangle( Parent.GetScreenX(), Parent.GetScreenY(), Parent.GetWidth(), Parent.GetHeight() );
			}
		}
		else
		{
			if ( Parent )
			{
				SetPosition( Parent.x, Parent.y );
				SetSize( Parent.GetWidth(), Parent.GetHeight() );
			}
		}
	}
	
	static InvalidateLayout = function( updateNow = false, invalidateChildren = false, invalidateParent = false )
	{
		SetFlag( FGUI.LAYOUT );
		if ( Parent )
		{
			if ( invalidateParent )
				Parent.InvalidateLayout( false, false, invalidateParent );
			Parent.Redraw();
		}
		else
			Redraw();
		
		if ( invalidateChildren )
		{
			
		}
		if ( updateNow )
		{
			PanelUpdateLayout();
			Redraw();
		}
	}
	
	static PanelUpdateLayout = function()
	{
		SetFlag( FGUI.LAYOUT, false );
		if ( HasFlag( FGUI.COPY_PARENT_SIZE ) )
		{
			CopyParentSize();
		}
		UpdateLayout();
	}
	
	static UpdateLayout = function() {}
	
	#endregion
	
	static ResizeSurface = function()
	{
		if ( iPanelWidth )
		&& ( iPanelHeight )
		{
			surface_depth_disable( true );
			surface_resize( GetSurface(), iPanelWidth, iPanelHeight );
			Redraw();
		}
	}
	
	static SetMouseInputEnabled = function( bEnable )
	{
		bMouseEnabled = bEnable;
	}
	
	static IsMouseInputEnabled = function()
	{
		return bMouseEnabled;
	}
	
	static SetMouseFocus = function( _panel = self )
	{
		gui().SetMouseFocus( _panel );
	}
	
	static GetMouseFocus = function()
	{
		return gui().GetMouseFocus();
	}
};