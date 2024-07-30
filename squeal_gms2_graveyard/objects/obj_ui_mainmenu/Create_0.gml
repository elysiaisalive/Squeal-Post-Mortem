title_sprite		= spr_title;
title_index = sprite_get_number( title_sprite )
background			= choose( spr_mainmenu_background_slaughter );
background_index	= 0;
BGIsAnimated		= false;
anim_spd			= 0;
ui_options_alpha	= 0;
color				= 0;
color2				= 0;

siner				= 0;

controller	= new element_get_input();

play		= new create_mainmenu_button( 52, 112, 96, 32, "PLAY", spr_ui_mainmenu_start );
play.OnClick = function()
{
	change_room( rm_levelselect );
};

extras		= new create_mainmenu_button( 52, 144, 96, 32, "EXTRAS", spr_ui_mainmenu_extras );

options		= new create_mainmenu_button( 52, 176, 96, 32, "OPTIONS",spr_ui_mainmenu_settings );
options.OnClick = function()
{
		change_room( rm_controls );
}

quit		= new create_mainmenu_button( 52, 208, 96, 32, "EXIT", spr_ui_mainmenu_exit );
quit.OnClick = function()
{
	game_end();
}