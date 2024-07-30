event_inherited();
setPropHeight( 60 );

image_speed = 0;

shadow_depth = 0.6;
anim_spd	= 0;
cam_dir		= image_angle;
cam_movetype = image_angle;
cam_lightindex	= 0;
cam_emitter = audio_emitter_create();
//audio_emitter_position( cam_emitter, x, y, z );

//var sound = audio().GetSound( @"environment\env_camera_turn" );

//playsound_on( cam_emitter, sound, 4, 8, 1, true );

Solid_RemoveFlag( BLOCK_ALL );