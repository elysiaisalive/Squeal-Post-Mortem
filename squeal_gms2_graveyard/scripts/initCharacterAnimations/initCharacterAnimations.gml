function initCharacterAnimations() {
    globalvar animTable;
    animTable = {
    	dummy:{
    	    animations:{},
    	},
    	joeact1:{
    	    animations:{},
    	}, 
        ripper:{
    	    animations:{},
    	},
    	hazmat:{
    	    animations:{},
    	},
    	hazmatenforcer:{
    	    animations:{},
    	},
    }
    preinit_tagged_animations( "dummy" );
    preinit_tagged_animations( "joeact1" );
    preinit_tagged_animations( "ripper" );
    preinit_tagged_animations( "hazmat" );
    preinit_tagged_animations( "hazmatenforcer" );
}

/// @param      {string}        character_tag       The character TAG we will be loading to automatically populate its table entry with animations
function preinit_tagged_animations( character_tag ) {
    var _anim_array = tag_get_assets( character_tag );
    var _char_string = string_lower( character_tag );
    var _asset_arr = tag_get_asset_ids( character_tag, asset_sprite );

    // Looping through every single asset with the character tag and intializing a generic animation
    for( var i = 0; i < array_length( _asset_arr ); ++i ) {
        var _asset_name = string_lower( sprite_get_name( _asset_arr[i] ) );

        if ( string_pos( "spr" + "_" + _char_string + "_", _asset_name ) != -1 ) {
            var _anim_key = string_replace_all( _asset_name, "spr" + "_" + _char_string + "_", "" );
            var _sprite = _asset_arr[i];

            // We initialize with 0 anim speed for now, we can set these properties later manually.
            animTable[$ _char_string].animations[$ _anim_key] ??= animation_init_looped( _sprite, 0 );
        }
    }

    print( string( "\ninitialized [{0}] took {1}ms", character_tag, ( get_timer() ) / 1000 ) );
}

/// @param      {string}     character_key       The name of the character
/// @param      {struct}     struct_ref          The animation struct to push to the animation table
/// @param      {string}     animation_key       The animation key name to be referenced by other functions
function add_animation_to_index( character_key, struct_ref, animation_key ) {
    // Lowercasing the strings so we don't have to worry about retreiving undefined objects
    character_key = string_lower( character_key );
    animation_key = string_lower( animation_key );
    
    animTable[$ character_key].animations[$ animation_key] ??= struct_ref ?? FALLBACK_ANIMATION;
}

/* 
    USAGE :
        example 1;
        When referencing an animation key from inside of a struct.
        get_animation_from_index( character, currentItem.walk );
        
        example 2;
        Manually inputting animation key.
        get_animation_from_index( character, "AnimationWalk" );
*/
/// @param      {string}     character_key       The name of the character
/// @param      {string}     animation_key       The animation key name to be fetched
/// @return     {struct}     Returns the animation struct found in the characters animation key
function get_animation_from_index( character_key, animation_key ) {
    character_key = string_lower( character_key );
    animation_key = string_lower( animation_key );
    
    if ( animation_exists( character_key, animation_key ) ) {
        return animTable[$ character_key].animations[$ animation_key];
    }
    else {
        return FALLBACK_ANIMATION;
    }
}

/// @param      {string}     character_key          The name of the character
/// @param      {string}     animation_key          The animation key name to be fetched
/// @param      {struct}     properties_struct      Struct containing all the valid animation properties
/// @returns    {struct}     Returns a reference to the modified animation struct
function modify_animation_from_index( character_key, animation_key, properties_struct ) {
    // Lowercasing the strings so we don't have to worry about retreiving undefined objects
    character_key = string_lower( character_key );
    animation_key = string_lower( animation_key );
    var _target_anim = get_animation_from_index( character_key, animation_key );
    
    _target_anim.animType ??= properties_struct[$ "animType"];
    _target_anim.animStartIndex ??= properties_struct[$ "animStartIndex"];
    _target_anim.animSpd ??= properties_struct[$ "animSpd"];
    _target_anim.animRepeats ??= properties_struct[$ "animRepeats"];
    _target_anim.animNext ??= properties_struct[$ "animNext"];
    
    return _target_anim;
}

/// @param      {string}     character_key          The name of the character
/// @param      {string}     animation_key          The animation key name to be fetched
/// @returns    {bool}
function animation_exists( character_key, animation_key ) {
    character_key = string_lower( character_key );
    animation_key = string_lower( animation_key );
    
    if ( !is_undefined( animTable[$ character_key] ) ) {
        if ( struct_exists( animTable[$ character_key], "animations" ) ) {
            var _animation_data = animTable[$ character_key].animations;
            
            if ( !is_undefined( _animation_data[$ animation_key] ) ) {
                return true;
            }
        }
    }
    else {
        return false;
    }
}

/// @param {string}     map
/// @param {string}     properties
function ds_map_access( map, properties ) {
    var propsArr = string_split( properties, ".", false );
    var current = map;
    
    // Iterate over the properties array
    for ( var i = 0; i < array_length( propsArr ); i++ ) {
        var prop = propsArr[i];
        
        print( string( "Current {0}, Prop {1}", current, prop ) );
        
        // Set current property and return
        if ( !is_undefined( current ) ) {
            current = ds_map_find_value( current, prop );
        }
        else {
            print( "\n#########\nNO MAP\n#########\n", false );
        }
    }
    
    print( $"Found {current}!" );
    return current;
}