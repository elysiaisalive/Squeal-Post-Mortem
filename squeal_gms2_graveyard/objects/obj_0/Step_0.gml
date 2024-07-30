caption_timer = max( 0, caption_timer - 1 );
siner += 0.8;

if ( caption_timer == 0 )
{
	global.shake = 0;

	caption = choose(
		"ウボァ",
		"恐怖きょうふ",
		"ぐろい",
		"ぞっとする",
		"肝きもを冷ひやす",
		"忌いまわしい"	
	);

	window_set_caption( caption );
	window_set_color( choose( c_black, c_white, c_red ) );
	caption_timer = random_range( 1, 25 );
}

window_set_position( x + random_range( -global.shake, global.shake ), y + random_range( -global.shake, global.shake ) );

if ( keyboard_check( vk_any ) || mouse_check_button_pressed( mb_any ) )
{
	background_c = c_red;
	text_c = c_red;
	scare_amount ++;
	global.shake = random_range( 5, 12 );
}

if ( global.shake == 0 )
{
	background_c = c_black;
	text_c = c_white;
}

if ( scare_amount == scare_max )
{
	background_c = c_red;
	text_a = 0;
	global.shake = random_range( 5, 12 );
	scale += random_range( 1, 4 );
	
	if ( !sound_play )
	{
		music_play( "track0.ogg", true );
		sound_play = true;
	}
	
	if ( scale >= 10 )
	{
		game_end();
	}
};