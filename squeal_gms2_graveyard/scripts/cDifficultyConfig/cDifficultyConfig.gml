/* 
Difficulty Config Class.
This is instanced in the game profile and saved to the profile path.
*/
function difficultyNormal() {
    var _config = new cDifficultyConfig( "Normal" )
    .SetValue( "saveRulesConfig", "savesRequireDisk", false )
    .SetValue( "inventoryConfig", "inventoryPauseOnOpen", true )
    .SetValue( "inventoryConfig", "playerBackpackReloads", true );
    return _config;
}
function difficultyHardcore() {
    var _config = new cDifficultyConfig( "Hardcore" )
    .SetValue( "saveRulesConfig", "savesRequireDisk", true )
    .SetValue( "ammoConfig", "flashlightRequiresBatteries", true )
    .SetValue( "inventoryConfig", "playerBackpackReloads", false )
    .SetValue( "healthConfig", "playerCanLoseMaxHP", true )
    .SetValue( "healthConfig", "playerCanBleedHP", true );
    return _config;
}
function difficultyNightmare() {
    var _config = new cDifficultyConfig( "Nightmare" )
    .SetValue( "saveRulesConfig", "savesRequireDisk", true )
    .SetValue( "ammoConfig", "flashlightRequiresBatteries", true )
    .SetValue( "inventoryConfig", "playerBackpackReloads", false )
    .SetValue( "healthConfig", "playerCanLoseMaxHP", true )
    .SetValue( "healthConfig", "playerCanBleedHP", true );
    return _config;
}
//
function cDifficultyConfig( name = "Normal" ) class {
    // Default 'normal' difficulty values.
    difficultyName = name;
    #region Save Station Rules
    saveRulesConfig = {
        savesRequireDisk : false,
        savesRefreshHealth : true, // Happens once per save station. Per hour of gameplay.
        savesRefreshTimer : 60 * 3000
    };
    #endregion
    #region Inventory and Ammo Rules
    inventoryConfig = {
        inventoryPauseOnOpen : true,
        playerBackpackReloads : true, // If the player can use the 'pouch' to reload.
        playerPouchMaxSlots : 10,
        playerStorageMaxSlots : 16
    };
    ammoConfig = {
        flashlightRequiresBatteries : false,
        playerMaxColtAmmo : 32,
        playerMaxShotgunAmmo : 18,
        playerColtSmallPickupSize : 3,
        playerShotgunSmallPickupSize : 3,        
        playerColtMediumPickupSize : 6,
        playerShotgunMediumPickupSize : 6,        
        playerColtLargePickupSize : 8,
        playerShotgunLargePickupSize : 9,
    };
    #endregion
    #region Health and Damage Rules
    healthConfig = {
        playerMaxHP : 200,
        playerCanLoseMaxHP : false,
        playerMaxHPLossThreshold : 0.25, // If you go below this threshold ...
        playerMaxHPLossAmount : 25, // You will lose this much max hp ! ( Capped at some number. )
        playerCanBleedHP : true,
        playerBleedDmg : 5,
        playerHeavyBleedDmg : 10,
        playerBleedMoveSpeedModifier : 0.10,
        playerBandageHPRestore : 0.25,
        playerMorphineHPRestore : 0.75,
        playerMorphineODThreshold : 2, // How many times morphine can be injected within a time span before you overdose and die.
        playerMorphineODCooldown : 60 * 120, // How long in seconds the player has to wait before using morphine again ( will be telegraphed with some sort of screen effect )
        
        playerColtDmg : 8,
        playerShotgunDmg : 16,
        playerBulletDmgSlowdown : 0.25,
        playerMeleeDmgSlowdown : 0.50,
    };
    #endregion
    
    configFile = {};
    configFile[$ "saveRulesConfig" ] = saveRulesConfig;
    configFile[$ "inventoryConfig" ] = inventoryConfig;
    configFile[$ "ammoConfig" ] = ammoConfig;
    configFile[$ "healthConfig" ] = healthConfig;
    
    static SetValue = function( sectionName, propertyKey, propertyValue ) {
    	var _propertyKey = string_lower( propertyKey );
    	var _propertyValueType = typeof( struct_get( configFile[$ sectionName], _propertyKey ) );
    	
    	if ( struct_get( configFile[$ sectionName], _propertyKey ) ) {
    		var _heldPropertyType = typeof( configFile[$ sectionName][$ _propertyKey] );
    		
    		if ( _propertyValueType == _heldPropertyType ) {
    			configFile[$ sectionName][$ _propertyKey] = propertyValue;
    		}
    	}
    	
    	return self;
    }
    
    static Save = function() {
        var _skillFilePath = PROFILE_PATH + $"/{global.currentProfile}";
        var _skillFileName = $"/difficulty.cfg";
        var _skillFile = _skillFilePath + _skillFileName;
        var _configJSON = SnapToJSON( configFile, true, true );
        var _buffer = buffer_create( 1, buffer_grow, 1 );
        
        buffer_write( _buffer, buffer_text, $"Don't edit this unless you've already beat the game : )\n" );
        buffer_write( _buffer, buffer_text, _configJSON );
        buffer_save( _buffer, _skillFile );
    }
    return self;
}