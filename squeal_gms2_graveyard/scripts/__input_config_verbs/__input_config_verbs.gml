//Input defines the default profiles as a macro called 
//This macro is parsed when Input boots up and provides the baseline bindings for your game
//
//  Please edit this macro to meet the needs of your game!
//
//The root struct called __input_config_verbs() contains the names of each default profile
//Default profiles then contain the names of verbs. Each verb should be given a binding that is
//appropriate for the profile. You can create bindings by calling one of the input_binding_*()
//functions, such as input_binding_key() for keyboard keys and input_binding_mouse() for
//mouse buttons
 
return {
    keyboard_and_mouse : {
    	// Ingame
		key_up				: [input_binding_key( vk_up ),    input_binding_key( "W" )],
		key_down			: [input_binding_key( vk_down ),  input_binding_key( "S" )],
		key_left			: [input_binding_key( vk_left ),  input_binding_key( "A" )],
		key_right			: [input_binding_key( vk_right ), input_binding_key( "D" )],
		
		key_primary			: input_binding_mouse_button( mb_left ),
		key_secondary		: input_binding_mouse_button( mb_right ),
		
		// Hotkeys
		key_hot0			: input_binding_key( vk_0 ),
		key_hot1			: input_binding_key( vk_1 ),
		key_hot2			: input_binding_key( vk_2 ),
		key_hot3			: input_binding_key( vk_3 ),
		
		key_interact		: input_binding_key( "E" ),
		key_reload			: input_binding_key( "R" ),
		key_flashlight		: input_binding_key( "F" ),
		key_ability1		: input_binding_key( "F" ),
		key_inventory		: input_binding_key( vk_enter ),
		key_unholster		: input_binding_key( vk_alt ),
		key_altfire			: input_binding_mouse_button( 9 ),
		key_zoom			: input_binding_key( vk_shift ),
		key_lockon			: input_binding_mouse_button( mb_middle ),
		key_strafe			: input_binding_key( vk_control ),
		key_execute			: input_binding_key( vk_space ),
		key_dooropen		: input_binding_mouse_wheel_up(),
		key_doorclose		: input_binding_mouse_wheel_down(),
		
		// Inventory
		key_inv_discard		: input_binding_key( "Q" ),
		
		// UI
		key_ui_confirm		: [input_binding_mouse_button( 1 ), input_binding_key( vk_enter )],
		key_ui_deny			: [input_binding_mouse_button( 2 ), input_binding_key( vk_backspace )],
		key_ui_up			: [input_binding_mouse_wheel_up(), input_binding_key( vk_up )],
		key_ui_down			: [input_binding_mouse_wheel_down(), input_binding_key( vk_down )],
		key_ui_left			: [input_binding_key( "Q" ), input_binding_key( vk_left )],
		key_ui_right		: [input_binding_key( "E" ), input_binding_key( vk_right )],
    },
    
    gamepad : {
    }
}