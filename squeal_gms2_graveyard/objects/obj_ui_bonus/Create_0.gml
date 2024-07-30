selected		= 0;
pressed			= false;

#region Inputs
INPUT_UP		= 0;
INPUT_DOWN 		= 0;
INPUT_LEFT 		= 0;
INPUT_RIGHT		= 0;
INPUT_CLICK		= 0;
#endregion

str_target		= "";
str_typed		= "";
str_index		= 1;

str2_target		= "";
str2_typed		= "";
str2_index		= 1;

timer			= 0;
timer_max		= 2;
animspd			= 0;
trophy_spr		= spr_DEFAULT;
trophy			= get_collectible();