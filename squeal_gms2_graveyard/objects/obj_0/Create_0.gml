music_play( "menu_0.ogg", true );

caption = choose(
	"ウボァ",
	"恐怖きょうふ",
	"ぐろい",
	"ぞっとする",
	"肝きもを冷ひやす",
	"忌いまわしい"	
);
caption_timer = random_range( 1, 25 );
background_c = c_black;
text_c = c_white;
text_a = 1;
siner = 0;
scare_amount = 0;
scare_max = irandom_range( 1, 32 );
scale = 1;
sound_play = false;

window_set_caption( caption );

global.settings.music_volume = 1.0;
global.settings.vol_master_volume = 1.0;