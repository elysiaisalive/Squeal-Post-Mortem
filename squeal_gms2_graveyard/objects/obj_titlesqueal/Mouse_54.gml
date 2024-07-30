selected = selected
playsound(select_sound, false);
switch(sub_option)
{
	case Sub_Menu:
		sub_option = Main_Menu
		config_save();
		break;
	case Volume_Menu:
		if pressed = 1
		pressed = 0 else
		sub_option = Sub_Menu
		break;
	case Graphics_Menu:
		if pressed = 1
		pressed = 0 else
		sub_option = Sub_Menu
		break;
	case Cursor_Menu:
		if pressed = 1
		pressed = 0 else
		sub_option = Graphics_Menu
		break;
	case Cursor_Custom:
		if pressed = 1
		pressed = 0 else
		sub_option = Cursor_Menu
		break;
}