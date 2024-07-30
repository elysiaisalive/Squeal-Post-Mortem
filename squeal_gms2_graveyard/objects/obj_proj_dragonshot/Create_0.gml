event_inherited();

//whizz_fast = choose(snd_whizzslow1, snd_whizzslow2)

//whizz = audio_emitter_create();
//audio_falloff_set_model(audio_falloff_exponent_distance);
//audio_emitter_falloff(whizz, 8 * 2, 8 * 4, 2);
//audio_emitter_gain(whizz, global.settings.vol_sfx_volume * global.settings.vol_master_volume);
//audio_play_sound_on(whizz, whizz_fast, true, 0)

image_speed = 0.8;
bullet_color = merge_color(c_orange, c_red, random(1));
fire_delay = random_range(1, 4);