function cGUIGroup() constructor {
    groups = [];
    
    static Add = function( _ui ) {
        
    }
}
function cGUIController() constructor {
    elements = [];
    selectedElement = 0;
    focusedElement = noone;

    static Init = function() {};

    static Tick = function() {
        for( var i = 0; i < array_length( elements ); ++i ) {
            // Only listen for input if the element is active.
            if ( elements[i].bIsActive ) {
                elements[i].Listen(); // Input ticking
                elements[i].Tick(); // Ticking for display elements and other misc.
            }
        }
    }
    
    static Draw = function() {
        for( var i = 0; i < array_length( elements ); ++i ) {
            elements[i].Draw();
            elements[i].DrawHint(); // Drawing Hint
            
            if ( global.debug ) {
                elements[i].DrawDebug(); 
            }
        }
    }
    
    // Disable all elements
    static DisableAll = function() {
        for( var i = 0; i < array_length( elements ); ++i ) {
            Disable( elements[i] );
        }
    };
    
    static ActivateAll = function() {
        for( var i = 0; i < array_length( elements ); ++i ) {
            Activate( elements[i] );
        }
    }; 
    
    static DisableGroup = function( _group = UI_GROUPS.DEFAULT ) {
        for( var i = 0; i < array_length( elements ); ++i ) {
            if ( elements[i].group == _group ) {
                Disable( elements[i] );
            }
        }
    }   
    
    static ActivateGroup = function( _group = UI_GROUPS.DEFAULT ) {
        for( var i = 0; i < array_length( elements ); ++i ) {
            if ( elements[i].group == _group ) {
                Activate( elements[i] ); 
            }
        }
    } 
    
    static DisableAllExcept = function( _groupexception = UI_GROUPS.DEFAULT ) {
        for( var i = 0; i < array_length( elements ); ++i ) {
            if ( elements[i].group != _groupexception ) {
                Disable( elements[i] );
            }
        }
    }
    
    static GetCurrentVisibleGroup = function() {
        for( var i = 0; i < array_length( elements ); ++i ) {
            if ( elements[i].bIsVisible ) {
                var _visible = elements[i].group;
            }
        }
        
        return _visible;
    }
    
    // Maybe a bad func name, but the purpose of this function is to disable every other type except itself.
    static SetAllGroupVisibilityExcept = function( _groupexception = UI_GROUPS.DEFAULT, _visible = false ) {
        for( var i = 0; i < array_length( elements ); ++i ) {
            if ( elements[i].group != _groupexception ) {
                elements[i].bIsVisible = _visible;
            }
        }
    }
    
    static SetGroupVisibility = function( _group = UI_GROUPS.DEFAULT, _visible = false ) {
        for( var i = 0; i < array_length( elements ); ++i ) {
            if ( elements[i].group == _group ) {
                elements[i].bIsVisible = _visible;
            }
        }
    }
    
    // Set a groups visibility and then activate them at the same time
    static SetGroupVisibilityEnable = function( _group = UI_GROUPS.DEFAULT ) {
        for( var i = 0; i < array_length( elements ); ++i ) {
            if ( elements[i].group == _group ) {
                elements[i].bIsVisible = true;
                
                elements[i].Activate();
            }
        }
    }
    
    static SetGroupVisibilityDisable = function( _group = UI_GROUPS.DEFAULT ) {
        for( var i = 0; i < array_length( elements ); ++i ) {
            if ( elements[i].group == _group ) {
                elements[i].bIsVisible = false;
                
                elements[i].Disable();
            }
        }
    }
    
    static Disable = function( _elem ) {
        _elem.Disable();
    }   
    
    static Activate = function( _elem ) {
        _elem.Activate();
    }
    
    static AddElements = function() {
        for( var i = 0; i < array_length( elements ); ++i ) {
            elements[i].controller = self;
        }
    };
    
    // Adding elements to the controller 
    static AddElement = function( _target = new cGUIElement(), _group = "default" ) {
        if ( !is_undefined( _target ) ) {
            array_push( elements, _target );
        }
        else {
            return;
        }
    };
}

