/// @self {cItem|object}
function cItem() class {
	#region Item Properties
	/* 
	======
	METADATA
	======
		itemName <- The name that other entities refer to the item by.
		displayName <- A name that should be used by UI.
		descString <- A description. Used in UI.
		worldSprite <- Sprite in-world.
		displaySprite <- Sprite used in UI.
		animIndex <- Unused.
	======
	INVENTORY DATA
	======
		isStackable <- Whether or not the item can stack.
		stackSize <- The starting stack size.
		maxStackSize <- The max stack.
		
		isBreakable <- Whether or not this item will 'break' on hitting 0 durability points.
		durability   
		maxDurability
		
		slotTags <- Flags for the available slots that this item can be assigned to.
		
		isResource <- Whether or not this game should treat this item as a resource. Affects things like stacking, etc.
		allowedResources <- A list of items that this item can accept as valid resources.
		currentResource <- The name of the current item being used as a resource. There can ONLY BE A SINGLE TYPE !!!
		resourceAmount <- If more than 0, than the item is able to be 'used' by other interactions. Useful for Weapon Magazines.
		maxResourceAmount <- Max resource.
		
		useTime <- The amount of time ( in seconds ) that an item takes to invoke its 'Use' action.
		isUsable <- If true, then this item can be used.
		canAssignToHotkey <- If true, then the player can assign a hotkey from 1-4 and 'equip' or 'use' this item.
		sizeHeight <- Unused.
		sizeHeight <- Unused.
	======
	SOUND DATA
	======
		selectSound <- Plays when an item is clicked in UI.
		stackSound <- Plays when an item is stacked in UI.
		stackFullSound <- Plays when an item reaches full stack in UI.
		breakSound <- Plays when an item breaks.
		pickupSound <- Plays when an item is picked up.
		useSound <- Plays when an item is used.
	*/
	itemName				= "item";
	displayName				= self.itemName;
	descString				= FALLBACK_STRING;
	worldSprite				= FALLBACK_SPRITE;
	displaySprite			= self.worldSprite;
	animIndex				= 0;
	
	durability              = 100;
	maxDurability           = 100;
	isBreakable             = false;
	
	slotFlags                = new cFlags( SLOT_FLAGS.FL_POUCH );
	
	isResource              = false;
	canAddResourceInventory = true;
	allowedResources        = [""];
	currentResource         = undefined;
	resourceAmount          = 0;
	maxResourceAmount       = 0;
	
	isUsable                = false;
	useTime                 = 60 * 1;
	
	isStackable				= false;
    stackSize				= 1;
    maxStackSize			= self.stackSize;
    sizeWidth				= 1; // The width and height the item takes up in a grid-inventory
    sizeHeight				= 1;
    
    selectSound             = -1;
    stackSound              = -1;
    stackFullSound          = -1;
    breakSound              = -1;
	pickupSound 			= snd_item_interact;
	useSound 				= snd_item_hpupgrade;
	
	canAssignToHotkey		= false;
	#endregion
    #region Class Methods
    static Register = function() {
    	array_push( global.itemList, self );
    	print( $"Registered Item {self.itemName}" );
        return self;
    }
    // Called when the player "Uses" an item.
    /// @param {instance} itemUser
    static Use = function( itemUser ) {};
    static OnUse = function( itemUser ){};
    static OnDiscard = function(){};
    static OnStackChange = function(){};
    static OnResourceChange = function(){};
    #endregion
    #region Data Serialization
    static Serialize = function() {
    	var _data = {};
    	var _structKeys = variable_struct_names_count( self );
    	var _structValues = variable_struct_get_names( self );
    	
    	for( var i = 0; i < _structKeys; ++i ) {
    		_data[$ $"{_structValues[i]}"] = _structValues[i];
    	}
    	
    	print( _data );
    }
    static Deserialize = function( data ) {
    	var _decodedJSON = SnapFromJSON( data );
    }
    #endregion
    #region Set
    static SetSlotFlags = function( flags ) {
    	slotFlags.SetFlags( flags );
    	return self;
    }
    static SetCanAddResourceFromInventory = function( _enabled = true ) {
    	canAddResourceInventory = _enabled;
    	return self;
    }
    static SetAllowedResources = function( itemNames ) {
    	isResource = true;
    	
    	for( var i = 0; i < argument_count; ++i ) {
    		var _item = argument[i];
    		
    		array_push( allowedResources, _item );
    	}
    	
    	return self;
    }
    static SetResourceAmount = function( amount, _maxAmount = amount ) {
    	resourceAmount = amount;
    	maxResourceAmount = _maxAmount;
    	
    	if ( resourceAmount <= 0 ) {
    		currentResource = undefined;
    	}
    	return self;
    }
    /// @desc Sets the current resource as well as an amount if the item matches what is on our allowed list.
    /// This is very useful for cases like when a speedloader needs to only contain ONE type of an item.
    static AddResource = function( itemNameString, _amount = 0 ) {
    	var _validate = ValidateResource( itemNameString );

    	if ( _validate ) {
    		currentResource = itemNameString;
    		resourceAmount = min( resourceAmount + _amount, maxResourceAmount );
    	}
    	return self;
    }
    static RemoveResource = function( itemNameString, _amount = 0 ) {
    	var _validate = ValidateResource( itemNameString );
    	
    	if ( _validate ) {
    		currentResource = itemNameString;
    		resourceAmount = min( 0, resourceAmount - _amount, maxResourceAmount );
    		
    		if ( resourceAmount <= 0 ) {
    			currentResource = undefined;
    		}
    	}
    	return self;
    }
    
    static SetHotkeyable = function( _canAssign = true ) {
    	canAssignToHotkey = _canAssign;
    	return self;
    }
    static SetName = function( worldName, _displayName ) {
    	itemName = worldName;
    	displayName = _displayName;
    	return self;
    }
    static SetDesc = function( description ) {
    	descString = description;
    	return self;
    }
    static SetUISprite = function( animation, _animationFrame = 0 ) {
    	displaySprite = animation;
    	return self;
    }
    static SetWorldAnimation = function( animation, _animationFrame = 0 ) {
    	worldSprite = animation;
    	animIndex = _animationFrame;
    	return self;
    }
    static SetStackable = function( _stackable = true ) {
    	isStackable = _stackable;
    	return self;
    }    
    static SetStackSize = function( defaultStack, maxStack = defaultStack ) {
    	isStackable = true;
    	stackSize = defaultStack;
    	maxStackSize = maxStack;
    	return self;
    }
    static SetUseTime = function( time ) {
    	useTime = time;
    	return self;
    }
    static SetPickupSound = function( sound ) {
    	pickupSound = sound;
    	return self;
    }    
    static SetUseSound = function( sound ) {
    	useSound = sound;
    	return self;
    }
    #endregion
    #region Get
    static GetName = function() {
    	return itemName;
    }
    /// @desc Returns the string of the current resource being used.
    static GetResource = function() {
    	return currentResource;
    }    
    static GetCanAddResourceFromInventory = function() {
    	return canAddResourceInventory;
    }
    static IsResource = function() {
    	return isResource;
    }
    static ValidateResource = function( itemNameString ) {
    	var _allowedListSize = array_length( allowedResources );
    	var _result = false;
    	
    	for( var i = 0; i < _allowedListSize; ++i ) {
    		var _resourceName = allowedResources[i];
    		
    		if ( _resourceName == itemNameString ) {
    			_result = true;
    		}
    	}
    	return _result;
    }
    #endregion
    
    return self;
};