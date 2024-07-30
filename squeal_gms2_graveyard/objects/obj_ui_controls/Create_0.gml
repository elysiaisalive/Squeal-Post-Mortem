selected		= 0;
pressed			= false;

//#macro println		show_debug_message
#macro console_log	log_to_file

#region Inputs
INPUT_UP		= 0;
INPUT_DOWN 		= 0;
INPUT_LEFT 		= 0;
INPUT_RIGHT		= 0;
INPUT_CLICK		= 0;
#endregion

scr_input_display_refresh();

text_offset_x		= camera_get_view_x(CURRENT_VIEW) + 220;
text_offset_y		= camera_get_view_y(CURRENT_VIEW) + 10;