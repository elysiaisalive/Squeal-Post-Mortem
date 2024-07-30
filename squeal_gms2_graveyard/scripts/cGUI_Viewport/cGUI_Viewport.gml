function cGUI_Viewport( _parent, _name = "viewport", _view = -1, _autosize = true ) : cGUI_Panel( _parent, _name ) constructor
{
	currentView = 0;
	viewCamera = new cCameraLegacy( currentView );
	
	iViewportSurf   = undefined;
	fViewportScale  = 1;
	iViewportWidth  = -1;
	iViewportHeight = -1;
	bViewportTrueSize = true;
	
	fViewportAspect = ( 16 / 9 );
	bAutoSize		= _autosize;
	
	static OnCleanup = function()
	{
		if surface_exists( iViewportSurf ?? -1 )
			surface_free( iViewportSurf );
	}
	
	static Tick = function()
	{
		if ( currentView < 0 )
			return;
		
		if ( view_visible[currentView] )
		{
			if ( !IsVisible() )
			{
				view_visible[currentView] = false;
			}
		}
		else
		{
			if ( IsVisible() )
			{
				view_visible[currentView] = true;
			}
		}
		
		
	}
	
	static Draw = function()
	{
		draw_clear( c_red );
		
		if ( currentView < 0 )
			return;
		
		var iSurf = GetViewportSurf();
		
		if ( surface_exists( iSurf ) )
		{
			shader_set( shd_viewport );
			gpu_set_texrepeat( false );
			
			if ( bViewportTrueSize )
			{
				draw_surface( iSurf, ( Parent.GetWidth() - iViewportWidth ) / 2, ( Parent.GetHeight() - iViewportHeight ) / 2 );
			}
			else
			{
				draw_surface_stretched( iSurf, 0, 0, iViewportWidth, iViewportHeight );
			}
		}
	}
	
	static OnParentResized = function()
	{
		if ( currentView < 0 )
			return;
		
		var surf = GetViewportSurf();
		if ( bAutoSize )
		{
			var parentWidth = Parent.GetWidth();
			var parentHeight = Parent.GetHeight();
			var width = parentWidth;
			var height = parentHeight;
			if ( width < 1 || height < 1 )
				return;
			var parentAspect = real( parentWidth ) / parentHeight;
			var _x = round( width / 2 );
			var _y = round( height / 2 );
			var x1 = 0;
			var x2 = parentWidth;
			var y1 = 0;
			var y2 = parentHeight;
			if ( fViewportAspect >= parentAspect )
			{
				height = ( width / fViewportAspect );
				y1 = ~~( _y - ( height / 2 ) );
				y2 = ( parentHeight - y1 );
			}
			else
			{
				width = ( height * fViewportAspect );
				x1 = ~~( _x - ( width / 2 ) );
				x2 = ( parentWidth - x1 );
			}
			iViewportWidth = x2 - x1;
			iViewportHeight = y2 - y1;
			SetRegion( x1, y1, x2, y2 );
		}
		else
		{
			iViewportWidth = GetWidth();
			iViewportHeight = GetHeight();
		}
		
		if surface_exists( surf )
		{
			surface_depth_disable( false );
			surface_resize( surf, max( 1, iViewportWidth ), max( 1, iViewportHeight ) );
		}
	}
	
	static OnResized = function()
	{
		OnParentResized();
	}
	
	static GetViewportSurf = function()
	{
		if ( !surface_exists( iViewportSurf ?? application_surface ) )
		{
			surface_depth_disable( false );
			iViewportSurf = surface_create( max( iViewportWidth, 1 ), max( iViewportHeight, 1 ) );
			Redraw();
		}
		
		view_surface_id[0] = iViewportSurf ?? application_surface;
		return iViewportSurf ?? application_surface;
	}
};