function cGUIElement( _id ) constructor {
    controller = -1;
    group = UI_GROUPS.DEFAULT;
    elemID = _id;
    bIsActive = true;
    bIsVisible = true;
    bIsClickable = false;
    bMouseHovered = false;
    bCanFadeout = false;
    hoverSnd = -1;
    clickSnd = -1;
    hoverTimer = new cTimer( 60 * 0.75, false, true );
    hint = ""; // String that will be display when hovered over an element for 1.5 seconds
    bShowHint = false;
    
    /* 
        HINT KEYS 
    	#Game.Cfg.Options		"Configure your ingame experience"
    	
    	#Game.Cfg.MasterVol		"Volume of EVERYTHING."
    	#Game.Cfg.MusicVol		"Volume of music"
    	#Game.Cfg.SFXVol		"Volume of sound effects like guns, UI, voices, etc."
    	#Game.Cfg.AmbVol		"Volume of ambient sounds like wind, indoor drones, etc."
    	
    	#Game.Cfg.ZoomMode		"The input type to toggle, hold or hold to disable zooming."
    	#Game.Cfg.Sensitivity	"Mouse Sensitivity"
    	#Game.Cfg.RawInput		"If enabled the game will receive raw device input"
    	
    	#Game.Cfg.ParticlesOn	"If enabled particles will be drawn to the screen"
    	#Game.Cfg.MaxParticles	"Max amount of particles that can be displayed on screen"
    	#Game.Cfg.SmoothLights	"If enabled all lights will be rendered more pixelated"
    	#Game.Cfg.Decals		"If enabled blood / debris decals are allowed to be drawn to the screen"
    	#Game.Cfg.RefreshRate	"!EXPERIMENTAL! Changes game refresh rate, and subsequently some game logic may not work correctly"
    	#Game.Cfg.ShakerOn		"If enabled the camera will shake around from explosions, shooting etc."
    	#Game.Cfg.Shaker		"Intensity of screenshake"
    	
    	#Game.Cfg.NoSick		"If enabled screenshake and distortion effects will be turned off"
    	#Game.Cfg.Lang			"Your language of preference ( that is included in the lang folder )"
    	
    	#Game.Cfg.Secret		"What, you think there was supposed to be a secret here or something?"
    */
        
    // Positions for moving the ui offscreen
    x = 0;
    y = 0;
    x1 = x;
    y1 = y;
    x2 = 0;
    y2 = 0;
    
    lerp_spd = 0.10;
    fade_spd = 0.10;
    fade_delaytime = 0;
    
    value = -1;
    maxvalue = value;
    
    alpha = 1;
    
    width = 0;
    height = 0;
    
    static AtSecondPos = function() {
        if ( ( x == x2 ) && ( y == y2 ) ) {
            return true;
        }
        else {
            return false;
        }
    }
    
    static SetGroup = function( _group = UI_GROUPS.DEFAULT ) {
        group = _group;
    }
    
    static GetGroup = function() {
        return group;
    }
    
    static IsFocused = function() {
        if ( bMouseHovered ) {
            return true;
        }
    }
    
    static SetHint = function( _hint ) {
        hint = _hint;
    }
    
    static GetHint = function() {
        if ( string_length( hint ) > 0 ) {
            return hint;
        }
        else {
            print( "Hint Is Empty..." );
            return;
        }
    }
    
    static Tick = function() {
        if ( !bIsVisible ) {
            x = lerp( x, x2, lerp_spd );
            y = lerp( y, y2, lerp_spd );
        }
        else {
            x = lerp( x, x1, lerp_spd );
            y = lerp( y, y1, lerp_spd );
        };
        
        if ( bCanFadeout 
        && alpha > 0 ) {
            alpha = lerp( alpha, 0, fade_spd );
        }
        else if ( alpha < 1 ) {
            alpha = lerp( alpha, 1, fade_spd );   
        }
        
        if ( bMouseHovered ) {
            hoverTimer.Unpause();
            hoverTimer.Tick();
        }
        else {
            hoverTimer.ResetTimer( false, true );
            bShowHint = false;
        }
        
        if ( hoverTimer.GetTime() <= 0 ) {
            bShowHint = true;
        }
    };
    
    static DrawHint = function() {
        var _mouse_x = input_mouse_x();
        var _mouse_y = input_mouse_y();
        
        if ( bShowHint
        && bIsActive ) {
            draw_text_transformed( _mouse_x, _mouse_y, hint, 0.5, 0.5, 0 );
        }
    }
    
    // Setting initial x, y and button collisions
    static SetBounds = function( _w, _h ) {
        width = _w;
        height = _h;
    }
    
    static SetMovePositions = function( _x = x, _y = y, _x2 = _x, _y2 = _y ) {
        x = _x;
        y = _y;
        x1 = _x;
        y1 = _y;
        x2 = _x2;
        y2 = _y2;
    }
    
    static SetValue = function( _val, _maxval = _val ) {
        value = _val;
        maxvalue = _maxval;
    }
    
    static GetValue = function() {
        return value;
    }
    
    static Disable = function() {
        bIsActive = false;
        bMouseHovered = false;
        
        OnDisable();
    }   
    
    static Activate = function() {
        bIsActive = true;
        
        OnActivate();
    }
    
    static OnDisable = function() {};
    static OnActivate = function() {};
    
    static DoPress = function(){};
    
    // Listening for events from a controller or other.
    static Listen = function() {
        if ( controller ) {
            // Mouse
            if ( point_in_rectangle( input_mouse_x(), input_mouse_y(), x, y, x + width, y + height ) ) {
                controller.focusedElement = self;
                bMouseHovered = true;
            }
            else {
                controller.focusedElement = noone;
                bMouseHovered = false;
            }
            
            if ( bMouseHovered
            && controller.focusedElement == self
            && input_check_pressed( "key_ui_confirm" ) ) {
                DoPress();
            }
        }
    };
    
    static DrawDebug = function() {
        draw_set_halign( fa_left );
        draw_set_valign( fa_top );
        
        draw_set_color( bMouseHovered ? c_lime : c_red );
        draw_rectangle( x, y, x + width, y + height, true );
        draw_set_color( c_white );
    };
    
    static Draw = function(){};
    
    static Update = function() {};
}

