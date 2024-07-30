/// @self {cGUI|cUIInventoryItems}
function cUIInventoryItems() extends cGUI() class {
    inventory = undefined;
    slotW = 24;
    slotH = 24;
    slotX = 480 / 2;
    slotY = 270 / 2;
    slotOffsetX = slotW;
    slotOffsetY = slotH;
    
    mouseVisualPos = new Vector2( 0, 0 );
    selectedVisualPos = new Vector2( 0, 0 );
    
    hoveredSlot = undefined;
    hoveredSlotPos = new Vector2( 0, 0 );
    selectedSlot = undefined;
    draggedItem = undefined;
    lastSlotPos = new Vector2( 0, 0 );
    enabled = false;
    
    // Dimensions of the camera for rendering the inventory screen to the GUI layer
    static camX = 480;
    static camY = 270;
    
    SetInventoryTarget( user().inventory );//temp
    
    static Cancel = function() {
        draggedItem = undefined;
        enabled = false;
        
        return self;
    }
    static SetInventoryTarget = function( target_inventory ) {
        if ( !is_struct( target_inventory ) 
        || !is_instanceof( target_inventory, cInventory ) ) {
            print( "Failed to set inventory target as target is not a valid inventory" );
            return;
        }
        
        inventory = target_inventory;
    }
    static ResetAllTargets = function() {
        hoveredSlot = undefined;
        selectedSlot = undefined;
        draggedItem = undefined;
    }
    static OnInventoryOpen = function() {
        
    };
    static OnInventoryClose = function() {
        ResetAllTargets();
    };
    static GetItemUnderMouse = function() {
        if ( !is_undefined( inventory ) ) {
            var _rowSize = array_length( inventory.itemGrid );
            var _colSize = array_length( inventory.itemGrid[1] );
            var _mouse_posX = input_mouse_x();
            var _mouse_posY = input_mouse_y();
            var _itemUnderMouse = undefined;
            
            for( var row = 0; row < _rowSize; ++row ) {
                for ( var col = 0; col < _colSize; ++col ) {
                    var _x1 = slotX + ( slotOffsetX ) * ( row );
                    var _y1 = slotY + ( slotOffsetY ) * ( col );
                    var _x2 = _x1 + slotW;
                    var _y2 = _y1 + slotH;
                    
                    if ( point_in_rectangle( _mouse_posX, _mouse_posY, _x1, _y1, _x2, _y2 ) ) {
                		_itemUnderMouse = inventory.itemGrid[row, col];
                    }
                }
            }
        }
        
        return _itemUnderMouse;
    }
    static GetSlotUnderMouse = function() {
        if ( !is_undefined( inventory ) ) {
            var _rowSize = array_length( inventory.itemGrid );
            var _colSize = array_length( inventory.itemGrid[1] );
            var _mouse_posX = input_mouse_x();
            var _mouse_posY = input_mouse_y();
            var _slot = new Vector2( 0, 0 );
            
            for( var row = 0; row < _rowSize; ++row ) {
                for ( var col = 0; col < _colSize; ++col ) {
                    var _x1 = slotX + ( slotOffsetX ) * ( row );
                    var _y1 = slotY + ( slotOffsetY ) * ( col );
                    var _x2 = _x1 + slotW;
                    var _y2 = _y1 + slotH;
                    
                    if ( point_in_rectangle( _mouse_posX, _mouse_posY, _x1, _y1, _x2, _y2 ) ) {
                		_slot.x = row;
                		_slot.y = col;
                    }
                }
            }
        }
        
        return _slot;
    }
    static Tick = function() {
        if ( enabled ) {
            if ( !is_undefined( inventory ) ) {
            	hoveredSlot = GetItemUnderMouse();
            	hoveredSlotPos.x = GetSlotUnderMouse().x;
            	hoveredSlotPos.y = GetSlotUnderMouse().y;
            	
            	selectedVisualPos.x = lerp( selectedVisualPos.x, slotX + slotOffsetX * ( hoveredSlotPos.x ), 0.35 );
            	selectedVisualPos.y = lerp( selectedVisualPos.y, slotY + slotOffsetY * ( hoveredSlotPos.y ), 0.35 );
            	
            	#region Item Discarding and Hotkey slot assignment
            	// Discarding should only be possible when we're not dragging an item
            	if ( !is_undefined( hoveredSlot )
            	&& is_undefined( draggedItem )
            	&& user().GetController().currentWeapon != hoveredSlot ) {
                    if ( input_check_pressed( "key_inv_discard" ) ) {
                        // Discard the item and remove its reference from the hotbar
                		inventory.DiscardItemAt( GetSlotUnderMouse(), user().GetControllerPosition() );
                		inventory.hotbar.RemoveItem( hoveredSlot.itemName );
                    }                    
                    
                    // Assigning hotkeys to items that have the property 'canAssignToHotkey'
                    if ( hoveredSlot.canAssignToHotkey ) {
                    	switch( keyboard_lastchar ) {
                    		case "1" :
                    		case "2" :
                    		case "3" :
                    		case "4" :
                    		    var _pressedSlotIndex = real( keyboard_lastchar );
                    
                                if ( keyboard_check_pressed( _pressedSlotIndex ) ) {
                                    /* 
                                        If we have no item assigned to the key, assign it to the slot. If we already have an item, clear it.
                                    */
                                    if ( !inventory.hotbar.SlotIsAssigned( _pressedSlotIndex ) ) {
                                        print( $"new item assigned to slot : {_pressedSlotIndex}" );
                                		inventory.hotbar.AssignToSlot( hoveredSlot.itemName, _pressedSlotIndex );
                                    }
                                    else {
                                        inventory.hotbar.ClearSlot( _pressedSlotIndex );
                                    }
                                }
                                break;
                    	}
                    }
            	}
            	#endregion
                #region Item Dragging Logic
                if ( input_check_pressed( "key_ui_confirm" )
                && is_undefined( draggedItem ) ) {
                    lastSlotPos = new Vector2( GetSlotUnderMouse().x, GetSlotUnderMouse().y );
                    draggedItem = GetItemUnderMouse();
                }
                else if ( input_check_pressed( "key_ui_confirm" )
                && !is_undefined( draggedItem ) ) {
                    if ( inventory.ItemIsResource( hoveredSlot ) ) {
                        if ( !inventory.AttemptAddResource( lastSlotPos.x, lastSlotPos.y, hoveredSlotPos.x, hoveredSlotPos.y ) ) {
                            // If we did not success in adding a resource because the destination is full, then just swap.
                            inventory.SwapItem( lastSlotPos.x, lastSlotPos.y, hoveredSlotPos.x, hoveredSlotPos.y );
                        }
                    }
                    else {
                        inventory.SwapItem( lastSlotPos.x, lastSlotPos.y, hoveredSlotPos.x, hoveredSlotPos.y );
                    }
                    
                    draggedItem = undefined;
                }
                #endregion
                if ( input_check_pressed( "key_right" ) ) {
                    hoveredSlotPos.x += 1 % array_length( inventory.itemGrid );
                } 
                
                if ( input_check_pressed( "key_left" ) ) {
                    hoveredSlotPos.x -= 1 % array_length( inventory.itemGrid );
                }
                
                if ( input_check_pressed( "key_down" ) ) {
                    hoveredSlotPos.y += 1 % array_length( inventory.itemGrid[1] );
                }  
                
                if ( input_check_pressed( "key_up" ) ) {
                    hoveredSlotPos.y -= 1 % array_length( inventory.itemGrid[1] );
                }
            }
            else {
                return;
            }
        }
    }
    static DrawDebug = function() {
        if ( enabled ) {
            if ( !is_undefined( inventory ) ) {
                var _rowSize = array_length( inventory.itemGrid );
                var _colSize = array_length( inventory.itemGrid[1] );
                var _mouse_posX = input_mouse_x();
                var _mouse_posY = input_mouse_y();
                
                for( var row = 0; row < _rowSize; ++row ) {
                    for ( var col = 0; col < _colSize; ++col ) {
                        var _x1 = slotX + ( slotOffsetX ) * ( row );
                        var _y1 = slotY + ( slotOffsetY ) * ( col ); 
                        
                        var _highlightX = slotX + ( slotOffsetX ) * ( hoveredSlotPos.x );
                        var _highlightY = slotY + ( slotOffsetY ) * ( hoveredSlotPos.y );
                        var _x2 = _x1 + slotW;
                        var _y2 = _y1 + slotH;
                        var _offset_x = slotOffsetX / 2;
                        var _offset_y = slotOffsetY / 2;
                        
                        var _currentSlot = inventory.itemGrid[row, col];
                        
                        draw_set_color( hoveredSlot==undefined ? c_blue : c_black );
                        draw_roundrect( _x1, _y1, _x2, _y2, false );
                        draw_set_color( c_white );
                        draw_roundrect( _x1, _y1, _x2, _y2, true );
                        draw_set_color( c_lime );
                        draw_roundrect( _highlightX, _highlightY, _highlightX + slotW, _highlightY + slotH, true );
                        draw_set_color( c_white );
                        
                        if ( !is_undefined( inventory.itemGrid[row, col] ) ) {
                            var _item = inventory.itemGrid[row, col];
                            
                            draw_sprite_ext( _item.displaySprite, -1, _x1 + _offset_x, _y1 + _offset_y, 1, 1, 0, c_white, 1 );
                            if ( _item.isStackable ) {
                                draw_text( _x1, _y1, _item.stackSize );
                            }                            
                            if ( _item.isResource ) {
                                draw_text( _x1, _y1, _item.resourceAmount );
                            }
                        }
                    }
                }
                
                if ( !is_undefined( draggedItem ) ) {
                    draw_sprite( draggedItem.displaySprite, -1, selectedVisualPos.x, selectedVisualPos.y );
                }
                
                if ( !is_undefined( hoveredSlot ) ) {
                    draw_set_valign( fa_top );
                    draw_set_halign( fa_left );
                    draw_set_font( fnt_test );
                    var _displayString = hoveredSlot.descString;
                    
                    draw_set_color( c_black );
                    draw_rectangle( slotX + ( slotW * _rowSize ), slotY, slotX * string_width( _displayString ), slotY * string_height( _displayString ) , false );
                    draw_set_color( c_white );
                    draw_text_ext( slotX + ( slotW * _rowSize ), slotY, _displayString, -1, ( slotW * _rowSize ) );
                }
                
                draw_text( _x1, _y1, $"{hoveredSlotPos.x}, {hoveredSlotPos.y}" );
                
                draw_text( _mouse_posX, _mouse_posY, $"{hoveredSlot != undefined ? hoveredSlot.displayName : ""}" );
                draw_circle( _mouse_posX, _mouse_posY, 2, false );
            }
        }
    }
}