z					= depth;
height				= 1;
depth				= z - height;
					
char_spd			= 0.1;
char_frc			= 0.1;
					
animspd				= 0;
					
done				= true;
animated			= false;

trail				= false;
trail_sprite		= spr_effect_chartrail_med;
trail_timer			= 0;
trail_timermax		= 2;

surfacetype			= obj_surface_manager.GetSurf();
image_speed			= 0;