function cGUIElementButtonText( _id ) : cGUIElement( _id ) constructor {
    text = "";
    
    static Draw = function() {
        draw_text( x, y, text );
    };
}

function cGUIElementButtonSprite( _id ) : cGUIElement( _id ) constructor {
    icon = -1;
    hoverIcon = -1;
    
    static SetIcon = function( _icon, _hovericon = -1 ) {
        icon = _icon;
        hoverIcon = _hovericon;
    }
    
    static Draw = function() {
        // Default draw
        if ( icon != -1 
        || hoverIcon != -1 ) {
            draw_sprite( ( bMouseHovered ? hoverIcon : icon ), -1, x, y );
        }
    };
}

function cGUIElementSprite( _id ) : cGUIElement( _id ) constructor {
    icon = -1;
    bIsAnimated = false;
    animIndex = 0;
    animSpd = 0;
    
    static Tick = function() {
        if ( bIsAnimated ) {
            animIndex += animSpd;
        }
    }
    
    static SetAnimation = function( _spr = spr_default, _spd = 0.10, _index = 0 ) {
        bIsAnimated = true;
        animIndex = _index;
        animSpd = _spd;
        icon = _spr;
    }
    
    static Draw = function() {
        draw_set_halign( fa_left );
        draw_set_valign( fa_top );
        
        draw_sprite( icon, animIndex, x, y );
    };
}

function cGUIElementButtonToggle( _id ) : cGUIElementButtonText( _id ) constructor {
    static DoPress = function() {
        if ( is_bool( value ) ) {
            value = !value;
        }
    }
    
    static DrawDebug = function() {
        draw_set_halign( fa_left );
        draw_set_valign( fa_top );
        
        draw_set_color( value ? c_aqua : c_red );
        draw_rectangle( x, y, x + width, y + height, value );
        draw_set_color( c_white );
    };
}

