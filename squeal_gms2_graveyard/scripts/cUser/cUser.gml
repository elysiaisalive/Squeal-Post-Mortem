/* 
    The user class is an abstract representation of the physical person in the computer chair.
	     _________
	    / ======= \
	   / __________\
	  | ___________ |
	  | | -       | |
	  | |    :3   | |
	  | |_________| |________________________
	  \=____________/   brian macdonald      )
	  / """"""""""" \                       /
	 / ::::::::::::: \                  =D-'
	(_________________)
	https://www.asciiart.eu/
    
    The abstract user, also referred to as 'the player', is the object that will send inputs to the game.
*/
function cUser() class {
    // The instance the user is currently sending inputs to. Specifically used for moving a character INGAME.
    controlledInstance = undefined;
    
    // This is most likely going to be unused, but in the case that it isn't, this will be used for multiple controllers.
    userPort = 0;
    /*
    	User state. Used for time tracking 
    	User state should be changed upon entering a level/loading a save.
    	
    	We should only ever be tracking time when;
    		- In a level.
    		- Not in the pause menu.
    		- Not in any UI that isn't related to the current map/level/area.
    */
    userState = USERSTATUS.IDLE;
    
    /* 
    	userInventory. Should only be instanced when a game profile is loaded.
    	
    	inventory - The inventory that contains all the items the User instance picks up via the controlled Player.
    	keys - The inventory "slot" that all collected keys go inside when on NORMAL difficulty.
    	
    */
    inventory = new cUserInventory();
    
    testStorage = new cInventory();
    
    // Players personal item storage. 1 Horizontal Row because we want to display it vertically!
    storage = new cInventory( 1, 6 );
    
    static createEntityController = function( position = new cTransform2D(), _config = {} ) {
        _config[$ "user"] = self;
        _config[$ "type"] ??= obj_player;
        
        var _entity = instance_create_depth( 0, 0, -HEIGHT.HEAD, _config[$ "type"], _config );
        
        controlledInstance = _entity;
        weak_ref_create( controlledInstance );
        return _entity;
    }
    // Called every gamestep. Used for tracking time while ingame.
    static TrackTime = function() {
    	switch( userState ) {
    		case USERSTATUS.IDLE :
    			break;
    		case USERSTATUS.INGAME :
    			break;
    	}
    }
    static GetUserMoveDirection = function() {
    	return point_direction( 0, 0, inputRightHeld() - inputLeftHeld(), inputDownHeld() - inputUpHeld() );
    }    
    static GetUserXAxis = function() {
    	return point_direction( 0, 0, inputRightHeld() - inputLeftHeld(), 0 );
    }
    static GetUserYAxis = function() {
    	return point_direction( 0, 0, 0, inputDownHeld() - inputUpHeld() );
    }
    // Function that is called every gamestep. Used for processing Inputs to the controlled Instance.
    static Listen = function() {
        if ( !instance_exists( controlledInstance ) ) {
            return;
        }
        
        if ( input_check_pressed( "key_flashlight" ) ) {
        	sfx_play_at( controlledInstance, snd_flashlight_on, false, controlledInstance.transform.position.x, controlledInstance.transform.position.y );
        	controlledInstance[$ "flashlightOn"] = !controlledInstance[$ "flashlightOn"];
        }

		#region Cursor
		global.mousex_real = controlledInstance.transform.position.x + ( global.mousex_raw * global.look_factor );
		global.mousey_real = controlledInstance.transform.position.y + ( global.mousey_raw * global.look_factor );
	
		global.mousex = global.mousex_real;
		global.mousey = global.mousey_real;
		
		// Set the character direction to the mouse position
		var _cursorDir = point_direction( controlledInstance.transform.position.x, controlledInstance.transform.position.y, global.mousex, global.mousey );
		var _turnSpeed = controlledInstance.turnSpeed * controlledInstance.currentWeapon.turnSpeedModifier;
		
		controlledInstance[$ "transform"].RotateTo( _cursorDir, _turnSpeed );
		#endregion
		#region Movement
		var _controllerVelocity = point_distance( 0, 0, inputRightHeld() - inputLeftHeld(), inputDownHeld() - inputUpHeld() ) * 1.125;
		var _controllerMoveDirection = GetUserMoveDirection();
		
		controlledInstance[$ "movementDirection"] = _controllerMoveDirection;
		controlledInstance[$ "charVelocity"] = min( 1, _controllerVelocity );
		
		controlledInstance[$ "charWalkSpd"] = clamp( controlledInstance[$ "charWalkSpd"], controlledInstance[$ "minWalkSpeed"], controlledInstance[$ "maxWalkSpeed"] );
		
		var _moveRate = 0.1;
		
		if ( mouse_wheel_up() ) {
			controlledInstance[$ "charWalkSpd"] += _moveRate;
		}
		if ( mouse_wheel_down() ) {
			controlledInstance[$ "charWalkSpd"] -= _moveRate;
		}
		
		// obj_camera_control.camera_zoomfactor = clamp( obj_camera_control.camera_zoomfactor, 0.15, 0.75 );
		// obj_camera_control.LerpZoom( obj_camera_control.camera_zoomfactor * controlledInstance[$ "charWalkSpd"] );
		
		// If we are not moving at all.
		if ( _controllerVelocity == 0 ) {
			var _xMove = ( inputRightHeld() - inputLeftHeld() );
			var _yMove = ( inputDownHeld() - inputUpHeld() );
			
			_controllerMoveDirection = point_direction( 0, 0, _xMove, _yMove );
			_controllerVelocity = min( 1, point_distance( 0, 0, _xMove, _yMove ) );
			controlledInstance[$ "currentWalkDir"] = point_direction( 0, 0, _xMove, _yMove );
		}
		#endregion
		#region Mouse Input
		var _equippedItem = controlledInstance[$ "currentWeapon"];
		var _triggerRate = 0.01;
		
		#region Weapon Trigger
		if ( is_instanceof( _equippedItem, cWeapon ) ) {
			if ( input_check_pressed( "key_primary" ) ) {
				_equippedItem.PrimaryFirePressed();
			}
			if ( input_check( "key_primary" )
			&& _equippedItem.canFire ) {
				_equippedItem.PrimaryFireHeld();
			 	controlledInstance[$ "currentTriggerTime"] = clamp( controlledInstance[$ "currentTriggerTime"], 0, _equippedItem.triggerPullTime );
				controlledInstance[$ "currentTriggerTime"] += _triggerRate;
				
				// Trigger Pull.
				if ( controlledInstance[$ "currentTriggerTime"] >= _equippedItem.triggerPullTime ) {
					// Firerate.
					if ( controlledInstance[$ "currentTriggerReset"] <= 0 ) {
						_equippedItem.OnTriggerFire();
						
						// Shooting / Attacking!
						switch( _equippedItem.fireMode ) {
							case FIREMODE.AUTO :
								controlledInstance[$ "currentTriggerTime"] = 0;
								controlledInstance[$ "currentWeapon"].canFire = true;
								break;
							case FIREMODE.SEMI :
								controlledInstance[$ "currentWeapon"].canFire = false;
								break;
						}
						// controlledInstance[$ "currentWeapon"].ammo -= 1;
						controlledInstance[$ "currentTriggerReset"] = _equippedItem.fireRate;
					}
				}
			 }
			 if ( !input_check( "key_primary" ) ) {
			 	controlledInstance[$ "currentTriggerTime"] = max( 0, controlledInstance[$ "currentTriggerTime"] - _triggerRate );
			 	controlledInstance[$ "currentTriggerReset"] = 0;
			 	controlledInstance[$ "currentWeapon"].canFire = true;
			 }
			 if ( input_check_released( "key_primary" ) ) {
			 	_equippedItem.PrimaryFireReleased();
			 }
		}
		 
		 //if ( controlledInstanceWeapon.needsRechamber
		 //&& controlledInstanceWeapon.isChambered ) {
		 //	if ( input_check_pressed( "key_primary" ) ) {
		 //		controlledInstance[$ "currentWeapon"].isChambered = true;
		 //	}
		 //}
		 #endregion
		
		/* 
		    This is going to be changed at some point to be more granular
		    INCLUDING the attack scripts.
		*/
		// switch( controlledInstanceWeapon.fireMode ) {
		// 	case FIREMODE.SEMI :
		// 		if ( inputLeftMousePressed() ) {
		// 		//charAttackWeapon( true );
		// 		}
		// 		break;
		// 	case FIREMODE.AUTO :
		// 		if ( inputLeftMouseHeld() ) {
		// 		//charAttackWeapon( true );
		// 		}
		// 		break;
		// }
		#endregion
    }
    
    // OnStart() is invoked whenever the user accesses or enters a level.
    static OnStart = function() {
        obj_hud.inventory.SetInventoryTarget( inventory );
    }
    static OnLoad = function() {
    	SetControllerInstance( obj_player );
    	camera_set_target( obj_player );
    }
    
    #region Get
    static GetUserPort = function() {
    	return userPort;
    }
    static GetInventory = function() {
        return inventory;
    }
    static GetStorage = function() {
    	return storage;
    }
    static GetController = function() {
        if ( controlledInstance != undefined ) {
            return controlledInstance;
        }
        else {
        	return undefined;
        }
    }   
    static GetControllerPosition = function() {
        if ( controlledInstance != undefined ) {
            return { x : controlledInstance.x, y : controlledInstance.y };
        }
    }
    static GetPort = function() {
        return userPort;
    }
    #endregion
    #region Set
    // Should be invoked whenever the ingame player exists and the game is loaded.
    static SetInventory = function( _inventory ) {
        inventory = _inventory;
        return self;
    }
    static SetControllerInstance = function( inst ) {
        controlledInstance = inst;
        return self;
    }
    #endregion
    /* 
    	Honestly I'm not entirely sure if these will stay. Initially, User input methods were a way to abstract input. 
    	But the INPUT library is already abstracted and kind of does its own things that act as a 'program entry point' with player indexes and whatnot.
    	
    	HEAVY emphasis on maybe deprecating these in favour of just sticking to the regular ol' input methods coz this is kinda dumb.
    */
    #region UI Input Methods
    static inputUILeftMouseHeld = function() {
        return input_mouse_check( "key_ui_confirm" );
    }    
    static inputUILeftMousePressed = function() {
        return input_mouse_check_pressed( "key_ui_confirm" );
    }    
    static inputUILeftMouseReleased = function() {
        return input_mouse_check_released( "key_ui_confirm" );
    }
    
    static inputUIRightMouseHeld = function() {
        return input_mouse_check( "key_ui_deny" );
    }    
    static inputUIRightMousePressed = function() {
        return input_mouse_check_pressed( "key_ui_deny" );
    }
    static inputUIRightMouseReleased = function() {
        return input_mouse_check_released( "key_ui_deny" );
    }
    
    static inputUILeftHeld = function() {
        return input_check( "key_ui_left", userPort );
    }
    static inputUILeftPressed = function() {
        return input_check_pressed( "key_ui_left", userPort );
    }    
    static inputUIinputUILeftReleased = function() {
        return input_check_released( "key_ui_left", userPort );
    }  

    static inputUIRightHeld = function() {
        return input_check( "key_ui_right", userPort );
    }
    static inputUIRightPressed = function() {
        return input_check_pressed( "key_ui_right", userPort );
    }    
    static inputUIRightReleased = function() {
        return input_check_released( "key_ui_right", userPort );
    }   
    
    static inputUIUpHeld = function() {
        return input_check( "key_ui_up", userPort );
    }
    static inputUIUpPressed = function() {
        return input_check_pressed( "key_ui_up", userPort );
    }    
    static inputUIUpReleased = function() {
        return input_check_released( "key_ui_up", userPort );
    }  

    static inputUIDownHeld = function() {
        return input_check( "key_ui_down", userPort );
    }
    static inputUIDownPressed = function() {
        return input_check_pressed( "key_ui_down", userPort );
    }    
    static inputUIDownReleased = function() {
        return input_check_released( "key_ui_down", userPort );
    }
    #endregion
    #region Controller Input Methods
    // Base Input
    static inputLeftMouseHeld = function() {
        return input_mouse_check( "key_primary" );
    }    
    static inputLeftMousePressed = function() {
        return input_mouse_check_pressed( "key_primary" );
    }    
    static inputLeftMouseReleased = function() {
        return input_mouse_check_released( "key_primary" );
    }
    
    static inputRightMouseHeld = function() {
        return input_check( "key_secondary" );
    }    
    static inputRightMousePressed = function() {
        return input_check_pressed( "key_secondary" );
    }
    static inputRightMouseReleased = function() {
        return input_check_released( "key_secondary" );
    }
    
    static inputLeftHeld = function() {
        return input_check( "key_left", userPort );
    }
    static inputLeftPressed = function() {
        return input_check_pressed( "key_left", userPort );
    }    
    static inputLeftReleased = function() {
        return input_check_released( "key_left", userPort );
    }  

    static inputRightHeld = function() {
        return input_check( "key_right", userPort );
    }
    static inputRightPressed = function() {
        return input_check_pressed( "key_right", userPort );
    }    
    static inputRightReleased = function() {
        return input_check_released( "key_right", userPort );
    }   
    
    static inputUpHeld = function() {
        return input_check( "key_up", userPort );
    }
    static inputUpPressed = function() {
        return input_check_pressed( "key_up", userPort );
    }    
    static inputUpReleased = function() {
        return input_check_released( "key_up", userPort );
    }  

    static inputDownHeld = function() {
        return input_check( "key_down", userPort );
    }
    static inputDownPressed = function() {
        return input_check_pressed( "key_down", userPort );
    }    
    static inputDownReleased = function() {
        return input_check_released( "key_down", userPort );
    }
    
    // Special Keys
    static inputInteract = function() {
        return input_check( "key_interact" );
    }    
    static inputInteract = function() {
        return input_check_pressed( "key_interact" );
    }    
    static inputInteract = function() {
        return input_check_released( "key_interact" );
    }
    #endregion
}

function user() {
    static staticUser = new cUser();
    return staticUser;
}