function hud_controller() constructor
{
    element_list    = [];
    
    scale		    = 2;
    
    static CreateSurf = function( new_surface, width, height )
    {
    	if ( !surface_exists( new_surface ) )
    	{
    		new_surface = surface_create( width * scale, height * scale );
    	};
    	
    	return new_surface;
    };
        
    static AddElement = function( item = new hud_item() )
    {
        array_push( element_list, item );
        item.Init();
        return item;
    };
    
    static UpdateElements = function()
    {
        array_foreach( element_list,
        function( item ) 
        { 
            item.Update();
        });
    };
    
    static DrawElements = function()
    {
        static cam_x = 480;
        static cam_y = 270;
        
        init_camera_gui( cam_x, cam_y );
        
        array_foreach( element_list,
        function( item ) 
        { 
            item.Draw();
        });
    };
    
    static HideAll = function()
    {
        array_foreach( element_list,
        function( item ) 
        { 
            item.ElementHide();
        });
    }; 
    
    static ShowAll = function()
    {
        array_foreach( element_list,
        function( item ) 
        { 
            item.ElementShow();
        });
    };
};

function hud_item( element_name = "Generic", _starthidden = true ) constructor
{
    elem_x          = 0;
    elem_y          = 0;      
    elem_x1         = 0;
    elem_y1         = 0;    
    elem_x2         = 0;
    elem_y2         = 0;
    elem_lerpspeed  = 2 / 60;
    elem_rotation   = 0;
    elem_sprite     = FALLBACK_SPRITE;
    elem_imageindex = -1;
    elem_string     = -1;
    elem_value      = -1;
    elem_alpha      = 1;
    elem_fadespeed  = 0.050;
    elem_fadeout    = false;
    elem_fadedelaytime = 0;
    elem_fadedelay  = new cTimer( elem_fadedelaytime );
    bVisible    	= true;
    elem_font       = fnt_test;
    elem_siner      = 0;
    elem_sinamount  = 0.050;
    text_halign     = 0;
    text_valign     = 0;
    elem_name       = element_name;
    elem_lerpedvalue    = false;
    elem_vallerpspeed   = 2 / 60;
    bCanFade = false;
    bStartHidden		= _starthidden;
    
    Init();
    
    static GetName = function()
    {
        return elem_name;
    };
    
    static ElementShow = function()
    {
        bVisible = true;
    };
    
    static ElementHide = function()
    {
        bVisible = false;
    };
    
    static ElementFadeIn = function()
    {
        elem_fadeout = false;
    };
    
    static ElementFadeOut = function()
    {
        elem_fadeout = true;
    };
    
    static SetSpriteFromIndex = function( new_sprite )
    {
        elem_sprite = new_sprite; 
    };   
    
    static SetSinAmount = function( new_value )
    {
        elem_sinamount = new_value; 
    };
    
    static SetImageIndex = function( new_index )
    {
        elem_imageindex = new_index;
    };
    
    static SetFont = function( new_font )
    {
        elem_font = new_font;
    };
    
    static SetValue = function( new_value )
    {
        elem_value = new_value;
    };  
    
    static SetOpacity = function( new_value )
    {
        elem_alpha = new_value;
    };
    
    static LerpValue = function( lerp_value, lerp_speed = 0.50 )
    {
        elem_value = lerp( elem_value, lerp_value, lerp_speed );
    };
    
    static ValueLerpSpeed = function( lerp_speed = 0.50 )
    {
        elem_vallerpspeed = lerp_speed;
    };
    
    static SetLerpSpeed = function( lerpspeed )
    {
        elem_lerpspeed = lerpspeed;
    };
    
    static SetLerpX = function( pos_1, pos_2 = pos_1 )
    {
        elem_x  = pos_1;
        elem_x1  = pos_1;
        elem_x2  = pos_2;
    };  
    
    static SetLerpY = function( pos_1, pos_2 = pos_1 )
    {
        elem_y  = pos_1;
        elem_y1  = pos_1;
        elem_y2  = pos_2;
    };
    
    static Init = function() {
		if ( bStartHidden ) {
			elem_x = elem_x2;
			elem_y = elem_y2;
			bVisible = false;
		}
    }
    
    static Update = function()
    {
        elem_fadedelay.Tick();
        
        if ( !bVisible ) {
            elem_x = lerp( elem_x, elem_x2, elem_lerpspeed );
            elem_y = lerp( elem_y, elem_y2, elem_lerpspeed );
        }
        else {
            elem_x = lerp( elem_x, elem_x1, elem_lerpspeed );
            elem_y = lerp( elem_y, elem_y1, elem_lerpspeed );
        };
        
        if ( elem_lerpedvalue ) {
            LerpValue( elem_value, elem_vallerpspeed );
        };
        
        if ( bCanFade 
        && elem_fadeout ) {
            if ( elem_fadedelay.GetTime() <= 0 ) {
                elem_alpha = lerp( elem_alpha, 0, elem_fadespeed );
                return true;
            };
        }; 
    };
		
	static DrawRect = function( x, y, width = 120, height = 60 )
	{
		var x1 = x;
		var x2 = x + ( width );		
		var y1 = y;
		var y2 = y + ( height );
		
		draw_primitive_begin( pr_trianglestrip );
		draw_vertex_color( x1, y1 - height, c_black, elem_alpha );
		draw_vertex_color( x2, y2 - height, c_black, elem_alpha );
		draw_vertex_color( x1, y1 + height, c_black, elem_alpha );
		draw_vertex_color( x2, y1 + height, c_black, elem_alpha );
		draw_primitive_end();
	};
    
    static Draw = function(){};
};