event_inherited();
setPropHeight( 45 );

drivepath = path_add();

// controller = new cAILAV( self.id, "LAV" );
// controller.shots_left			= 4;
// controller.max_shots			= 4;

shot_timer		= new cTimer( 60 * 2 );
shot_timer.OnTimerEnd = function()
{
	shot_timer.SetTime( shot_timer.set_maxtime );
};

shot_delaytimer = new cTimer( 60 * 1 );
shot_delaytimer.OnTimerEnd = function()
{
	shot_delaytimer.SetTime( shot_delaytimer.set_maxtime );
};

turret = instance_create_depth( x, y, depth, obj_lav_turret );
shake = 0;

on_proj_hit = function()
{
	effects_impact_metalspark( proj_hit_id );
	return true;
};

turret.x = x + turret.turret_x;
turret.y = y + turret.turret_y;

turret_x        = 0;
turret_y        = 0;
turret_dir      = 0;

shot_sound = audio().GetSound( @"environment\LAV\lav_shot" );
engine_sound = audio().GetSound( @"environment\LAV\lav_engineloop" );

engine_emitter			= audio_emitter_create();
// audio_emitter_falloff( engine_emitter, 16 * 8, 16 * 38, 5.75 );
// audio_falloff_set_model( audio_falloff_exponent_distance_scaled );
// audio_emitter_position( engine_emitter, x, y, 1 );

// if ( !audio_is_playing( engine_sound ) )
// {
// 	audio_play_sound_on( engine_emitter, engine_sound, true, -1 );
// }