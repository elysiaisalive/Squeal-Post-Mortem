playsound(select_sound, false);
switch(sub_option)
	{
		case Main_Menu:
			switch(selected)
			{
				case 0: // Start
					break;
				case 1: // Chapters
					room_goto(rm_levelselect);
					break;
				case 2: // Extras
					break;
				case 3: // Options
					sub_option = Sub_Menu
					break;
				case 4: // Quit
					sub_option = Quit_Menu
					break;
			}
		case Sub_Menu:
			switch(selected)
			{
				case 0: // Volume
					sub_option = Volume_Menu
					break;
				case 1: // Controls
					//room_goto(rm_controls)
					break;
				case 2: // Graphics
					sub_option = Graphics_Menu
					break;   
			}
				break;
		case Volume_Menu:
			switch(selected)
			{
				case 0: // Master Volume
					pressed = 1
					break;
				case 1: // Music Volume
					pressed = 1
					break;
				case 2: // SFX Volume
					pressed = 1
					break;
			}
				break;
		case Graphics_Menu:
			switch(selected)
			{
				case 0: // Cursor Customization
					sub_option = Cursor_Menu
					break;
				case 1: // ???
					break;
				case 2: // ???
					break;
			}
				break;
		case Cursor_Menu:
			switch(selected)
			{
				case 0: // Cursor Type: Default | Alternate | Custom
					sub_option = Cursor_Custom
					break;
				case 1: // Cursor Style
					if ( obj_control.cursor_type = CURSOR.ALT )
						pressed = 1
					break;
				case 2: // Size
					pressed = 1
					break;
				case 3: // Anim Speed
					if ( obj_control.cursor_type = CURSOR.ALT )
						pressed = 1
					break;
			}
				break;
		case Cursor_Custom:
			switch(selected)
			{
				case 0: // Cursor Customization
					pressed = 1
					break;
			}
				break;
	}