function cGUIElementSlider( _id ) : cGUIElement( _id ) constructor {
    value = 0;
    maxvalue = value;
    
    // If the slider will be precise and work on floating points
    precise = true;
    interval = 0.01;
    bIsBeingDragged = false;
    
    knobSprite = -1;
    knobW = 0;
    knobH = 0;
    
    static SetKnobBounds = function( _w, _h ) {
        knobW = _w;
        knobH = _h;
    }
    
    static SetMoveInterval = function( _val = 0.01 ) {
        interval = _val;
    }
    
    static Listen = function() {
        if ( controller ) {
            // Mouse
            if ( point_in_rectangle( input_mouse_x(), input_mouse_y(), x, y, x + width, y + height ) ) {
                controller.focusedElement = self;
                window_set_cursor( cr_handpoint );
                bMouseHovered = true;
            
                if ( input_check( "key_ui_confirm" ) ) {
                    bIsBeingDragged = true;
                }
                else {
                    bIsBeingDragged = false;
                }
            }
            else {
                controller.focusedElement = noone;
                window_set_cursor( cr_arrow );
                bIsBeingDragged = false;
                bMouseHovered = false;
            }
            
            // Scroll wheel control + left right
            if ( bMouseHovered 
            && ( input_check( "key_ui_up" ) || input_check( "key_ui_right" ) ) ) {
                // Changing the value by the movement interval ( 0.01 by default )
                value += interval;
            }
            else if ( bMouseHovered 
            && ( input_check( "key_ui_down" ) || input_check( "key_ui_left" ) ) ) {
                value -= interval;
            }
            
            value = clamp( value, 0, maxvalue );
            
            if ( bIsBeingDragged ) {
                var _x = abs( x - mouse_x );
                var _move_amnt = _x / width;
                
                _move_amnt = clamp( _move_amnt, 0, 1 );
                
                value = _move_amnt * maxvalue;
                
                if ( !precise ) {
                    if ( value <= ( maxvalue / 4 ) ) {
                        value = floor( value );
                    }
                    else {
                       value = ceil( value ); 
                    }
                }
                else {
                    value = value; 
                }
            }
        }
    }
    
    static DrawDebug = function() {
        draw_set_halign( fa_left );
        draw_set_valign( fa_top );
        
        draw_set_color( bMouseHovered ? c_lime : c_red );
        draw_set_alpha( alpha );
        draw_rectangle( x, y, x + width, y + height, true );
        
        var _knobpos_x = x + ( value * width / maxvalue );
        
        draw_circle( _knobpos_x, y + 4, 6, false );
        draw_set_alpha( 1 );
        draw_set_color( c_white );
        
        draw_text( x + ( width + 4 ), y - ( height / 2 ), string( elemID ) );
        draw_text( x + 4, y - 4, string( value ) );
    };
    
    static Draw = function() {
        var _knobpos_x = x + ( value * width / maxvalue );
        
        if ( knobSprite != -1 ) {
            draw_sprite( knobSprite, -1, _knobpos_x, y + 4 );
        }
    }
}

function cGUIElementFilePath( _id ) : cGUIElement( _id ) constructor {
    /*
    
        Basic idea is that this element will have a folder button + text field for manual specification of a path
    
    */
    filePath = "";
    fileExtension = "";
    
    maxPathSize = 12;
    
    bIsEditingPath = false;
    bButtonIsHovered = false;
    
    buttonX = 0;
    buttonY = 0;
    buttonW = 0;
    buttonH = 0;
    
    static Listen = function() {
        if ( controller ) {
            
            if ( point_in_rectangle( input_mouse_x(), input_mouse_y(), x, y, x + width, y + height ) ) {
                bMouseHovered = true;
            }
            else {
                bIsEditingPath = false;
                bMouseHovered = false;
            }
            
            if ( point_in_rectangle( input_mouse_x(), input_mouse_y(), buttonX, buttonY, buttonX + buttonW, buttonY + buttonH ) ) {
                bButtonIsHovered = true;
            }
            else {
                bButtonIsHovered = false;
                bIsEditingPath = false;
            }
        }
    }
    
    static SetButtonBounds = function( _x, _y, _w, _h ) {
        buttonX = _x;
        buttonY = _y;
        buttonW = _w;
        buttonH = _h;
    }
    
    static SetExtension = function( _ext = "*.png" ) {
        fileExtension = _ext;
    }
    
    static Tick = function() {
        file_dnd_set_enabled( bMouseHovered );
    }
    
    static DoPress = function() {
        open_folder( APPDATA_PATH );
    }
    
    static DrawDebug = function() {
        draw_set_color( bMouseHovered ? c_lime : c_red );
        draw_rectangle( x, y, x + width, y + height, true );
        
        var _file_str = string( filePath );
        var _displayed_str = _file_str;
        
        // This shouldn't work!
        if ( string_length( _file_str ) > maxPathSize ) {
            var _new_str = string_delete( _displayed_str, maxPathSize, string_length( _displayed_str ) );
            _displayed_str = string_insert( "...", _new_str, string_length( _displayed_str ) );
        }
        
        draw_text( x, y, string( _displayed_str ) );
        
        draw_set_color( bButtonIsHovered ? c_blue : c_red );
        draw_rectangle( buttonX, buttonY, buttonX + buttonW, buttonY + buttonH, true );
        draw_set_color( c_white );
    }
}

