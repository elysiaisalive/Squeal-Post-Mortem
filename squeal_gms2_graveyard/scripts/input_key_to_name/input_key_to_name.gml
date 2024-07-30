function input_key_to_name( keycode ) 
{
	// Returns the keycode string when a vk keycode is input
	
    static keys = array_create( 255, undefined )
    static done = false
    
    if ( done )
	{
        return keys[ clamp( keycode, 0, 255 ) ]
    }
    else
    {
        done			= true;
        keys[vk_none]	= "none"
        
        keys[vk_mouse1] = "mouse1"
        keys[vk_mouse2] = "mouse2"
        keys[vk_mouse3] = "mouse3"
        keys[vk_mouse4] = "mouse4"
        keys[vk_mouse5] = "mouse5"
        
        keys[vk_backspace] = "backspace"
        keys[vk_tab] = "tab"
        
        keys[vk_enter] = "enter"
        
        keys[vk_shift] = "any_shift"
        keys[vk_control] = "ctrl"
        keys[vk_alt] = "alt"
        keys[vk_pause] = "pause"
        keys[vk_capital] = "capslock"
        
        keys[vk_escape] = "escape"
        
        keys[vk_space] = "space"
        
        keys[vk_pageup] = "pageup"
        keys[vk_pagedown] = "pagedown"
        keys[vk_end] = "end"
        keys[vk_home] = "home"
        keys[vk_left] = "leftarrow"
        keys[vk_up] = "uparrow"
        keys[vk_right] = "rightarrow"
        keys[vk_down] = "downarrow"
        
        keys[42] = "print"
        keys[43] = "execute"
        keys[vk_printscreen] = "printscreen"
        keys[vk_insert] = "insert"
        keys[vk_delete] = "delete"
        
        keys[vk_0] = "0"
        keys[vk_1] = "1"
        keys[vk_2] = "2"
        keys[vk_3] = "3"
        keys[vk_4] = "4"
        keys[vk_5] = "5"
        keys[vk_6] = "6"
        keys[vk_7] = "7"
        keys[vk_8] = "8"
        keys[vk_9] = "9"
        
        keys[vk_a] = "a"
        keys[vk_b] = "b"
        keys[vk_c] = "c"
        keys[vk_d] = "d"
        keys[vk_e] = "e"
        keys[vk_f] = "f"
        keys[vk_g] = "g"
        keys[vk_h] = "h"
        keys[vk_i] = "i"
        keys[vk_j] = "j"
        keys[vk_k] = "k"
        keys[vk_l] = "l"
        keys[vk_m] = "m"
        keys[vk_n] = "n"
        keys[vk_o] = "o"
        keys[vk_p] = "p"
        keys[vk_q] = "q"
        keys[vk_r] = "r"
        keys[vk_s] = "s"
        keys[vk_t] = "t"
        keys[vk_u] = "u"
        keys[vk_v] = "v"
        keys[vk_w] = "w"
        keys[vk_x] = "x"
        keys[vk_y] = "y"
        keys[vk_z] = "z"
        
        keys[91] = "win"
        keys[92] = "rwin"
        
        keys[vk_numpad0] = "kp_0"
        keys[vk_numpad1] = "kp_1"
        keys[vk_numpad2] = "kp_2"
        keys[vk_numpad3] = "kp_3"
        keys[vk_numpad4] = "kp_4"
        keys[vk_numpad5] = "kp_5"
        keys[vk_numpad6] = "kp_6"
        keys[vk_numpad7] = "kp_7"
        keys[vk_numpad8] = "kp_8"
        keys[vk_numpad9] = "kp_9"
        keys[106] = "kp_multiply"
        keys[107] = "kp_add"
        keys[108] = "separator"
        keys[109] = "kp_subtract"
        keys[110] = "kp_decimal"
        keys[111] = "kp_divide"
        keys[112] = "f1"
        keys[112] = "f2"
        keys[114] = "f3"
        keys[115] = "f4"
        keys[116] = "f5"
        keys[117] = "f6"
        keys[118] = "f7"
        keys[119] = "f8"
        keys[120] = "f9"
        keys[121] = "f10"
        keys[122] = "f11"
        keys[123] = "f12"
        
        keys[144] = "numlock"
        keys[145] = "scroll"
        
        keys[160] = "shift"
        keys[161] = "rshift"
        keys[162] = "l_ctrl"
        keys[163] = "r_ctrl"
        keys[164] = "l_alt"
        keys[165] = "r_alt"
        
        keys[186] = ";"
        keys[187] = "="
        keys[188] = ","
        keys[189] = "-"
        keys[190] = "."
        keys[191] = "/"
        keys[192] = "`"
        
        keys[219] = "["
        keys[220] = @"\"
        keys[221] = "]"
        keys[222] = "'"
        
        keys[250] = "play"
        keys[254] = "clear"
        
        keys[vk_any] = "any"
        
        for ( var i = 1; i < 255; i++ ) {
            if keys[i] = undefined
                keys[i] = "key_" + string(i)
        }
        return input_key_to_name( keycode )
    }
}