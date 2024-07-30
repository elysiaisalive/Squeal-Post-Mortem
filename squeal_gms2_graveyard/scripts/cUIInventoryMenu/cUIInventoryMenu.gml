function cUIInventoryMenu() extends cGUI() class {
    currentMenu = 0;
    lastMenu = 0;
    subMenus = [];
    enabled = false;
    
    Init();
    
    static Init = function() {
        AddMenu( new cUIInventoryItems() );
        AddMenu( new cUIInventoryNotes() );
    }
    static AddMenu = function( menu ) {
        array_push( subMenus, menu );
    }
    static OnOpen = function() {

    }
    static OnClose = function() {

    }
    static InventoryIsOpen = function() {
        return enabled != false;
    }
    static Tick = function() {
        var _subMenuCount = array_length( subMenus ) - 1;
        
        currentMenu = clamp( currentMenu, 0, _subMenuCount );
        
        var _selectedMenu = subMenus[currentMenu];
        
        if ( input_check_pressed( "key_inventory" ) ) {
            OnOpen();
            _selectedMenu.Cancel();
            lastMenu = currentMenu;
            subMenus[lastMenu].enabled = !enabled;
        	enabled = !enabled;
        	
        	camera_enable_follow( !enabled );
        	user().GetController().EnableMovement( !enabled );
        }
        
        if ( !enabled 
        && input_check_pressed( "key_inventory" ) ) {
            OnClose();
        }
        
        if ( enabled ) {
            if ( input_check_pressed( "key_ui_left" ) ) {
                _selectedMenu.Cancel();
                --currentMenu;
                _selectedMenu.enabled = true;
            }        
            if ( input_check_pressed( "key_ui_right" ) ) {
                _selectedMenu.Cancel();
                ++currentMenu;
                _selectedMenu.enabled = true;
            }
            
            if ( currentMenu > _subMenuCount ) {
                currentMenu = 0;
            }            
            if ( currentMenu < _subMenuCount ) {
                currentMenu = _subMenuCount - 1;
            }
            
            if ( _subMenuCount != -1 ) {
                _selectedMenu.Tick();
            }
        }
    }
    static Draw = function() {
        var _subMenuCount = array_length( subMenus );
        
        var i = 0;
        repeat( _subMenuCount ) {
            ++i;
            draw_set_halign( fa_center );
            draw_set_valign( fa_top );
            draw_circle( 480/2 + ( 16 * i ), 16, 4, ( currentMenu!=i-1 ) );
        }
        
        if ( _subMenuCount != -1 ) {
            subMenus[currentMenu].DrawDebug();
        }
    }
}