// ugh.
function cGUIElementSelector( _id ) : cGUIElement( _id ) constructor {
    options = [];
    selected_option = 0;
    
    bButton1Hovered = false;
    bButton2Hovered = false;
    
    buttonX1 = 0;
    buttonY1 = 0;
    buttonW1 = 0;
    buttonH1 = 0; 
    
    buttonX2 = 0;
    buttonY2 = 0;
    buttonW2 = 0;
    buttonH2 = 0;
    
    static SetButtonBounds = function( _x1, _y1, _w1, _h1, _x2, _y2, _w2, _h2 ) {
        buttonX1 = _x1;
        buttonY1 = _y1;
        buttonW1 = _w1;
        buttonH1 = _h1; 
        
        buttonX2 = _x2;
        buttonY2 = _y2;
        buttonW2 = _w2;
        buttonH2 = _h2;
    }
    
    static Listen = function() {
        if ( controller ) {
            var elem_hovered = point_in_rectangle( input_mouse_x(), input_mouse_y(), x, y, x + width, y + height );
            var button1_hovered = point_in_rectangle( input_mouse_x(), input_mouse_y(), buttonX1, buttonY1, buttonX1 + buttonW1, buttonY1 + buttonH1 );
            var button2_hovered = point_in_rectangle( input_mouse_x(), input_mouse_y(), buttonX2, buttonY2, buttonX2 + buttonW2, buttonY2 + buttonH2 );
            var options_len = array_length( options );
            
            // Mouse
            if ( elem_hovered ) {
                controller.focusedElement = self;
                bMouseHovered = true;
            }
            else {
                controller.focusedElement = noone;
                bMouseHovered = false;
            }
            
            if ( input_check_pressed( "key_ui_left" ) ) {
                --selected_option;
            }
            else if ( input_check_pressed( "key_ui_right" ) ) {
                ++selected_option;
            }
            
            if ( button1_hovered ) {
                if ( input_check_pressed( "key_ui_confirm" ) ) {
                    --selected_option;
                }
                
                bButton1Hovered = true;
            }
            else {
               bButton1Hovered = false; 
            }
            
            if ( button2_hovered ) {
                if ( input_check_pressed( "key_ui_confirm" ) ) {
                    ++selected_option;
                }
                
                bButton2Hovered = true;
            }
            else {
               bButton2Hovered = false; 
            }
            
            if ( selected_option > options_len ) {
                selected_option = 0;
            }
            
            selected_option = clamp( selected_option, 0, array_length( options ) );
        }
    };
    
    static AddOptions = function( _option ) {
        for( var i = 0; i < argument_count; ++i ) {
            array_push( options, argument[i] );
        }
    }
    
    static DrawDebug = function() {
        draw_set_color( bMouseHovered ? c_lime : c_red );
        draw_rectangle( x, y, x + width, y + height, true );
        draw_set_color( bButton1Hovered ? c_blue : c_red );
        draw_rectangle( buttonX1, buttonY1, buttonX1 + buttonW1, buttonY1 + buttonH1, true );
        draw_set_color( bButton2Hovered ? c_blue : c_red );
        draw_rectangle( buttonX2, buttonY2, buttonX2 + buttonW2, buttonY2 + buttonH2, true );
        draw_set_color( c_white );
        draw_set_halign( fa_center );
        draw_text( x + width / 2, y, array_empty( options ) ? string( options[selected_option] ) : string( "" ) );
    }
}