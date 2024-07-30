/// @self {cWeapon|object}
/// @desc The Weapon class. Extends the item class.
/* 
      Weapons are a special type of Item that have variables related to ; Trigger pull, left and right button functionality,
      animations such as walking, shooting etc, HUD sprites, projectiles, range, damage etc...
      All of their data is strictly related to Player and Enemy interaction.
      
      Items contain a reference to their current user. When the item is in the inventory the reference to its user is reset to UNDEFINED.
      When an Item/Weapon calls 'Equip( USER_INSTANCE )' it will set the reference, play the equip animation and from there it will be useable.
      
      Example ; 
        The Flashlight.
        The Flashlight is a melee weapon that has some melee parameters, as well as special left mouse button functionality that activates its light.
        Since it is also an item however though, it can be used in tandem to check for special things like if the player has another weapon equipped, the flashlight
        can be turned on while holding the weapon if it allows it.
        The flashlight is also able to take a RESOURCE. It takes Batteries so it can be powered!
        
        Every single gun invokes the following functions when the USER object presses the BOUND LEFT KEY ;
        Primary();
        OnPressPrimary();
        
        Primary() - function is responsible for ;
          - Checking the weapon type ( Gun, Melee )
          - Setting the current item Users animation to the appropriate one based on the action.
          - IF MELEE : Checking the radius and range, as well as other melee specific attack parameters.
          - Spawning a projectile based on what the weapon defined it as
          - Invoking OnPressPrimary() <- A user defined function that does anything specified.
        
        // =================
        Characters retrieve animations as such ;
        - currentEquippedItem OR hoveredItem or whatever
        > > > animationPlayer.queueAnimation( animationList.GetAnimation( currentEquippedItem.GetName(), "WALK" ) );
        // =================
        
        Animations in the global animation lists for characters are sorted like ;
        character0 {
        	weapon0 {
        		idle {},
        		walk {},
        		etc...
        	}
        }
        
        Animation Frame Callbacks can be defined as such ;
        animation.SetCallback( frame, function() {
        	spawn_shell();
        } )
        
        These animations can also be specified by the user to have certain frame callbacks for spawning projectiles etc.
*/
function cWeapon() extends cItem() class {
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
	itemName				= "weapon";
	#endregion
	#region Class Properties
	/*
	======
	TRIGGER DATA
	======
		triggerPullTime <- How long the trigger must be held before executing its 'OnTriggerPull' method.
		triggerPressed <- If the trigger is currently being pressed.
		canFire <- If true, then the weapons 'trigger' can be fired again.
		fireMode <- Firemodes. Might be unused.
		burstCount <- How many times the weapon will repeat its attacks.
		currentBurstCount <- The amount of times a weapon has been fired, can be used as a factorial when determining firerate ramp. Resets to 0 When the trigger is no longer pressed
		fireRate <- The rate in RPM that projectiles are created at
		fireRateRamp <- The amount of time the trigger needs to be held before the weapon will fire ( default 1 )
		fireRateRampIncrease <- The amount the minimum ramp will decrease each time a bullet is fired ( default 0 )
		fireRateMin <- The minimum amount of ramp we need in order to fire the gun ( default 1 )
		
		Weapons with a low ramp, higher min ramp and a ramp increase based on shots fired will act like a chaingun
	======
	ATTACK DATA
	======
		attackType <- The 'type' of attack. Used when creating gore VFX for melee.
		hpDamage <- The amount of HP damage the target will have inflicted.
		armourDamage <- The amount of AP damage the target will have inflicted.
		penetration <- The total amount of targets this weapon can affect at once
		spread <- The angle in degrees that the weapon will attack with. Acts as 'accuracy' for guns and 'swing radius' for melee.
		range <- The amount in pixels that the weapon will attack with and look for targets in. 
	======
	CHARACTER DATA
	======
		equipSpeed <- How fast this weapon equips/unequips.
		turnSpeedModifier <- A percentage modifier that the equipped characters turnSpeed will decrease by.
	======
	GUI DATA
	======
		reticleAnimation <- The sprite/animation the ingame cursor will use when this item is selected.
	*/
	triggerPullTime = fpsToDecimal( 1 );
	triggerPressed = false;
	burstCount = 1;
	currentBurstCount = 0;
	
	canFire = true;
	fireMode = FIREMODE.SEMI;
	fireRate = fpsToDecimal( 6 );
	fireRateMax = fireRate;
	fireRateMin = 1;
	fireRateRamp = 1;
	fireRateRampIncrease = 0;
	
	equipSpeed = fpsToDecimal( 15 );
	turnSpeedModifier = 0.30;

	attackType = ATTACKTYPE.NONLETHAL;
	hpDamage = 0;
	armourDamage = 0;
	stunAmount = 1;
	penetration = 1;
	spread = 0;
	range = 16 * 8;
	
	mods = {};
	
	reticleAnimation = -1;
	#endregion
    #region Data Serialization
    #endregion
    #region Set
	static AddMod = function( _mod ) {
		if ( !is_instanceof( _mod, cWeaponMod ) ) {
			show_error( $"Cannot add {_mod} as it is not a valid mod class.", true );
			return;
		}
		
		mods[$ instanceof( _mod )] = _mod;
		
		return _mod;
	}
	static RemoveMod = function( modKey ) {
		mods[$ modKey] = undefined;
	}
	static ApplyMods = function() {
		struct_foreach( mods, function( i ) {
			hpDamage += i.damageMod;
			spread -= i.accuracyMod;
			reloadSpeed += reloadSpeedMod;
			range += i.rangeMod;
			ammoMax += i.ammoCapacityMod;
		} );
	}
    #endregion
    #region Get
	static GetMod = function( modKey ) {
		return mods[$ modKey];
	}
    #endregion
    #region Class Methods
    /*
        OnTriggerFire() <- Invoked when the trigger is fully pulled. USE THIS TO SPAWN BULLETS N MELEE CODE N STUFF.
    */
    static PrimaryFirePressed = function(){};
    static SecondaryFirePressed = function(){};
    static PrimaryFireHeld = function(){};
    static SecondaryFireHeld = function(){};
    static PrimaryFireReleased = function(){};
    static SecondaryFireReleased = function(){};
    static OnTriggerFire = function(){};
    #endregion
}