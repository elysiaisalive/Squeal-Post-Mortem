selected		= 0;
pressed			= false;

#region Inputs
INPUT_UP		= 0;
INPUT_DOWN 		= 0;
INPUT_LEFT 		= 0;
INPUT_RIGHT		= 0;
INPUT_CLICK		= 0;
#endregion

page_yoffset	= 400;
glasses_xoffset	= -400;
badge_xoffset	= 800;

form_sprite		= spr_ui_choice_form;

anim_spd		= 0;
anim_checkbox	= 0;

print_time		= 40;
print_maxtime	= 40;

page_done		= false;

target_y		= room_height / 2;
target_maxy		= room_height / 2;

badgetarget_x	= room_width / 2 + 165;
glassestarget_x	= room_width / 2 - 165;

glasses_scale	= 1;
badge_scale		= 1;

rot				= 0;
rot_speed		= 0.1;

input_string	= "";
display_string	= "";

surf_x			= 169;
surf_y			= 235;

draw_surf		= surface_create( surf_x, surf_y );

justice_string	= "Justice is blind.\n 25% Accuracy Buff.\nLonger Combos.";
action_string	= "I'll give you a war you won't believe.\n25% More SloMo Time.\nMore points on SloMo Kills.";