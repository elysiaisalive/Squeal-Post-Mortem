function initItems() {
    var _item = new cItem()
    .SetName( "invalid", "invalid" )
    .SetDesc( FALLBACK_STRING )
    .SetStackable()
    .SetStackSize( 1, 1024 )
    .Register();

    #region Weapon Items
    var _flashlight = new cWeapon()
    .SetName( "flashlight", LOC_STRING( "#game.itemname.flashlight" ) )
    .SetDesc( LOC_STRING( "#game.itemdesc.flashlight" ) )
    .SetWorldAnimation( FALLBACK_SPRITE )
    .SetUISprite( FALLBACK_SPRITE )
    .SetSlotFlags( SLOT_FLAGS.FL_POUCH | SLOT_FLAGS.FL_MELEE )
    .SetAllowedResources( "battery" )
    .SetResourceAmount( 0, 1 )
    .SetHotkeyable( false )
    .SetUseSound( snd_item_hpupgrade )
    .SetPickupSound( snd_medkit_pickup )
    .Register();
    
    var _c38 = new cWeapon()
    .SetName( "38Colt", LOC_STRING( "#game.itemname.38Colt" ) )
    .SetDesc( LOC_STRING( "#game.itemdesc.38Colt" ) )
    .SetWorldAnimation( FALLBACK_SPRITE )
    .SetUISprite( FALLBACK_SPRITE )
    .SetSlotFlags( SLOT_FLAGS.FL_HOLSTER )
    .SetCanAddResourceFromInventory( false )
    .SetAllowedResources( "38Ammo" )
    .SetResourceAmount( 0, 6 )
    .SetHotkeyable( true )
    .SetUseSound( snd_item_hpupgrade )
    .SetPickupSound( snd_medkit_pickup )
    .Register();
    #endregion
    #region Ammo Items
    var _38ammo = new cItem()
    .SetName( "38Ammo", LOC_STRING( "#game.itemname.38Ammo" ) )
    .SetDesc( LOC_STRING( "#game.itemdesc.38AmmoSmall" ) )
    .SetWorldAnimation( spr_pickup_357 )
    .SetUISprite( spr_pickup_357 )
    .SetStackable()
    .SetStackSize( 3, 32 )
    .SetHotkeyable( false )
    .SetUseSound( snd_item_hpupgrade )
    .SetPickupSound( snd_medkit_pickup )
    .Register();
    _38ammo.OnStackChange = method( _38ammo, function() {
        if ( stackSize <= 8 ) {
            SetDesc( LOC_STRING( "#game.itemdesc.38AmmoSmall" ) );
        }
        else if ( stackSize <= 16 ) {
            SetDesc( LOC_STRING( "#game.itemdesc.38AmmoMedium" ) );
        } 
        else if ( stackSize >= 24 ) {
            SetDesc( LOC_STRING( "#game.itemdesc.38AmmoLarge" ) );
        }
    } );

    var _44ammo = new cItem()
    .SetName( "44Ammo", LOC_STRING( "#game.itemname.44Ammo" ) )
    .SetDesc( LOC_STRING( "#game.itemdesc.44Ammo" ) )
    .SetWorldAnimation( spr_pickup_357 )
    .SetUISprite( spr_pickup_357 )
    .SetStackable()
    .SetStackSize( 4, 32 )
    .SetHotkeyable( false )
    .SetUseSound( snd_item_hpupgrade )
    .SetPickupSound( snd_medkit_pickup )
    .Register();
    
    var _12gaammo = new cItem()
    .SetName( "12gaAmmo", LOC_STRING( "#game.itemname.12gaAmmo" ) )
    .SetDesc( LOC_STRING( "#game.itemdesc.12gaAmmo" ) )
    .SetWorldAnimation( spr_pickup_12GA )
    .SetUISprite( spr_pickup_12GA )
    .SetStackable()
    .SetStackSize( 3, 18 )
    .SetHotkeyable( false )
    .SetUseSound( snd_item_hpupgrade )
    .SetPickupSound( snd_medkit_pickup )
    .Register();
#endregion
    #region Medical Items
    var _bandage = new cItem()
    .SetName( "bandage", LOC_STRING( "#game.itemname.Bandage" ) )
    .SetDesc( LOC_STRING( "#game.itemdesc.Bandage" ) )
    .SetWorldAnimation( FALLBACK_SPRITE )
    .SetUISprite( FALLBACK_SPRITE )
    .SetUseTime( 60 * 3 )
    .SetStackable()
    .SetStackSize( 1, 2 )
    .SetHotkeyable( false )
    .SetUseSound( snd_item_hpupgrade )
    .SetPickupSound( snd_medkit_pickup )
    .Register();
    // ?
    // _item.Use = function( itemUser ) {
    //     var _user = itemUser;
        
    //     if ( instance_exists( _user ) ) {
    //         _user.statuses.ApplyStatusEffect( statusBandageHealing() );
    //     }
    // };
    
    var _morphine = new cItem()
    .SetName( "morphine", LOC_STRING( "#game.itemname.Morphine" ) )
    .SetDesc( LOC_STRING( "#game.itemdesc.Morphine" ) )
    .SetWorldAnimation( FALLBACK_SPRITE )
    .SetUISprite( FALLBACK_SPRITE )
    .SetUseTime( 60 * 1.5 )
    .SetStackable()
    .SetStackSize( 1, 4 )
    .SetHotkeyable( false )
    .SetUseSound( snd_item_hpupgrade )
    .SetPickupSound( snd_medkit_pickup )
    .Register();

#endregion
    #region Functional Items
    var _punchcard = new cItem()
    .SetName( "punchcard", LOC_STRING( "#game.itemname.punchcard" ) )
    .SetDesc( LOC_STRING( "#game.itemdesc.punchcard" ) )
    .SetWorldAnimation( FALLBACK_SPRITE )
    .SetUISprite( FALLBACK_SPRITE )
    .SetUseTime( -1 )
    .SetStackable()
    .SetStackSize( 1, 3 )
    .SetHotkeyable( false )
    .SetUseSound( snd_item_hpupgrade )
    .SetPickupSound( snd_medkit_pickup )
    .Register();

    var _lockpick = new cItem()
    .SetName( "lockpick", LOC_STRING( "#game.itemname.lockpick" ) )
    .SetDesc( LOC_STRING( "#game.itemdesc.lockpick" ) )
    .SetWorldAnimation( FALLBACK_SPRITE )
    .SetUISprite( FALLBACK_SPRITE )
    .SetUseTime( -1 )
    .SetStackable()
    .SetStackSize( 1, 4 )
    .SetHotkeyable( false )
    .SetUseSound( snd_item_hpupgrade )
    .SetPickupSound( snd_medkit_pickup )
    .Register();
    
    var _battery = new cItem()
    .SetName( "battery", LOC_STRING( "#game.itemname.battery" ) )
    .SetDesc( LOC_STRING( "#game.itemdesc.battery" ) )
    .SetWorldAnimation( FALLBACK_SPRITE )
    .SetUISprite( FALLBACK_SPRITE )
    .SetUseTime( -1 )
    .SetStackable()
    .SetStackSize( 1, 10 )
    .SetHotkeyable( false )
    .SetUseSound( snd_item_hpupgrade )
    .SetPickupSound( snd_medkit_pickup )
    .Register();

    var _speedloader = new cItem()
    .SetName( "speedloader", LOC_STRING( "#game.itemname.speedloader" ) )
    .SetDesc( LOC_STRING( "#game.itemdesc.speedloaderEmpty" ) )
    .SetWorldAnimation( FALLBACK_SPRITE )
    .SetUISprite( FALLBACK_SPRITE )
    .SetAllowedResources( "38Ammo", "44Ammo" )
    .SetResourceAmount( 0, 6 )
    .SetHotkeyable( false )
    .SetUseSound( snd_item_hpupgrade )
    .SetPickupSound( snd_medkit_pickup )
    .Register();
    _speedloader.OnResourceChange = method( _speedloader, function() {
        if ( resourceAmount >= maxResourceAmount ) {
            SetDesc( LOC_STRING( "#game.itemdesc.speedloaderFull" ) );
        }
        else if ( resourceAmount <= 6 ) {
            SetDesc( LOC_STRING( "#game.itemdesc.speedloaderHalf" ) );
        }
        else if ( resourceAmount <= 0 ) {
            SetDesc( LOC_STRING( "#game.itemdesc.speedloaderEmpty" ) );
        }
    } );
    #endregion
    #region Puzzle Items
    #endregion
}