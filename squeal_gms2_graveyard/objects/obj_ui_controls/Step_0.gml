#region Input Detection
INPUT_UP			= clamp(keyboard_check_pressed(ord("W")) + keyboard_check_pressed(vk_up) + mouse_wheel_up(), 0, 1)
INPUT_DOWN			= clamp(keyboard_check_pressed(ord("S")) + keyboard_check_pressed(vk_down) + mouse_wheel_down(), 0, 1)
INPUT_LEFT			= clamp(keyboard_check_pressed(ord("A")) + keyboard_check_pressed(vk_left) + mouse_wheel_up(), 0, 1)
INPUT_RIGHT			= clamp(keyboard_check_pressed(ord("D")) + keyboard_check_pressed(vk_right) + mouse_wheel_down(), 0, 1)
INPUT_LEFTCLICK		= clamp(keyboard_check_pressed(vk_enter) + mouse_check_button_pressed(mb_left), 0, 1)
INPUT_RIGHTCLICK	= clamp(keyboard_check_pressed(vk_escape) + mouse_check_button_pressed(mb_right), 0, 1)
INPUT_SPACE			= clamp(keyboard_check_pressed(vk_space), 0, 1)

if (INPUT_UP && !pressed)
{
	selected --
}
if (INPUT_DOWN && !pressed)
{
	selected ++
}
if (INPUT_LEFTCLICK && !pressed)
{
	pressed = true;
}
if (pressed)
{
	if (keyboard_check_pressed(vk_anykey))
	{
		println("CHANGING KEYBINDS")
		switch(selected)
		{
			// Rebind Function later
			#region Up Key
			case 0 : 
				var key = -1;
				for (var i = 0; i < 255; i ++)
					if (keyboard_check_direct(i))
					{
					key = i;
					}
				if (key != -1)
				{
					global.inputs.key_up = key
					scr_input_display_refresh();
					pressed = false;
				}
			#endregion
				break;
			#region Down Key
			case 1 : 
				var key = -1;
				for (var i = 0; i < 255; i ++)
					if (keyboard_check_direct(i))
					{
					key = i;
					}
				if (key != -1)
				{
					global.inputs.key_down = key
					scr_input_display_refresh();
					pressed = false;
				}
			#endregion
				break;
			#region Left Key
			case 2 : 
				var key = -1;
				for (var i = 0; i < 255; i ++)
					if (keyboard_check_direct(i))
					{
					key = i;
					}
				if (key != -1)
				{
					global.inputs.key_left = key
					scr_input_display_refresh();
					pressed = false;
				}
			#endregion
				break;
			#region Right Key
			case 3 : 
				var key = -1;
				for (var i = 0; i < 255; i ++)
					if (keyboard_check_direct(i))
					{
					key = i;
					}
				if (key != -1)
				{
					global.inputs.key_right = key
					scr_input_display_refresh();
					pressed = false;
				}
			#endregion
				break;
			#region Ability Key
			case 4 : 
				var key = -1;
				for (var i = 0; i < 255; i ++)
					if (keyboard_check_direct(i))
					{
					key = i;
					}
				if (key != -1)
				{
					global.specialkey = key
					scr_input_display_refresh();
					pressed = false;
				}
			#endregion
				break;
			#region Alt-Fire Key
			case 5 : 
				var key = -1;
				for (var i = 0; i < 255; i ++)
					if (keyboard_check_direct(i))
					{
					key = i;
					}
				if (key != -1)
				{
					global.altfirekey = key
					scr_input_display_refresh();
					pressed = false;
				}
			#endregion
				break;
			#region Look Key
			case 6 : 
				var key = -1;
				for (var i = 0; i < 255; i ++)
					if (keyboard_check_direct(i))
					{
					key = i;
					}
				if (key != -1)
				{
					global.inputs.key_zoom = key
					scr_input_display_refresh();
					pressed = false;
				}
			#endregion
				break;
		}
	}
}
if (INPUT_RIGHTCLICK && pressed)
{
	pressed = false;
}
else
if (INPUT_RIGHTCLICK && !pressed)
{
	room_goto_previous();
}

if (INPUT_SPACE)
{
	scr_input_display_refresh();
	config_save();
}

if (selected >= array_length(controls_list)) 
{
	selected = 0
}
if (selected < 0)
{
	selected = (array_length(controls_list) - 1)
}
#endregion