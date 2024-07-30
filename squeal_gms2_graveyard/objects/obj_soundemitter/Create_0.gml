emitter = audio_emitter_create();
audio_falloff_set_model(audio_falloff_exponent_distance);
audio_emitter_falloff(emitter, 8 * 2, 120, 1.8);
audio_emitter_position(emitter, x, y, 1);
audio_play_sound_on(emitter, snd_healthstation_charge, true, 1);