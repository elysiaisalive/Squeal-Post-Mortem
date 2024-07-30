var lastrm = room_last;

options = [];

siner = 0;

for( var i = 0; i < room_last; ++i )
{
	array_push( options, i );
};

music = [
	"menu_loli.ogg",
	"menu_xtal.ogg"
];

selected = 0;

controller	= new element_get_input();

quit		= new create_mainmenu_button( 152, 208, 96, 32, "EXIT", spr_ui_mainmenu_exit );
quit.OnClick = function()
{
	game_end();
}